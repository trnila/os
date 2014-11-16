[extern entry]

; here are data in next 512b sector
global _start
_start:
	mov ah, 0x0e
	mov al, 'D'
	int 0x10

	mov al, 'A'
	int 0x10

	mov al, 'X'
	int 0x10

;	call entry

	jmp $
