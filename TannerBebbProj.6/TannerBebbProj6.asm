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

.code

main PROC

	exit

main ENDP

END main