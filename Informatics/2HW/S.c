#include <stdio.h>
int main(){
	int	c;
	FILE *data;
	data = fopen("Code.java", "r");
	if (data) {
		while ((c = getc(data)) != EOF)
			putchar(c);
		fclose(data);
	}
	return 0;
}
