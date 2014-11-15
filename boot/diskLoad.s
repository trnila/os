; loads disk sector to memory
; bx - address where we write data from disk
; dx - count of sectors to load
; dl - id of device
diskLoad:
	push dx

	; BIOS read sector
	mov ah, 0x02
	; read dh sectors from disk
	mov al, dh

	; cylinder 0
	mov ch, 0x00
	; head 0
	mov dh, 0x00
	; start from second sector, in first is MBR
	mov cl, 0x02

	int 0x13

	; on error, carry flag is set
	jc diskLoadError

	; restore original dx and compare it with total loaded sectors
	pop dx
	cmp dh, al
	jne diskLoadError

	ret

diskLoadError:
	mov bx, diskLoadErrorMsg
	call printString

	jmp $

diskLoadErrorMsg: db "Disk read error!"
