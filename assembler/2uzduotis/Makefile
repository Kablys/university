make:2uzduotis.s
	nasm -f elf -g -F dwarf -l 2uzduotis.lst 2uzduotis.s
	ld -m elf_i386 -o 2run 2uzduotis.o

clean:
	rm -f 2run 2uzduotis.o 2uzduotis.lst

