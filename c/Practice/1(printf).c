#include<stdio.h>
#define VAL1 2
int main(){
	int x,y,z;
	scanf("%d%d%d",&x,&y,&z);
	/*printf("Sudetis %d\n",x+y);
	printf("Atimtis %d\n",x-y);
	printf("Daugyba %d\n",x*y);
	printf("Divas %d\n",x/y);
	printf("Modas %d\n",x%y);*/
	/*printf("%d\n",'a');
	printf("%c\n",47);*/
	/*printf("%d\n",1<3);
	printf("%d\n",1>3);
	printf("%s\n",VAL1%2==0?"lyginis":"nelyginis");*/
	printf("Max %d\n",(x>y?(x>z?x:z):(y>z?y:z)));
	
return 0;
}
