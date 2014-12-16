.model small
.stack 100h

.data

.code

start:
	mov 	dx, @data  	; perkelti data i registra dx
	mov 	ds, dx 		; nustatyti ds rodyti i data segmenta
        
	mov 	ah, 4ch 	; sustabdyti programa - http://www.computing.dcu.ie/~ray/teaching/CA296/notes/8086_bios_and_dos_interrupts.html#int21h_4Ch
	mov 	al, 0 	    ; be klaidu = 0
	int 	21h			; 21h -  dos pertraukimmas - http://www.computing.dcu.ie/~ray/teaching/CA296/notes/8086_bios_and_dos_interrupts.html#int21h
end start
