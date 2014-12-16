; Programa: Nr. 002
;testingas
; Užduoties sąlyga: Programa, kurios pirmasis parametras - skaičius, visi kiti - failų vardai. Visus failus suskaidome į gabalus, kuriuos sudedame į failus, o jų pavadinimų priekyje įrašome bloko pavadinimą. Pvz.: jei eilutė yra split 200 failas.dat, tuomet failą failas.dat skaldomas po 200 simbolių ir sukuriami failai 1failas.dat, 2failas.dat, ir t.t.
; Atliko: Dominykas Ablingis

%macro WRITE_STRING 2
	mov eax, 4		; specify sys_write call
	mov ebx, 1		; specify file descriptor 1: standard output
	mov ecx, %1		; pass the address of buffer to write
	mov edx, %2		; pass the number of bytes the buffer has
	int 80h			; call sys_write
%endmacro

section .data 
	helpMsg db '2run [SIZE] [FILENAME] ', 0xa
	helpMsgLen equ $ - helpMsg

	magnitude db 10

section .bss
;	magnitude db 1

	fd_out resb 4 	;reserve four byte for output file descriptor	
	fd_in  resb 4 	;reserve four byte for input file descriptor

	size   resb 4 	;holds number of into how many parts can file be split
	
	mainName   resb 255 ;max filename length
	mainNamelen   resb 1 ;max filename length
	partName   resb 255 ;max filename length

	fileNum resb 1
	amount resb 1
	;text   resb 10
	buff   resb 4096 ; hardware block size for my hard drive
	;/sys/block/sda/queue/physical_block_size

section	.text
		global _start 	  ; must be declared for linker

_start:
		pop ebx; 		;argc
		cmp ebx, 3 		;if 1-filename, 2-first arg, 3-second arg
		jne printHelp 	;if not enoth arguments
		jmp beginProgram
		
printHelp:
		WRITE_STRING helpMsg, helpMsgLen		
		jmp done;

beginProgram:
		pop ebx 		;we ignore this argv[0] - programs name
		pop edx 		;first argumet should be number so we convert it
		xor eax, eax
ConvertFromASCIItoInt:
		movzx ecx, byte [edx] ;movzx nukopijuoja o likusius bitus nunulina
		inc edx
		cmp ecx, '0' 
		jb LastNumber
		cmp ecx, '9'
		ja LastNumber
		sub ecx, '0'
		imul eax, 10
		add eax, ecx
		jmp ConvertFromASCIItoInt
LastNumber:
		mov dword [size], eax

;Get filename
		pop esi 		;File name for spliting
		mov edi, mainName
		mov ecx, 0
		CopyNextChar:
		cmp byte [esi], 0
		je LastChar
		movsb
		inc ecx
		jmp CopyNextChar

LastChar:
		mov [mainNamelen], ecx
		mov al, 0
		stosb

; open Main file
		mov eax, 5
		mov ebx, mainName 
		mov ecx, 0
		mov edx, 0666q
		int 80h
		mov [fd_out], eax


		mov byte [fileNum], 0
		
readFromMainFile:
		mov eax, 3 		;sys_read
		mov ebx, [fd_out]
		mov ecx, buff
		mov edx, [size]
		int 80h

		inc byte [fileNum]
		cmp byte[fileNum], 255 	;length of text buffer
		je done
		cmp eax, [size] 	;length of text buffer
		je calculateNumber
		jmp done

;testIfEnd;
		
calculateNumber:
		mov edi, partName
		mov ecx, 5
		mov bx, 10000 	; Divisor (max value of bx = 65535
		movzx ax, byte [fileNum] ; Dividend
getNumber:
		div bx
		;cmp
		add ax, '0'
		stosw 	;From AX -> DI
		;mov dh, ah
		mov ax, bx 	; put Divisor to ax register
		div byte [magnitude] ; divide Divisor by 10
		mov bx, ax
		mov ax, dx
		loop getNumber
		
		movzx ecx, byte [mainNamelen]
		mov esi, mainName
getName:
		movsb
		loop getName

makeFile:
		mov al, 0 ;File names must end with \0 in Linux
		stosb

		mov eax, 8 		;sys_create
		mov ebx, partName 	;name of the file
		mov ecx, 0666q 	;read, write, all
		int 80h
		mov [fd_in], eax

; write into new file
		mov eax, 4
		mov ebx, [fd_in]
		mov ecx, buff
		mov edx, [size]
		int 80h

; close the file
		mov eax, 6 		;sys_close
		mov ebx, [fd_in]
jmp readFromMainFile

finalWrite:

		mov  [size], eax
; create first file for split
		mov eax, 8 		;sys_create
		mov ebx, partName 	;name of the file
		mov ecx, 0666q 	;read, write, all
		int 80h
		mov [fd_in], eax

; write into new file
		mov eax, 4
		mov ebx, [fd_in]
		mov ecx, buff
		mov edx, [size]
		int 80h

; close the file
		mov eax, 6 		;sys_close
		mov ebx, [fd_in]

; close the Main file
		mov eax, 6 		;sys_close
		mov ebx, [fd_out]


done:	mov	eax,1	  ; specify sys_exit
        mov	ebx,0	  ; return code 0 on exit
        int	0x80	  ; call sys_exit



; read from file
		mov eax, 3 		;sys_read
		mov ebx, [fd_out]
		mov ecx, buff
		mov edx, 10
		int 80h

; create second file for split
		mov eax, 8 		;sys_create
		mov ebx, buff 	;name of the file
		mov ecx, 0666q 	;read, write, by all
		int 80h
		;sekmingai atliku operacija eax laiko nuoroda i sukurta faila
		mov [fd_in], eax

; write into new file
		mov eax, 4
		mov ebx, [fd_in]
		mov ecx, buff
		mov edx, 10
		int 80h

; close the half2 file
		mov eax, 6 		;sys_close
		mov ebx, [fd_in]
