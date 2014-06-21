#include <stdio.h>
void swap(int *a, int *b){
	int *k;
	k = a;
	a = b;
	b = k;
}

int main(){
	int list[5] = {5, 6, 2, 99, 34};
	int i;
	for (i = 0; i < 4; i++){
		int j = i;
		while (j > 0 && list[j] < list[j - 1]){
			swap(&list[j], &list[j - 1]);
			j = j - 1;
		}
	}

	return 0;
}
