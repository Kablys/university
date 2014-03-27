#include<stdio.h>
#include<stdlib.h>
#define MAX 5
#include <time.h>

int main()
{
/*	int data[4];
	int i;
	for(i = -8; i<10;i++)
		printf("%d \n",data[i]);*/
/*	int data[MAX_SIZE];
	int i;
	for (i= 0; i<MAX_SIZE;i++)
	{
		data[i]=rand()%2;
		rintf("%d \n",data[i]);
	}*/
/*	int a,b;
	int data[max];
	int i;
	printf("Enter the left range: ");
	scanf("%d",&a);
	printf("\nEnter the right range: ");
	scanf("%d",&b);
	printf("\n");
	for (i=0; i<max;i++){
		data[i]=rand()%(b-a+1)+a;
		printf("%d \n",data[i]);
	}*/
	int data[MAX];
	int size,i;
	printf("Enter the size of array: ");
	scanf("%d",&size);
	
	if (size>MAX)
	{
		printf("Your size is to big, sorry :)");
		return 0;
	}
	srand(time(NULL));	
	printf("Array \n");
	for(i=0;i<size;i++)
	{
		data[i]=rand()%11;
		printf("%d\n",data[i]);
	}
	int pos,val;
	printf("Our range of update will be [0;%d]",size-1);
	scanf("%d",&pos);
	if (pos<size)
	{	
		printf("\nEnter the new valiue: ");
		scanf("%d",&val);
		data[pos]=val;
	for(i=0;i<MAX;i++){
	printf("%d\n",data[i]);
	}
		}
	printf("Enter the position you want to delete: ");
	scanf("%d",&pos);
	if (pos<size)
	{	
		for (i=pos;i<size-1;i++){
		data[i]=data[i+1];
		printf("%d\n",data[i]);
		}
	}
	printf("Enter the position of insert: ");
	scanf("%d",&pos);
	
		printf("Enter the valiue: ");
		scanf("%d",&val);
		for (i=size-1;i<pos;i--)
		{
			data[i+1]=data[i];
		}
		data[pos]=val;
	for(i=0;i<size;i++)
	printf("%d\n",data[i]);
return 0;
}
