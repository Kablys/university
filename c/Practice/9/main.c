#include "file.h"
#include <stdio.h>

int main(){
	printmsg("hello");
	printf("%d\n",add(6,1));
	printf("%d\n",sub(6,1));
	printf("%d\n",getAddCount());
	printf("%d\n",getSubCount());
	printf("%d\n",getAllCount());
	printf("%d\n",execute(6 , 1, add));
	printf("%d\n",execute(6 , 1, sub));
	return 0;
}
