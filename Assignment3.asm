TITLE Lab 3					(main.asm)
INCLUDE Irvine32.inc

part1 PROTO
part2 PROTO
part3 PROTO
insertLine PROTO,
	val:DWORD

.data
	p1Prompt	BYTE "Part 1", 0Dh, 0Ah,0
	p2Prompt	BYTE "Part 2", 0Dh, 0Ah,0
	p3Prompt	BYTE "Part 3", 0Dh, 0Ah,0
	vowelMsg	BYTE "Vowel: ", 0
	conMsg		BYTE "Consonant: ", 0
	p1Array		BYTE 24 dup(?)
	p2Array		BYTE 50 dup(?)
	alphabet	BYTE 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
	vowel		DWORD 0, 4, 8, 14, 20, 24
	consonant	DWORD 1, 2, 3, 5, 6, 7, 9, 10, 11, 12, 13, 15, 16, 17, 18, 19, 21, 22, 23, 25

.code
main PROC 
	call Clrscr
	call Randomize			; call Randomize to ensure output is random everytime

	mov edx, offset p1Prompt
	call WriteString
	call part1
	call Crlf

	mov edx, offset p2Prompt
	call WriteString
	call part2
	call Crlf
	call Crlf

	mov edx, offset p3Prompt
	call WriteString
	call part3
	call Crlf

	call Crlf				; new line

	exit
main ENDP

insertLine PROC, 
	val:DWORD

	mov eax, val							
	mov [esi + 1 * ecx], eax	; move value to position in array
	add ecx, 4					; add 4 to counter

	; Add new line
	mov eax, 0Dh
	mov [esi + 1 * ecx], eax
	mov eax, 0Ah
	add ecx, 1
	mov [esi + 1 * ecx], eax
	add ecx, 1

	ret
insertLine ENDP

part1 PROC
	mov esi, offset p1Array	
	mov ecx, 0				; counter

	INVOKE insertLine,"DCBA"
	INVOKE insertLine,"HGFE"
	INVOKE insertLine,"LKJI"
	INVOKE insertLINE,"PONM"

	mov edx, esi
	call WriteString

	ret
part1 ENDP

part2 PROC
	mov esi, 0;
	mov esi, offset alphabet
	mov edi, offset p2Array
	mov ecx, 0
	jmp lp

	addNewLine:
		mov eax, 0Dh
		mov [edi + 1 * ecx], eax
		add ecx, 1
		mov eax, 0Ah
		mov [edi + 1 * ecx], eax
		jmp increment

	lp:
		mov eax, 26
		call RandomRange			; random between 0-26
		mov eax, [esi + 1 * eax]	; move random value from alphabet into eax

		; if position requires a new line
		; 4+(num of new lines) + counter
		cmp ecx, 4
		je addNewLine
		cmp ecx, 10
		je addNewLine
		cmp ecx, 16
		je addNewLine

		mov [edi + 1 * ecx], eax	; move ranodm value into p2Array
		
		increment:
			add ecx, 1
			cmp ecx, 18
			jle lp

	mov edx, edi
	call WriteString

	ret
part2 ENDP

part3 PROC
	mov eax, 2
	call RandomRange
	cmp eax, 0			; if eax == 0
	je printVowel		; printVowel

	jmp printConsonant	; else printConsonant
	
	printVowel:
		mov edx, offset vowelMsg
		call WriteString

		mov esi, offset vowel		; load vowel array
		mov eax, 6					; number of elements in vowel array
		call RandomRange

		mov eax, [esi + 4 * eax]	; get vowel alphabetical index(integer) from vowel array

		jmp end3

	printConsonant:
		mov edx, offset conMsg
		call WriteString

		mov esi, offset consonant	; load consonant array
		mov eax, 20					; number of elements in consonant array
		call RandomRange

		mov eax, [esi + 4 * eax]

		jmp end3
	end3:
		mov esi, offset alphabet	; load alphabet array
		mov eax, [esi + 1 * eax]	; get index from alphabet array using index retrieved from consonant or vowel array
		mov edx, eax				; move eax to edx to writechar
		call WriteChar
		ret
part3 ENDP

END main