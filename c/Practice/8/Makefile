make:main.c f.o
	gcc main.c f.o -o main

f.i:f.c
	gcc -E f.c -o f.i

f.s:f.i
	gcc -S f.i -o f.s

f.o:f.s
	gcc -c f.s -o f.o

