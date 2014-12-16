.model small
.stack 100h

.data
	output	db	10, ?, 10 dup(0)	; vietoj 10 dub(0) galima "0000000000"
	
.code

start:
	mov 	dx, @data       ; perkelti data i registra ax
	mov 	ds, dx          ; nustatyti ds rodyti i data segmenta

	mov	cx, 0

print_char:
	mov	si, offset output + 10 	; si nurodyti į eilutės paskutinį simbolį !bugas turi buti 12
	mov	byte ptr [si], '$'     	; ten įkelti pabaigos simbolį

	mov	ax, cx		; paruošti išvedimui dešimtainį skaièiø, max 2 baitai, t.y. 2^16 - 1 = 65536 - 1 = 65535
	mov	bx, 10		; dalinti reikės iš 10

asc2:	
	mov	dx, 0		; išvalyti dx, nes èia bus liekana po div
	div	bx              ; div ax/bx, ir liekana padedama dx
	add 	dx, '0'         ; pridėti 48, kad paruošti simbolį išvedimui
	dec 	si		; sumaþinti si - èia bus padėtas skaitmuo
	mov	[si], dl	; padėti skaitmenį
	
	cmp 	ax, 0		; jei jau skaièius išdalintas
        jz 	print  	        ; tai eiti į pabaigą
        jmp 	asc2            ; kitu atveju imti kitą skaitmenį

print:
        mov	ah, 2            ; atspausdinti simbolį
        mov	dl, cl           ; įdėti simbolį
        int	21h
        mov	dl, '='		 ; įdėti '='
        int	21h

        mov	ah, 9            ; atspausdinti skaitmenis
        mov	dx, si
        int	21h

        mov	ah, 2            ; atspausdinti tab
        mov	dl, 9		 ; tab=9
        int	21h

	inc	cx
	cmp	cx, 11111111b	; maþiau, nei 256
	jle	print_char
	
	mov 	ah, 4ch 	; sustabdyti programa - http://www.computing.dcu.ie/~ray/teaching/CA296/notes/8086_bios_and_dos_interrupts.html#int21h_4Ch
	mov 	al, 0 		; be klaidu = 0
	int 	21h             ; 21h -  dos pertraukimmas - http://www.computing.dcu.ie/~ray/teaching/CA296/notes/8086_bios_and_dos_interrupts.html#int21h
end start
