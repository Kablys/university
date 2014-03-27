#include <stdio.h>
#include <stdlib.h>

/*void printmsg(char* str){
	printf("%s\n",str);
}*/

void readSize(int *size){
	printf("Size of array\n");
	scanf("%d",size);
}

void create(int size,int **data){
	*data = realloc(*data,size*sizeof(int));
}

void init(int size, int data[]){
	int i = 0;
	srand(time(NULL));
	for (i = 0; i < size; i++){
		data[i] = rand()%10;
	}
}

void printArray(int size, int data[]){
	int i = 0;
	printf("[");
	for (i = 0; i < size; i++){
		printf("%d ",data[i]);
	}
	printf("]\n");
}

int main(){
	int size = 0;
	readSize(&size);
	int *data = NULL; 
	//data = malloc(sizeof(int));
	create(size,&data);
	init(size,data);
	printArray(size,data);
	free(data);	
	return 0;
}
