#include <stdio.h>
#include <stdlib.h>
int main(int argc, char const *argv[])
{
	/*char c;
	int x,y,i;
	long d[10];
	printf("%p\n",&c);
	printf("%p\n",&x);
	printf("%p\n",&y);
	for (i = 0; i < 10; ++i)
	{
		printf("%p\n",&d[i]);
	}

	int z=3;
	int *p = NULL;
	//p = &z;
	printf("%d %d\n",z,*p);
	srand(time(NULL));
	int i;
	int *p = malloc(10*sizeof(int));
	for (i = 0; i < 10; ++i)
	{
		p[i] = rand()%10;
		printf("%d\n",p[i]);
	};
	free(p);*/
	int size = 1;
	int *data = NULL;
	data = malloc(sizeof(int));
	do{
		data = realloc(data,size);
		printf("%p %d\n",data,size);
		size *= 2;
		getchar()=='\n';
	} while (data!=NULL);
	free(data);
	return 0;
}