
.text
    .globl _start;

_start:

	movb $'d' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $'a' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $'n' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $'i' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $'e' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $'l' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $' ' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $'l' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $'e' , %al
	movb $0x0e, %ah
	int  $0x10

	movb $'l' , %al
	movb $0x0e, %ah
	int  $0x10

	. = _start + 510
	.byte 0x55
	.byte 0xaa
