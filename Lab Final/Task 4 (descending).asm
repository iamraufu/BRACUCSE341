.MODEL SMALL
 
.STACK 100H
.DATA 
ARR DB 5 DUP(?)
LEN DW $-ARR 
X DB "INPUT: $"  
Y DB "SORTED ARRAY: $"
.CODE 


START:
MOV AX,DATA
MOV DS,AX
MOV SI,0

LEA DX,X
MOV AH,9     
INT 21H 


FOR:
CMP SI,5
JE P
MOV AH,1      ; TAKING INPUT FROM USER
INT 21H      

SUB AL,30H
MOV ARR[SI],AL 
ADD SI,1
LOOP FOR

P:
MOV SI,0

MOV DL,0AH    ;PRINT NEWLINE 
MOV AH,2
INT 21H 
MOV DL,0DH
MOV AH,2
INT 21H

MOV CX,LEN-1
MOV SI,0

OUTER:
LEA SI,ARR
MOV BX,0
INNER:
INC BX
MOV AL,ARR[SI]
INC SI
CMP AL,ARR[SI]
JB SKIP
XCHG AL,ARR[SI]
MOV ARR[SI-1],AL
SKIP:
CMP BX,CX
JL  INNER
LOOP OUTER 

MOV SI,4


PRINT:

LEA DX,Y
MOV AH,9     
INT 21H

PRINT_:
MOV DL,ARR[SI] 
ADD DL,30H  
MOV AH,2
INT 21H
CMP SI,0H
JE EXIT
DEC SI

LOOP PRINT_

EXIT:  

MOV AH,4CH
INT 21H


CODE ENDS
END START