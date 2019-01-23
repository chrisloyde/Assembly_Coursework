TITLE Lab 1					(main.asm)
INCLUDE Irvine32.inc
.data
msg BYTE "Hello",0dh,0ah,0
prompt BYTE "Enter 3 32bit Signed integers (x+y-z): ", 0
res BYTE "Result is: ", 0

.code
main PROC
	call Clrscr

	mov	 edx,OFFSET msg
	call WriteString
	call DumpRegs ; display register after printing message

	; Basic Math

	mov eax, 400  ; add 400 to eax register
	add eax, 200  ; add 200
	sub eax, 100  ; subtract 100
	call WriteDec ; call function to write decimal to console
	call DumpRegs ; dump register again

	; Extra credit input data

	mov edx, OFFSET prompt 
	call WriteString		; print prompt
	call Crlf				; new line
	call ReadInt			; input integer into EAX
	mov ebx, eax			; move eax to ebx
	call ReadInt
	mov ecx, eax
	call ReadInt
	mov edx, eax
	add ebx, ecx            ; add first and second
	sub ebx, edx			; subtract (added) from third
	mov eax, ebx			; move calculated result to eax
	mov edx, OFFSET res
	call WriteString		; write result string to console
	call WriteDec			; print decimal to console
	call Crlf				; new line

	exit
main ENDP

END main