; Programa: Nr. 002

; Užduoties sąlyga: Programa, kurios pirmasis parametras - skaičius, visi kiti - failų vardai. Visus failus suskaidome į gabalus, kuriuos sudedame į failus, o jų pavadinimų priekyje įrašome bloko pavadinimą. Pvz.: jei eilutė yra split 200 failas.dat, tuomet failą failas.dat skaldomas po 200 simbolių ir sukuriami failai 1failas.dat, 2failas.dat, ir t.t.
; Atliko: Dominykas Ablingis

%macro WRITE_STRING 2
	mov eax, 4		; specify sys_write call
	mov ebx, 1		; specify file descriptor 1: standard output
	mov ecx, %1		; pass the address of buffer to write
	mov edx, %2		; pass the number of bytes the buffer has
	int 80h			; call sys_write
%endmacro

%macro SYS_CALL 4
	mov eax, %1		; specify sys_write call
	mov ebx, %2		; specify file descriptor 1: standard output
	mov ecx, %3		; pass the address of buffer to write
	mov edx, %4		; pass the number of bytes the buffer has
	int 80h			; call sys_write
%endmacro

%define SYS_WRITE 4
%define SYS_READ 3
%define SYS_CREATE 8
%define SYS_OPEN 5
%define STDOUT 1
%define STDOUT 1

section .data 
	main db 'Main.txt', 0
	mainLen equ $ - main

	half1 db 'half1.txt', 0
	half1len equ $ - half1

	half2 db 'half2.txt', 0
	half2Len equ $ - half2

	output db '0123456789abcdefghijk', 0xa
	outputLen equ $ - output

	helpMsg db '2run [SIZE] [FILENAME] ', 0xa
	helpMsgLen equ $ - main

section .bss
	fd_out resb 4 	;reserve one byte for output file descriptor	
	fd_in  resb 4 	;reserve one byte for input file descriptor
	size   resb 4 	;holds number of into how many parts can file be split
	name   resb 255 ;max filename length
	text   resb 10
	buff   resb 4096 ; hardware block size for my hard drive
	;/sys/block/sda/queue/physical_block_size

section	.text
		global _start 	  ; must be declared for linker

_start:
;		mov size, 10 	;TODO remove
		pop ebx; 		;argc
		cmp ebx, 3 		;if 1-filename, 2-first arg, 3-second arg
		jne printHelp
		jmp begin
		
printHelp:
		WRITE_STRING helpMsg, helpMsgLen		
		jmp done;

begin:
		pop ebx 		;we ignore this argv[0] - programs name
		pop edx 		;first argumet should be number so we convert it
		xor eax, eax
top:
		movzx ecx, byte [edx] ;movzx nukopijuoja o likusius bitus nunulina
		inc edx
		cmp ecx, '0' 
		jb bottom
		cmp ecx, '9'
		ja bottom
		sub ecx, '0'
		imul eax, 10
		add eax, ecx
		jmp top
bottom:
		mov dword [size], eax
stop:
		pop ebx 		;File name for spliting
		
		
;create Main.txt file that gona be split
		mov eax, 8 		;sys_create
		mov ebx, main 	;name of the file
		mov ecx, 0666q 	;read, write, by all
		int 80h
		;sekmingai atliku operacija eax laiko nuoroda i sukurta faila
		mov [fd_out], eax

; write into Main file
		mov eax, 4
		mov ebx, [fd_out]
		mov ecx, output
		mov edx, outputLen
		int 80h

; open Main file
		mov eax, 5
		mov ebx, main
		mov ecx, 0
		mov edx, 0666q
		int 80h
		mov [fd_out], eax

readFromMainFile:
		mov eax, 3 		;sys_read
		mov ebx, [fd_out]
		mov ecx, text
		mov edx, 10
		int 80h
		cmp eax, 10 	;length of text buffer
		je create
		je finalWrite

;testIfEnd;
		
create:
;
		;mov ebp, name
		;mov byte [ebp + 1], main + 1;
; create first file for split
		mov eax, 8 		;sys_create
		mov ebx, half1 	;name of the file
		mov ecx, 0666q 	;read, write, all
		int 80h
		mov [fd_in], eax

; write into new file
		mov eax, 4
		mov ebx, [fd_in]
		mov ecx, text
		mov edx, 10
		int 80h

; close the file
		mov eax, 6 		;sys_close
		mov ebx, [fd_in]
jmp readFromMainFile

finalWrite:

		mov  [size], eax
; create first file for split
		mov eax, 8 		;sys_create
		mov ebx, half2 	;name of the file
		mov ecx, 0666q 	;read, write, all
		int 80h
		mov [fd_in], eax

; write into new file
		mov eax, 4
		mov ebx, [fd_in]
		mov ecx, text
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
		mov ecx, text
		mov edx, 10
		int 80h

; create second file for split
		mov eax, 8 		;sys_create
		mov ebx, half2 	;name of the file
		mov ecx, 0666q 	;read, write, by all
		int 80h
		;sekmingai atliku operacija eax laiko nuoroda i sukurta faila
		mov [fd_in], eax

; write into new file
		mov eax, 4
		mov ebx, [fd_in]
		mov ecx, text
		mov edx, 10
		int 80h

; close the half2 file
		mov eax, 6 		;sys_close
		mov ebx, [fd_in]
