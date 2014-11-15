; print hexa number to screen
; dx - number to print
printHex:
	; set counter to address of first bit
	mov bx, printHexMem + 5

	printHexNext:
	; check if we are at end
	cmp bx, printHexMem + 1
	jle printHexPrint

	; create copy of number because we will destroy him
	mov ax, dx

	; get value of last position -> 1111 mask
	and dx, 15

	; if number is smaller than 9 - add '0'
	cmp dx, 9
	jle printHexNum
	; otherwise add 'A'
	add dx, 'A' - 10

	printHexCont:
	; save result to output string, dl - we need to write just lower 8bit!
	mov [bx], dl

	; obtain copy of dx from ax
	mov dx, ax

	; move to previous position of number
	dec bx

	; rotate right
	shr dx, 4

	jmp printHexNext

	printHexPrint:
	mov bx, printHexMem
	call printString
	ret

	printHexNum:
	add dx, '0'
	jmp printHexCont

	; string that we are writting to
	printHexMem: db '0x0000', 0
