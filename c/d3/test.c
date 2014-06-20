//#include <stdio.h>
#include "mod.h"

int main(void){
	struct Stack duom;
	duom.data = (int*)malloc(sizeof(int));
	push (&duom,15);
	push (&duom,4);
	push (&duom,18);
	printStack (&duom);

	free(duom.data);

	return 0;
}
