#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]){
	FILE *toSplit, *part;
	toSplit = fopen(argv[2], "r");
	int size = atoi(argv[1]), number = 0;
	char partName[12];
	char buff[1024];

	while(number < 100 /* && !feof(toSplit)*/){
		sprintf(partName, "%d%s", number, argv[2]);	//genarate file name
		part = fopen(partName, "w");	//create new file
		fgets(buff, size, toSplit);		//read from file
		if (feof(toSplit)) {
			fclose(part);					//close new file
			break;
		}
		fprintf(part, "%s\n", buff);	//write into new file
		fclose(part);					//close new file
		number++;
	}

	fclose(toSplit);
	return 0;
}
