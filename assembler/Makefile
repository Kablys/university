make:1uzduotis.s
	#BAD
	#nasm -f elf -l 1uzduotis.lst 1uzduotis.s
	#gcc -o 1uzduotis 1uzduotis.o
	nasm -f elf -g -F dwarf -l 1uzduotis.lst 1uzduotis.s
	ld -m elf_i386 -o hello 1uzduotis.o

clean:
	rm -f hello 1uzduotis.o 1uzduotis.lst

