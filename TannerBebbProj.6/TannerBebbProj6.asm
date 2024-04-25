;Tanner Bebb assembly language project 6

INCLUDE Irvine32.inc

.data

	Menu BYTE "---- Boolean Calculator ----", 0dh, 0ah
		 BYTE 0dh, 0ah
		 BYTE "1.) X AND Y", 0dh, 0ah
		 BYTE "2.) X OR Y", 0dh, 0ah
		 BYTE "3.) NOT X", 0dh, 0ah
		 BYTE "4.) X XOR Y", 0dh, 0ah
		 BYTE "5.) Exit program", 0

	ANDPrompt BYTE "Boolean AND", 0
	ORPrompt BYTE "Boolean OR", 0
	NOTPrompt BYTE "Boolean NOT", 0
	XORPrompt BYTE "Boolean XOR", 0
	ErrorPrompt BYTE "Please input a valid number: ", 0

	Number1 BYTE "Enter the first 32-bit integer: ", 0
	Number2 BYTE "Enter the second 32-bit integer: ", 0
	Result BYTE "The result is: ", 0

	caseTable BYTE "1"
		DWORD AND_op

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
	mov edx, OFFSET Menu										;Take the values stored in the Menu variable, and put them in the edx register.
	call WriteString											;Write the string that is stored in the edx register.
	call Crlf													;Insert a new line.

L1:
	call ReadChar												;Read the user's input.
	cmp al, '5'													;Compare the user's input to 5. This is the max amount of menu options.
	ja L2														;If the user enters a number greater than 5, Jump to the L2 tag.
	cmp al, '1'													;Compare the user's input to 1. This is the min amount of menu options.
	jb L2														;If the user enters a number less than5, Jump to the L2 tag.

	call Crlf													;Insert a new line.
	call ChooseProcedure										;Call the ChooseProcedure function.
	jc quit														;Go to the quit tag if the condtions are met.

L2:
	mov edx, OFFSET ErrorPrompt									;Take the value stored in the ErrorPrompt variable, and put it in the edx register.
	call WriteString											;Write the string to the screen that is stored in the edx register.
	call Crlf													;Insert a new line on the screen.
	jmp OperationScreen											;Jump back to the operationScreen tag.

quit:
	exit														;Exit the program.

main ENDP


ChooseProcedure PROC

	push ebx													;Push the ebx register to the ChooseProcedure stack.
	push ecx													;Push the ecx register to the ChooseProcedure stack.

	mov ebx, OFFSET caseTable									;Take the value stored in the caseTable variable, and put it into the ebx register.
	mov ecx, numberOfInputs										;Take the numberOfInputs, and put it into the ecx register.

L1:
	cmp al, [ebx]												;Compare the user's choice to the al register.
	jne L2														;If no, continue.
	call NEAR PTR [ebx + 1]										;If yes, call the choosen procedure.
	jmp L3														;Jump to the L3 tag.

L2:
	add ebx, inputSize											;Add the value of the variable inputSize to the value stored in the ebx register.
	loop L1														;Run the L1 tag again.

L3:
	pop ecx														;Remove ecx from the ChooseProcedure stack.
	pop ebx														;Remove ebx from the ChooseProcedure stack.
	ret															;Return to the main function.

ChooseProcedure ENDP


AND_op PROC

	pushad														;Push all registers to the stack.
	
	mov edx, OFFSET ANDPrompt									;Take the value stored in the ANDPrompt variable, and put it into the edx register.
	call WriteString											;Write the string that is stored in the edx register.
	call Crlf													;Insert a new line.
	
	mov edx, OFFSET Number1										;Take the value stored in the Number1 variable, and put it into the edx register.
	call WriteString											;Write the string that is stored in the edx register.
	call ReadHex												;Read the user's input
	mov ebx, eax												;Take what is in the eax register, and put it into the ebx register.

	mov edx, OFFSET Number2										;Take the value stored in the Number2 and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call ReadHex												;Read the user's input.

	and eax, ebx												;Multiply the two numbers that are in the ebx and eax registers.

	mov edx, OFFSET Result										;Take the value stored in the Result variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call WriteHex												;Write the hexidecimal value stored in result to the screen.
	call Crlf													;Insert a new line.

	popad														;Remove all the registers from the stack.
	
	ret															;Return to the main function.

AND_op ENDP


OR_op PROC

	pushad														;Push all registers to the stack.

	mov edx, OFFSET ORPrompt									;Take the value stored in the ORPrompt variable, and put it into the edx regsiter.
	call WriteString											;Write the current string that is stored in the edx register.
	call Crlf													;Insert a new line.

	mov edx, OFFSET Number1										;Take the value stored in the Number1 variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call ReadHex												;Read the user's input.
	mov ebx, eax												;Take what is in the eax register, and put it into the ebx register.

	mov edx, OFFSET Number2										;Take the value stored in the Number2 and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call ReadHex												;Read the user's input.

	or eax, ebx													;Add the two values that are stored in the ebx and eax registers.
	
	mov edx, OFFSET Result										;Take the value stored in the Result variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call WriteHex												;Write the hexidecimal value stored in result to the screen.
	call Crlf													;Insert a new line.

	popad														;Remove all the registers from the stack.

	ret															;Return to the main function.

OR_op ENDP


NOT_op PROC

	pushad														;Push all registers to the stack.

	mov edx, OFFSET NOTPrompt									;Take the value stored in the NOTPrompt variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call Crlf													;Insert a new line.

	mov edx, OFFSET Number1										;Take the value stored in the Number1 variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call ReadHex												;Read the user's input.
	mov ebx, eax												;Take what is in the eax register, and put it into the ebx register.

	mov edx, OFFSET Number2										;Take the value stored in the Number2 and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call ReadHex												;Read the user's input.

	not eax														;Invert each bit stored in the eax register.

	mov edx, OFFSET Result										;Take the value stored in the Result variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call WriteHex												;Write the hexidecimal value stored in result to the screen.
	call Crlf													;Insert a new line.

	popad														;Remove all the registers from the stack.

	ret															;Return to the main function.

NOT_op ENDP


XOR_op PROC

	pushad														;Push all registers to the stack.

	mov edx, OFFSET XORPrompt									;Take the value stored in the XORPrompt variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call Crlf													;Insert a new line.

	mov edx, OFFSET Number1										;Take the value stored in the Number1 variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call ReadHex												;Read the user's input.
	mov ebx, eax												;Take what is in the eax register, and put it into the ebx register.

	mov edx, OFFSET Number2										;Take the value stored in the Number2 and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call ReadHex												;Read the user's input.

	xor eax, ebx												;Compare the two values that are stored in the ebx and eax registers.

	mov edx, OFFSET Result										;Take the value stored in the Result variable, and put it into the edx register.
	call WriteString											;Write the current string that is stored in the edx register.
	call WriteHex												;Write the hexidecimal value stored in result to the screen.
	call Crlf													;Insert a new line.

	popad														;Remove all the registers from the stack.

	ret															;Return to the main function.

XOR_op ENDP


ExitProgram PROC

	stc															;Set the carry flag to 1.
	ret															;Return to the main function.

ExitProgram ENDP

END main