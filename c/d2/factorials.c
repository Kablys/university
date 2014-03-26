#include <stdio.h> 
#include <stdlib.h> 
void scanInt(int *b){
	scanf("%d", b);
}

void factorArray(int *a,int *b){
	int i = 0;
	int j = 0;
	for(i = 0; i <= *b; i++){
		*(a + i) = 1;
		for(j = 1; j <= i; j++){ 
			a[i] *= j;
		}
	}
}

int main(){
	int *b = malloc(1 * sizeof(int));
	scanInt(b);
	int *data = (int *)malloc((*b) * sizeof(int));
	factorArray(data,b);
	int i = 0; 
	for(i = 1; i <= *b;i++ ){
		printf("%d %d\n",i,data[i]);
	}
	getchar();
	return 0;
}

