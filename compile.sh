#!/bin/bash
as lolos.s -o lolos.o
ld -Ttext 0x7c00 --oformat=binary lolos.o -o lolos.bin
dd if=/dev/zero of=lolos.img bs=512 count=2880
dd if=lolos.bin of=lolos.img

qemu-system-i386 lolos.img
