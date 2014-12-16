#!/bin/bash
nasm -f elf uzduotis1.s

ld -m elf_i386 -s -o hello uzduotis1.o

./hello

rm hello uzduotis1.o
