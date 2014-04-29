#include "file.h"
#include <stdio.h>
/*int main(){
	printmsg();
	return 0;
}*/
int main(){
	printf("%d\n",add(6,1));
	printf("%d\n",sub(6,1));
	printf("%d\n",GetAddCount());
	printf("%d\n",GetSubCount());
	printf("%d\n",GetAllCount());
	printf("%d\n",execute(6,1,add));
	printf("%d\n",execute(6,1,sub));
	return 0;
}
