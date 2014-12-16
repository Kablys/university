global _start

section .data

section .text

_start:
	; your code goes here
	mov eax, 4		; specify sys_write call
	mov ebx, 1		; specify file descriptor 1: standard output
	mov ecx, 		; pass the address of buffer to write
	mov edx, 		; pass the number of bytes the buffer has
	int 80h			; call sys_write

	je		exit

exit:
	mov		eax, 01h		; exit()
	xor		ebx, ebx		; errno
	int		80h

