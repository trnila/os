; set our start instruction address to allow relative addresses
[org 0x7c00]

loop:
	; print "Loading operating system"
	mov bx, loadingString
	call printString

	; set stack pointer
	mov bp, 0x8000
	mov sp, bp

	; load our kernel from disk
	mov bx, 0x9000 ; load it to 0x9000
	mov dh, 5 ; read 5 sectors
	mov dl, 0 ; from drive 0
	call diskLoad

	; jump to our loaded code
	jmp 0x0000:0x9000

	jmp $

%include "boot/printString.s"
%include "boot/printHex.s"
%include "boot/diskLoad.s"

loadingString:
	db `Loading operating system...\r\n\0`

; fill the rest of sector with zeroes
times 510-($-$$) db 0

; place magic boot flag
dw 0xaa55

; here are data in next 512b sector
mov bx, loadingString
call 0x0000:printString
mov bx, loadingString
call 0x0000:printString

mov ah, 0x0e
mov al, 'D'
int 0x10

jmp $
