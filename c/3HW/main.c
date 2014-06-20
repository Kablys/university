#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

int raiseToPower (int base, int exponent){
	int	result = 1;
	for (int i = 0; i <= exponent; i++){
		result = result * base;	
	}
	return result;
}

void push(int mainArray[], int index, int value, int level, int treeHeight){
	if (mainArray[index] == 0){
		mainArray[index] = value;
		return;
	}
	else if (mainArray[index] > value){
		if (treeHeight < level){
			mainArray = realloc(mainArray, (raiseToPower(2, level + 1) - 1) * sizeof (int)); 
		}
		push(mainArray, (2 * index+1), value, level+1, treeHeight);

	}
}

int main (){
	int *mainArray = malloc(sizeof (int)),
		treeHeight = 1;
	push(mainArray, 0, 10, 1, treeHeight);
	//drawMenu();
	//drawMenu
	//addNum
	//delNum
	//printTree
	
	return 0;
}
