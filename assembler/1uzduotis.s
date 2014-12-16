; Programa: Nr. 001

; Užduoties sąlyga: Parašykite programą, kuri įvestoje simbolių eilutėje didžiąsias ASCII raides pakeičia mažosiomis. Pvz.: įvedus aBcDEf54 turi atspausdinti abcdef54
; Atliko: Dominykas Ablingis
%macro WRITE_STRING 2
	mov eax, 4		; specify sys_write call
	mov ebx, 1		; specify file descriptor 1: standard output
	mov ecx, %1		; pass the address of buffer to write
	mov edx, %2		; pass the number of bytes the buffer has
	int 80h			; call sys_write

%endmacro

section	.data
		msg db 'Enter text to be manipulated or press Enter to quit: ', 0xa ; string
		msgLen equ $ - msg     						; length of string
		res db 'Result:', 0xa ; 0xa - 10 ascii symbol (new line)						
		resLen equ $ - res     						

section .bss 	;bss is for variables
		buffLen equ 1024 		; buffer length 1k
		buff: resb buffLen 		; REServe 5 Bytes for variable NUM

section	.text 	;text is for programe code
		global _start 	  ; must be declared for linker

_start:	      		      ; tells linker entry point
		nop				  ; For gdb

; User promt
		WRITE_STRING msg, msgLen

; Read and store the user input
read:	mov	eax, 3			; system call number (sys_read)
		mov	ebx, 0			; 0 standart input 	
		mov	ecx, buff		 
		mov	edx, buffLen	 
		int	0x80			; call kernels operation sys_read
		
		cmp eax, 1			; if only Enter was pressed TODO check if EAX=0 (if EOF)
		je done 			; exit from program
		mov esi, eax		; place the number of the bytes read into ecx

		mov ecx, esi 		; place the number of the bytes read into ecx(counter)
		mov ebp, buff 		; pass address of the buffer into ebp
		dec ebp 			; adjust count to offset

; Checkin and converting
scan: 	cmp byte [ebp + ecx], 'A' 	; test char against 'A'
;lodsb
		jb next 					; if bellow ascii 'A' not uppercase

		cmp byte [ebp + ecx], 'Z'
		ja next 					; if above ascii 'Z' not uppercase

		; at this point we know we have a uppercase
		add byte [ebp + ecx], 32 	; add 32 to make lowercase

next: 	loop scan 					;checks ecx if not zero dec ecx, else goes on
		
write:	WRITE_STRING res, resLen
		WRITE_STRING buff, esi
		jmp _start

done:	mov	eax,1	  ; specify sys_exit
        mov	ebx,0	  ; return code 0 on exit
        int	0x80	  ; call sys_exit
