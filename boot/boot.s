; set our start instruction address to allow relative addresses
[org 0x7c00]

loop:
	mov bx, name
	call printString

	mov dx, 0x1fbf
	call printHex

	jmp $

%include "boot/printScreen.s"
%include "boot/printHex.s"

name:
	db "Hello world!", 0

; fill the rest of sector with zeroes
times 510-($-$$) db 0

; place magic boot flag
dw 0xaa55
