#include <stdio.h>
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

/*jvoid markComment(int c ,FILE *data){
	if (c == '/'){
		if ((c = getc(data)) == '/'){
			printf("comment\n");
		}
	}
}*/

int main(){
	int	c, i;
	FILE *data,
		 *html;

	const char *strings[] = { "abstract", "assert", "boolean", "break", "byte", "case", "catch", "char", "class", "const", "continue", "default", "do", "double", "else", "enum", "extends", "final", "finally", "float", "for", "goto", "if", "implements", "import", "instanceof", "int", "interface", "long", "native", "new", "package", "private", "protected", "public", "return", "short", "static", "strictfp", "super", "switch", "synchronized", "this", "throw", "throws", "transient", "try", "void", "volatile", "while"};

	data = fopen("Code.java", "r");
	html = fopen("index.html", "w");
					for (i = 0; i < 50; i++){
						fprintf(html, "%s\n",strings[i]);//opening and closing tag
					}
	beginHtml(html);
	if (data) {
		while ((c = getc(data)) != EOF){
			if (c == '/'){		//marking comments
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
				continue;
			}
			
			if (c == '\"'){		//marking text
				fprintf(html, "<span class=\"text\">%c",c);//opening tag
				while((c = getc(data)) != EOF){
					if(c == '\"'){
						putc(c,html);
						fprintf(html, "</span>");//closing tag
						break;	
					}
					putc(c,html);
				}
				continue;
			}

			if ((c >= 97) && (c <= 122)){//marking reserved words
				char interim[12];//longest rerved JAVA word is synchronized(12 characters)
				int i = 0;
				interim[0] = c;
				c = getc(data);
				while (((c >= 97) && (c <= 122)) || (i > 11)){
					i++;
					interim[i] = c;
					interim[i + 1] = '\0';
					c = getc(data);
				}
				for (i = 0; i < 50; i++){
					if (interim == strings[i]){
						fprintf(html, "<span class=\"reserved\">%s</span>",interim);//opening and closing tag
						break;	
					}
				
				}
				fprintf(html, "%s",interim);//opening and closing tag
				putc(c,html);
				continue;
			}

			//markComment(c,data);
			putc(c,html);
		}
	}
	endHtml(html);
	fclose(data);
	fclose(html);
	return 0;
}
