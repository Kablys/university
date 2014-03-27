#include <stdio.h>
int main (){
	/*int x;
	printf("Enter even number, else you will have problems \n");
	while(1){
		if ((scanf("%d",&x)==1)&&(getchar()=='\n')){
			if (x%2){
				printf("Your number is not even, try again\n");
			}else{
				printf("Your number is even, SUCCESS\n");
			break;
			}
		}else{
			printf("Try again, your number isn't even");
			while(getchar()!='\n')
				;
		}	
	}*/
	/*char c;
	while((c=getchar()) != '\n'){
		printf("[%d][%c]",c,c);
	}*/
	int n;
	int x;
	int m;
	printf("You number:");
	scanf("%d",&n);
	for(n;n>0;n--){
		m=1;
		for(x=n;x>0;x--){
           m *=x;
		};
			printf("Factorial of %d is: %d\n",n,m);
	};	

	return 0;
		
}


