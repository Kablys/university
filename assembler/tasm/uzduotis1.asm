; Programa: Nr. 001
; Užduoties sąlyga: Parašykite programą, kuri įvestoje simbolių eilutėje didžiąsias ASCII raides pakeičia mažosiomis. Pvz.: įvedus aBcDEf54 turi atspausdinti abcdef54
; Atliko: Dominykas Ablingis

.model small
.stack 100h

.data
	msg    db      "Hello, World!", 0Dh,0Ah, 24h

.code

start:
	MOV dx, @data 	; perkelti data i registra dx
	MOV ds, dx 		; perkelti dx (data) i data segmenta

	mov     dx, offset msg
    mov     ah, 09h 
    int     21h 
        
	MOV ah, 4ch 	; griztame i dos'a
	MOV al, 0   	; be klaidu
	INT 21h     	; dos'o INTeruptas
end start
