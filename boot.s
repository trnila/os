; set our start instruction address to allow relative addresses
[org 0x7c00]

loop:
	mov bx, name
	call printString

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

name:
	db "Hello world!", 0

; fill the rest of sector with zeroes
times 510-($-$$) db 0

; place magic boot flag
dw 0xaa55
