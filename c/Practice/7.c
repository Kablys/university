#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct{
	double x,
		   y;
}Point;

typedef struct{
	Point *a;
	int size;
}Stack;

Point createPoint(double x, double y){
	Point p;
	p.x = x;
	p.y = y;
	return p;
}

void push(Stack arr, Point p){	
	arr.size =+ 1;
	int foo = arr.size;
	arr.a = realloc(arr.a, foo*sizeof(Point));
	arr.a[arr.size] = p;
}

int main(){
	srand(time(NULL));
	Stack mas;
	mas.a =  malloc(1 * sizeof (Point));
 	mas.size = 0; 
	int i;
	Point z;
	for (i = 0; i < 10; i++){
		z.x = rand()%11;
		z.y = rand()%11;
		push(mas,z);
		printf("x = %f and y = %f\n", z.x, z.y);

	}
	free(mas.a);
	return 0;
}
