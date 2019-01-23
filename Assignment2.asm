TITLE Lab 2					(main.asm)
INCLUDE Irvine32.inc

; Lab 2: DIY Multiplier
; Part 1 (Call Mul from procedure):
;	In a procedure, multiply two numbers together using mul.
;	Procedure should be called from main procedure.
; Part 2 (Do bitwise multiplication using only shift and add statements):
;	In multiplication procedure multiply two numbers not using mul.
;	Multiply 8 bit numbers (no loop) by combining a fixed number of shift and add commands.
; Part 3 (Add Loop to bitwise multiplication procedure):
;	Instead of using a fixed number of bitwise multipliers, use a loop to run the bitwise multiplication.
; EC:
;	Create a bitwise division procedure.

multiplication PROTO,
	val1:WORD, val2:WORD
division PROTO

.data
msg BYTE "Lab 2",0dh,0ah,0

.code
main PROC
	call Clrscr

	mov edx, OFFSET msg
	call WriteString

	; set all registers to 0
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

	INVOKE multiplication, 5, 4

	Call division

	exit

main ENDP

multiplication PROC,
	val1:WORD, val2:WORD
	; Part 1
	mov ax, val1
	mov bx, val2
	mul bx		; multiply ebx and eax
	call DumpRegs	
	call WriteInt
	call Crlf
	; reset registers to 0
	mov eax, 0
	mov ebx, 0

	; For part 2 and 3 parameters are not being used since there appears to be no
	; relation between multicand, multiplier, and amount of times to shift.

	; Part 2
	; Multiplying 4 * 4 to get 16 or 10h in the EAX register
	mov al, 4
	shl al, 2

	call DumpRegs
	call WriteInt
	call Crlf
	; reset registers to 0
	mov eax, 0

	; Part 3

	; Multiplying 4 * 32 to get 128 or 80h
   	mov bx, 4	; multicand
	; cx will opearte as a counter, where cl is the counter and ch is the max counts.
	mov cl, 0	; counter
	mov ch, 5	; max counter, number of times 4 needs to be shifted to get to 128

	lp_m:
		shl bx, 1 ; shift multicand by 1 to the left
		add cl, 1	; add 1 to the counter
		cmp ch, cl
		jg lp_m		; if the counter is less then max, do loop procedure again.

	mov ax, bx ; move the answer to EAX register
	call DumpRegs
	call WriteInt
	call Crlf

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	ret
multiplication ENDP

division PROC
	; Extra Credit
	; divide 64 by 16 using bitwise operations and loops
	; answer will be 4
	mov bx, 64
	mov cl, 0
	mov ch, 4	; number of shifts to get from 64 to 16.

	lp_d:
		shr bx, 1 ; shift divisor by 1 to the right
		add cl, 1 ; add 1 to the counter
		cmp ch, cl
		jg lp_d	

	mov ax, bx ; move answer to EAX register
	call DumpRegs
	Call WriteInt
	call Crlf

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	ret
division ENDP

END main