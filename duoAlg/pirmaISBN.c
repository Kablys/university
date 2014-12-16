#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>


int main ( int argc, char *argv[] ) {
	FILE *d;
	d = fopen("data", "r");
	int interm;
	int i;
	int mas[14];
	for ( i = 0; i < 5; i++){
		interm = fgetc(d); 
		int j = 0;
		while (interm != '/n') {
			if (isdigit(interm)){
				mas[j] = interm - 0;
			}
			j++;
			interm = fgetc(d); 
		}
		mas[j+1] = 10;
	
		j = 0;
		while (mas[j] != 10) {
			printf("%d ", mas[j]);
			j++;
		}
			printf("\n ");

	}
	fclose (d);
}
