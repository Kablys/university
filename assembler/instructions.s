INC COUNT        ; Increment the memory variable COUNT
MOV TOTAL, 48    ; Transfer the value 48 in the
                 ; memory variable TOTAL
ADD AH, BH       ; Add the content of the 
                 ; BH register into the AH register
AND MASK1, 128   ; Perform AND operation on the 
                 ; variable MASK1 and 128
ADD MARKS, 10    ; Add 10 to the variable MARKS
MOV AL, 10       ; Transfer the value 10 to the AL register
INT 			 ; Interut

CLD ;clean direction flag (foward,increment)
STD ;set direction flag (backwards)

MOVSB ;form Si to Di byte
SCASB ;search for byte placed AL in DI
LODSB ;SI->al
STOSB ;al->DI

rep ;while ecx != 0 and ZF
