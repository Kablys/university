.model small
.stack 100h

.data
	output	db	10 dup(0)
	
.code

start:
	mov 	dx, @data       ; perkelti data i registra ax
	mov 	ds, dx          ; nustatyti ds rodyti i data segmenta

	mov	si, offset output + 10 	; si nurodyti į eilutės paskutinį simbolį
	mov	byte ptr [si], '$'     	; įkelti ten pabaigos simbolį

	mov	ax, 65535	; paruošti išvedimui dešimtainį skaičiø, max 2 baitai, t.y. 2^16 - 1 = 65536 - 1 = 65535
	mov	bx, 10		; dalinti reikės iš 10

asc2:	
	mov	dx, 0		; išvalyti dx, nes čia bus liekana po div
	div	bx          ; div ax/bx, ir liekana padedama dx
	add dx, '0'     ; pridėti 48, kad paruošti simbolį išvedimui
	dec si			; sumaþinti si - čia bus padėtas skaitmuo
	mov	[si], dl	; padėti skaitmenį
	
	cmp ax, 0		; jei jau skaičius išdalintas
    jz 	print  	    ; tai eiti į pabaigą
    jmp asc2        ; kitu atveju imti kitą skaitmenį

print:
        mov	ah, 9            ; atspausdinti skaitmenis
        mov	dx, si
        int	21h
	
	mov 	ah, 4ch 	; sustabdyti programa - http://www.computing.dcu.ie/~ray/teaching/CA296/notes/8086_bios_and_dos_interrupts.html#int21h_4Ch
	mov 	al, 0 		; be klaidu = 0
	int 	21h             ; 21h -  dos pertraukimmas - http://www.computing.dcu.ie/~ray/teaching/CA296/notes/8086_bios_and_dos_interrupts.html#int21h
end start	;programoje gali buti 1 end ir pagal ji nustato ka pirma vygdys
