#include <stdio.h>
#include <stdlib.h>
#define LETNUM (((c >= 48) && (c <= 57)) || ((c >= 65) && (c <= 90)) || ((c >= 97) && (c <= 122)))
int main ( int argc, char *argv[]){
	FILE *in,
		*out;
	int c;
		if( argc == 3 ){
		in = fopen(argv[1], "r");
		out = fopen(argv[2], "w");
	}
	else if( argc == 2 ){
		in = fopen(argv[1], "r");
		printf("Gavau 1 argumenta antra(output) stdout");
		out = stdout;
	}
	else if( argc == 1 ){
		printf("negavau argumentau pirma(input) teks ivesti, antra(output) stdout\n");
		char *foo = calloc(1, FILENAME_MAX);
		scanf("%s",foo);
		in = fopen(foo, "r");
		out = stdout;
		free(foo);
	}
	else{
		printf("Perdaug argumentu, good bye");
		return 1;
	}

	if(in != NULL, out != NULL){
		while((c = getc(in)) != EOF){
			if (LETNUM){
				while (LETNUM){
					putc(c,out);
					c = getc(in);
				}
				putc('\n',out);
			}
		}
	}
	else{
		printf("sorry");
	}
	fclose(in);
	fclose(out);
	return 0;
}
