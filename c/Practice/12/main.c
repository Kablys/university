#include <stdio.h>
#include <string.h>
#include <math.h>

typedef struct {
	char c[30];
	int i;
	double d;
}element;

int intLen(int value){
	int l = 0;
	while(value){
		l++;
		value /= 10;
	}
	return l;
}

int main() {

element data[10] ={
	{"abc", 12, 0.0},
	{"a", 40132, 100.0},
	{"abcdefgh", 100, 160.0},
	{"dd", 0, 60.25},
	{"e", -100, 0.61}
};

int cMax = 0,
	iMax = 0,
	dMax = 0;
for (int i = 0; i < 5; i++){
	if (strlen(data[i].c) > cMax){
		cMax = strlen(data[i].c);
	}
	if (intLen(data[i].i) > iMax){
		iMax = intLen(data[i].i);
	}
	if (intLen(trunc(data[i].d)) > dMax){
		dMax = intLen(trunc(data[i].d));
	}
}

for (int i = 0; i < 5; i++){
	printf("|%-*s| |%*d| |%*.*f|\n", cMax, data[i].c, iMax, data[i].i, dMax, 2, data[i].d);
}

return 0;
}

