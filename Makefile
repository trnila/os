OBJS = $(wildcard kernel/*.c)

all: os.img

# combine image with MBR and kernel
os.img: boot/boot.bin kernel/kernel.bin
	cat $^ > $@

# compile MBR bootloader
boot/boot.bin : boot/*.s
	nasm boot/boot.s -f bin -o $@

# compile assamblers in kernel - especialy main.s
kernel/%.s.o: kernel/%.s
	nasm $< -f elf -o $@

# compile c in kernel
kernel/%.c.o: kernel/%.c
	gcc -m32 -ffreestanding -masm=intel -c $< -o $@

# compile all .o into kernel binary
kernel/kernel.bin: kernel/main.s.o ${OBJS:=.o}
	ld -o $@ -Ttext 0x9000 --oformat binary -m elf_i386 $^

clean:
	rm -f boot/*.bin
	rm -f kernel/*.o
	rm -f os.img
	rm -f kernel.bin

run:
	# start with Continue
	echo c | bochs -f bochsrc -q

# gcc -ffreestanding -masm=intel -c test.c -o test.o
