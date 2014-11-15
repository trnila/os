os.img: boot/boot.o
	cat $^ > $@

boot/boot.o: boot/*.s
	nasm boot/boot.s -f bin -o $@

clean:
	rm -f boot/boot.o
	rm -f os.img

run:
	# start with Continue
	echo c | bochs -f bochsrc -q
