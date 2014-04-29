#include <stdio.h>
#include "file.h"

//int X=25;

//void printmsg(){
//	printf("Hello world\n");
//	printf("The X is %d\n",X);
//}
static int h=0;
static int j=0;

int add(int a, int b){
	h++;
	return a + b;
}
int sub(int c, int d){
	j++;
	return c - d;
}

int GetAddCount() {
	return h;
}
int GetSubCount(){
	return j;
}
int GetAllCount(){
	return h+j;
}
int execute(int a, int b, int (action)(int, int )){
return (action(a, b));
}
