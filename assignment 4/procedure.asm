.586P
.MODEL FLAT, stdcall ; Flat Memory Model

PUBLIC PROCEDURE1

_TEXT SEGMENT ; Tells the assembler what type of the following is

.code
PROCEDURE1 PROC Prime: DWORD
MOV EAX, 0		;dividend
MOV EBX, 0		;divisor
MOV ECX, 0		;counter
MOV EDX, 0		;remainder

; Since 2 is considered a prime number, if the input is 2 just skip the loop and return prime
MOV EAX, Prime
MOV EBX, 2
CMP EAX, EBX
JLE endIsPrime

MOV ECX, 2		; intialize counter

; Documentation says that we should loop from 3 to n/2, but looping from 3 doesn't make sense since the program will believe 4 is a prime number
; since it only divides 4 by 3.

lp:					; loop from 2 to n/2.
	; setup for prime checking.
	MOV EAX, 0
	MOV EBX, 0
	MOV EDX, 0

	MOV EBX, ECX	; move counter value to ebx for division.
	INC ECX			; increment counter.
	MOV EAX, Prime
	DIV EBX			; divide number(EAX) by previous counter value.

	; check if prime.
	CMP EDX, 0		; If remainder is 0, then number is not prime
	JE endNotPrime

	; determine if we have reached the end of loop.
	MOV EAX, 0
	MOV EDX, 0
	MOV EBX, 0

	; divide inputted number by 2 and CMP the counter with the result.
	MOV EAX, Prime
	MOV EBX, 2
	DIV EBX
	CMP ECX, EAX
	JLE lp

endIsPrime:
	MOV EAX, 1
	RET

endNotPrime:
	MOV EAX, 0
	RET
	

PROCEDURE1 ENDP
_TEXT ENDS
END