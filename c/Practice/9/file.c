#include <stdio.h>
#include "f.h"

void printmsg(char str[]){
	printf("%s\n",str)
}

static int a = 0;
int add(int num1, int num2){
	a++;
	return num1 + num2;
}

static int s = 0;
int sub(int num1, int num2){
	s++;
	return num1 - num2;
}

int getAddCount(){
	return a;
}

int getSubCount(){
	return s;
}

int getAllCount(){
	return a + s;
}

int execute(int a, int b, int (act)(int, int)){
	return (act(a,b)))uu;
}
