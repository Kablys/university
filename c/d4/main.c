#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

long int sizeOfFile(FILE *f){
	fseek (f, 0, SEEK_END);
	long int pos = ftell (f); 
	rewind (f);
	return pos;
}

int main(void){
	//printf("Labas noreciau failo(pavadinimas 32 simboliai) su kuriuo dirbsiu: ");
	char *link = calloc(32,1);
	//scanf("%s", link);
	link = "file1.bin";
	FILE *f;
	f = fopen(link, "rb");
	if(f == NULL){
		printf("failas nerastas");
		return 1;
	}
	int up = 0,
		zero = 0;
	long int size = sizeOfFile(f);
	//fread(data, size, 1, f);	
	typedef union {
		char c[4];
		int d;
		short int s[2];
		float f;
	}duom;
	printf("%lu", sizeof(duom));
	duom *test= malloc(size / 4); 
	fread(test, (size / 4), 1, f);	
	printf("%lu", sizeof(test));
	for(int i = 0; i < (size / 4); i++){
		for(int j = 0; i < 4; j++){
			if(isupper(test[i].c[j])){
				up++;
			}
		}
		if(test[i].d == 0){
			zero++;
		}
	}
	printf("%d",up);
	printf("%d",zero);

	//for(int i = 0; i < size; i++){
	//	if(isupper(data[i])){
	//		up++;
	//	}
	//}
	printf("%d",up);
	return 0;
}
