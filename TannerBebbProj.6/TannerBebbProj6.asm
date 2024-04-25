;Tanner Bebb assembly language project 6

INCLUDE Irvine32.inc

.data

	Menu BYTE "---- Boolean Calculator ----", 0dh, 0ah
		 BYTE 0dh, 0ah
		 BYTE "1.) ", 0dh, 0ah
		 BYTE "2.) ", 0dh, 0ah
		 BYTE "3.) ", 0dh, 0ah
		 BYTE "4.) ", 0dh, 0ah
		 BYTE "5.) ", 0

	ANDPrompt BYTE "Boolean AND", 0
	ORPrompt BYTE "Boolean OR", 0
	NOTPrompt BYTE "Boolean NOT", 0
	XORPrompt BYTE "Boolean XOR", 0
	ErrorPrompt BYTE "Please input a valid number", 0

	Number1 BYTE "Enter the first 32-bit integer", 0
	Number2 BYTE "Enter the second 32-bit integer", 0
	Result BYTE "The result is", 0

	caseTable BYTE "1"
		DWORD And_op

	inputSize = ($ - caseTable)
		BYTE '2'
		DWORD OR_op
		BYTE '3'
		DWORD NOT_op
		BYTE '4'
		DWORD XOR_op
		BYTE '5'
		DWORD ExitProgram

	numberOfInputs = ($ - caseTable) / inputSize

.code

main PROC

operationScreen:
	mov edx, OFFSET Menu
	call WriteString
	call Crlf

L1:
	call ReadChar
	cmp al, 5
	ja L2
	cmp al, 1
	jb L2

	call Crlf
	call ChooseProcedure
	jc quit

L2:
	mov edx, OFFSET ErrorPrompt
	call WriteString
	call Crlf
	jmp OperationScreen

quit:
	exit

main ENDP


ChooseProcedure PROC

	push ebx
	push ecx

	mov ebx, OFFSET caseTable
	mov ecx, numberOfInputs

L1:
	cmp al, [ebx]
	jne L2
	call NEAR PTR [ebx + 1]
	jmp L3

L2:
	add ebx, inputSize
	loop L1

L3:
	pop ecx
	pop ebx
	ret

ChooseProcedure ENDP


AND_op PROC

	pushad
	mov edx, OFFSET ANDPrompt
	call WriteString
	call Crlf

	mov edx, OFFSET Number1
	call WriteString
	call ReadHex
	mov ebx, eax

	mov edx, OFFSET Number2
	call WriteString
	call ReadHex

	and eax, ebx

	mov edx, OFFSET Result
	call WriteString
	call WriteHex
	call Crlf

	popad
	ret

AND_op ENDP


AND_or PROC

AND_or ENDP


AND_not PROC

AND_not ENDP


AND_xor PROC

AND_xor ENDP


ExitProgram PROC

ExitProgram ENDP

END main