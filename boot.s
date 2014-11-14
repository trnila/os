; set our start instruction address to allow relative addresses
[org 0x7c00]

loop:
	mov bx, name
	call printString

	mov dx, 0x1fbf
	call printHex

	jmp $


; prints string to screen
; bx - string terminated with 0
printString:
	; Write Text in Teletype Mode
	mov ah, 0x0e

	printStringNext:
	; mov data on address bx to al
	mov al, [bx]

	; check if got string terminator \0
	cmp al, 0
	je printStringEnd

	; print it
	int 0x10

	; increment address of string
	inc bx
	jmp printStringNext

	printStringEnd:
	ret


; print hexa number to screen
; dx - number to print
printHex:
	; set counter to address of first bit
	mov bx, hexOut + 5

	printHexNext:
	; check if we are at end
	cmp bx, hexOut + 1
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
	mov bx, hexOut
	call printString
	ret

	printHexNum:
	add dx, '0'
	jmp printHexCont

	; string that we are writting to
	hexOut: db '0x0000', 0

name:
	db "Hello world!", 0

; fill the rest of sector with zeroes
times 510-($-$$) db 0

; place magic boot flag
dw 0xaa55
