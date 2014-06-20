#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
typedef struct {
	char *time; //XX:XX - XX:XX
	char *subject;
	char *instructor;
	char *location;
} lecture;

int file_exist (char *filename){ //checks if file exist
  struct stat   buffer;
  return (stat (filename, &buffer) == 0);
}

long int sizeOfFile(FILE *f){
	fseek (f, 0, SEEK_END);
	long int pos = ftell (f);
	rewind (f);
	return pos;
}

void getTime(char *index, lecture semester){	//gets time of lecture
	int length;
	char *interim = calloc(13,1),
		 *end;
	index = index + 12;
	end = index + 5;
	length = end - index;
	strncpy(interim, index, length);
	strcpy(semester.time,interim);
	strcat(semester.time, " - ");
	memset(interim, 0, 13);

	index = index + 24;
	end = strchr(index, '\n');
	length = end - index;
	strncpy(interim, index, length);
	strcat(semester.time, interim);
	free(interim);
}

void getSubject(char *index, lecture semester){	//gets subject of lecture
	int length;
	char *interim = calloc(32,1),
		 *end;
	index = strstr(index, "<a href=\"/tvark/timetable/subject/") + strlen("<a href=\"/tvark/timetable/subject/");
	index = strstr(index, "/\">") + strlen("/\">");
	end = strchr(index, '<');
	length = end - index;
	strncpy(semester.subject, index, length);
	strcpy(semester.subject,semester.subject);
	free(interim);
}

void getInstructor(char *index, lecture semester){	//gets professor of lecture
	int length;
	char *interim = calloc(32,1),
		 *end;
	index = strstr(index, "<a href=\"/tvark/timetable/professor/") + strlen("<a href=\"/tvark/timetable/professor/");
	index = strstr(index, "/\">") + strlen("/\">");
	end = strchr(index, '<');
	length = end - index;
	strncpy(interim, index, length);
	strcpy(semester.instructor,interim);
	free(interim);
}

void getLocation(char *index, lecture semester){	//gets location of lecture
	int length;
	char *interim = calloc(20,1),
		 *end;
	index = strstr(index, "<a href=\"/tvark/timetable/classroom/") + strlen("<a href=\"/tvark/timetable/classroom/");
	index = strstr(index, "/\">") + strlen("/\">") + 47;
	end = strchr(index, '<') - 40;
	length = end - index;
	strncpy(interim, index, length);
	strcpy(semester.location,interim);
	free(interim);
}

void printLecture(FILE *d, lecture semester){
	fprintf(d,"%.13s|", semester.time);
	fprintf(d,"%.32s|", semester.subject);
	fprintf(d,"%.32s|", semester.instructor);
	fprintf(d,"%.20s\n", semester.location);
}

void printOptions(){
	printf("available options:\n");
	printf("'s' - scan data from file\n");
	printf("'d' - print database\n");
	printf("'r' - remove data form database\n");
	printf("'e' - exit program\n");
}
int numLine(FILE *f){//return number of lines in file
	fseek(f,0,SEEK_SET);
	int lines = 0;
	while (EOF != (fscanf(f,"%*[^\n]"), fscanf(f,"%*c")))
		++lines;
	rewind(f);
	return lines;
}
int main( int argc, char *argv[] ){
	FILE *d;
	stderr = fopen("log", "a");//file where logs about what program did wil be stored
	d = fopen("database", "a");	//file where scand information will be stored
	lecture semester;
	printOptions();
	char action;
	printf("Select option:");
	scanf("%c", &action);

	switch (action){
		case 'e':
			break;
		case 'r':
			d = freopen("database", "w", d);	// option w discards contents of file
			printf("database successfully emptied.\n");
			fprintf(stderr, "%s %s 	database emptied.\n" ,__DATE__,__TIME__);
			fclose(d);
			break;

		case 's':
			printf("Type name of file you want to scan\n");
			char *name = calloc(32,1);
			scanf("%s", name);
			FILE *f;
			if(file_exist (name)){ //function that checks if file exist
				f = fopen(name, "rb");	//file from which data will be scand
			}
			else{
				printf("File %s not found\n", name);
				fprintf(stderr, "%s %s 	File %s not found\n",__DATE__,__TIME__, name);
				return 1;
			}
			long int size = sizeOfFile(f);
			char *index = calloc(size,1);

			fread(index, size, 1, f);

			fprintf(stderr, "%s %s 	%s file scand and inported into databse\n", __DATE__,__TIME__, name);
			fprintf(d, "%s %s data scand %s file \n", __DATE__,__TIME__, name);

			index = strstr(index, "<td class=\"time\">")+ strlen("<td class=\"time\">") + 1;
			while(strstr(index, "<table class=\"timetable\">") != NULL){
				semester.time = calloc(13,1);
				semester.subject = calloc(32,1);
				semester.instructor = calloc(32,1);
				semester.location = calloc(20,1);

				getTime(index, semester);
				getSubject(index, semester);
				getInstructor(index, semester);
				getLocation(index, semester);

				printLecture(d, semester); //prints all variables of semester

				index = strstr(index, "<td class=\"time\">") + strlen("<td class=\"time\">") + 1;
				free(semester.time) ;
				free(semester.subject);
				free(semester.location) ;
				free(semester.instructor) ;
			}
			free(index);
			free(name);
			fclose(f);
			break;

		case 'd':
			printf("Content of database:\n");
			d = freopen("database", "rb", d);	// reopen database for reading
			long int length = sizeOfFile(d);
			char interim;
			for (int i = 0; i < length; i++){
				interim = getc(d);
				putchar(interim);
			}
			break;

		default:
			printOptions();
			break;
	}

	return 0;
}
