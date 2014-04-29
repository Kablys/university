//Dominyko Ablingio 2 programa
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char *strings[] = { "abstract", "assert", "boolean", "break", "byte", "case", "catch", "char", "class", "const", "continue", "default", "do", "double", "else", "enum", "extends", "final", "finally", "float", "for", "goto", "if", "implements", "import", "instanceof", "int", "interface", "long", "native", "new", "package", "private", "protected", "public", "return", "short", "static", "strictfp", "super", "switch", "synchronized", "this", "throw", "throws", "transient", "try", "void", "volatile", "while"};

void beginHtml(FILE *html){
	fprintf(html, "<!DOCTYPE HTML> \n");
	fprintf(html, "</html> \n");
	fprintf(html, "   <head> \n");
	fprintf(html, "		<title>Java Syntax</title> \n");
	fprintf(html, "		<link href=\"special.css\" rel=\"stylesheet\" type=\"text/css\"> \n");
	fprintf(html, "   </head> \n");
	fprintf(html, "<body> \n");
	fprintf(html, "<pre>\n");
}

void endHtml(FILE *html){
	fprintf(html, "</pre> \n");
	fprintf(html, "</body> \n");
	fprintf(html, "<html> \n");
}


void markString(FILE *data, FILE *html, char c){
	fprintf(html, "<span class=\"text\">%c",c);//opening tag
	while((c = getc(data)) != EOF){//iki failo pabaigos
		if(c == '\"'){
			putc(c,html);
			fprintf(html, "</span>");//closing tag
			break;	
		}
		putc(c,html);
	}
}

int markComment(FILE *data, FILE *html, char c){
	int k;
	k = c;
	c = getc(data);
	if(c == '/'){		//inline comment
		fprintf(html, "<span class=\"comment\">%c%c",k,c);//opening tag
		while ((c = getc(data)) != '\n'){
			putc(c,html);
		}
		fprintf(html, "</span>");//closing tag
	}
	else if(c == '*'){//block comment
		fprintf(html, "<span class=\"comment\">%c%c",k,c);//opening tag
		while((c = getc(data)) != EOF){
			if(c == '@'){
				fprintf(html, "<span class=\"author\">");//opening tag
				while(!(c == ' ')){
					if(c == '*'){
						putc(c,html);
						c = getc(data);
						if(c == '/'){
							putc(c,html);
							fprintf(html, "</span></span>");//closing tag
							return 0;	
						}
						continue;
					}
					putc(c,html);
					c = getc(data);
				}
				fprintf(html, "</span>");//closing tag
			}
			if(c == '*'){
				putc(c,html);
				c = getc(data);
				if(c == '/'){
					putc(c,html);
					fprintf(html, "</span>");//closing tag
					break;	
				}
				continue;
			}
			putc(c,html);
		}

	}
	else{//if only one /
		fprintf(html, "%c%c",k,c);
	}
	return 0;
}

void markNumber(FILE *data, FILE *html, char c){
	char *interim = malloc(1 * sizeof (char));
	int i = 1;
	interim[0] = c;
	c = getc(data);
	/*            0            9*/
	while (((c >= 48) && (c <= 57))){
		i++;
		interim = realloc(interim, i * sizeof(char));
		interim[i - 1] = c;
		c = getc(data);
	}
	interim = realloc(interim, (i + 1) * sizeof(char));
	interim[i] = '\0';//prideda string gale 

	/*           A            Z                          a            z*/ 
	if (!(((c >= 65) && (c <= 90)) || (c == '_')|| ((c >= 97) && (c <= 122)))){
		fprintf(html, "<span class=\"numbers\">%s</span>%c",interim, c);//opening and closing tag
	}
	else{ 
		fprintf(html,"%s%c", interim, c);//opening and closing tag
	}

	free(interim);
}

void markReservedClass(FILE *data, FILE *html, char c){
	char *interim = malloc(1 * sizeof (char));
	int i = 1;
	interim[0] = c;
	c = getc(data);
	/*            0            9              A            Z                           a            z*/
	while (((c >= 48) && (c <= 57)) || ((c >= 65) && (c <= 90)) || (c == '_') || ((c >= 97) && (c <= 122)) ){
		i++;
		interim = realloc(interim, i * sizeof(char));
		interim[i - 1] = c;
		c = getc(data);
	}
	interim = realloc(interim, (i + 1) * sizeof(char));
	interim[i] = '\0';//prideda string gale 

	char notfound = 1;
	for (i = 0; i < 50; i++){
		if (strcmp(interim,strings[i]) == 0){
			fprintf(html, "<span class=\"reserved\">%s</span>",interim);//opening and closing tag
			notfound = 0;
			break;	
		}
	}
	if (notfound){
		if (c == '.'){
		fprintf(html, "<span class=\"classes\">%s</span>",interim);//opening and closing tag
		}
		else{
		fprintf(html, "%s",interim);//opening and closing tag
		}
	}
	putc(c,html);
	free(interim);
}

int main( int argc, char *argv[] ){
	int	c;
	FILE *data,
		 *html;

		if( argc == 3 ){
		printf("The argument supplied are %s%s\n", argv[1],argv[2]);
		data = fopen(argv[1], "r");
		html = fopen(argv[2], "w");
	}
	else if( argc > 3 ){
		printf("Too many arguments supplied, expected two.\n");
		printf("Using default: Code.java, index.html.\n");
		data = fopen("Code.java", "r");
		html = fopen("index.html", "w");
	}
	else{
    	printf("Two argument expected.\n");
		printf("Using default: Code.java, index.html.\n");
		data = fopen("Code.java", "r");
		html = fopen("index.html", "w");
	}
	beginHtml(html);
	if (data) {
		while ((c = getc(data)) != EOF){

			if (c == '/'){		//marking comments
				markComment(data, html, c);
				continue;
			}
			
			if (c == '\"'){		//marking text
				markString(data, html, c);
				continue;
			}
			/*        0            9*/
			if ((c >= 48) && (c <= 57)){//marking numbers
				markNumber(data, html, c);		
				continue;
			}
			/*          A            Z              a            z*/			
			if ((((c >= 65) && (c <= 90)) || ((c >= 97) && (c <= 122)))){//marking reserved words
				markReservedClass(data, html, c);		
				continue;
			}

			putc(c,html);
		}
	}
	endHtml(html);
	fclose(data);
	fclose(html);
	return 0;
}
