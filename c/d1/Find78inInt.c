#include <stdio.h>
int main(){
	int n=0;
	while(1){
		if((scanf("%d",&n)==1)&&(getchar()=='\n')){			
			if (n >= 10){	//patikrina kartu kad 2 ar daugiau skaitmenu ir ar neneigemas
				int i=0,j=1,m=n;
				int arr[100]={0};
				while(m>9){
					arr[j-1]=m-((m/10)*10);//priskiriam skaicius masyvui
					m/=10;
					j++;   				   //j naudojamas nustatyti skaiciaus ilgiui
				};
				arr[j-1]=m;
				for(i=0;i<j;i++){
					if ((arr[i]==8) && (arr[i+1]==7)){	//tikrinam atviksciai nes i masyva skaiciai sudeti atvirksciai
						printf("YES \n");
						break;
					}
					if (i==j-1){
						printf("NO \n");
						break;
					}
				};
				break;
			}
			else{
				printf("Jums reikia ivesti dvizenkli teigema skaiciu\n");
			}	
		}
		else{
			printf("Jums reikia ivesti dvizenkli teigema skaiciu\n");
			while(getchar()!='\n')
			;
		}	
	};
	return 0;
}
