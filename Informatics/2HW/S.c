#include <stdio.h>
void beginHtml(FILE *html){
	fprintf(html, "<!DOCTYPE HTML> \n");
	fprintf(html, "</html> \n");
	fprintf(html, "   <head> \n");
	fprintf(html, "      <title>Java Syntax</title> \n");
	fprintf(html, "	<link href=\"special.css\" rel=\"stylesheet\" type=\"text/css\"> \n");
	fprintf(html, "   </head> \n");
	fprintf(html, "<body> \n");
	fprintf(html, "<pre>\n");
}

void endHtml(FILE *html){
	fprintf(html, "</pre> \n");
	fprintf(html, "</body> \n");
	fprintf(html, "   <head> \n");
}

void markComment(int c ,FILE *data){

	if (c == '/'){
		if ((c = getc(data)) == '/'){
			printf("comment\n");
		}
	}
}

int main(){
	int	c;
	FILE *data,
		 *html;
	data = fopen("Code.java", "r");
	html = fopen("index.html", "w");
	beginHtml(html);
	if (data) {
		while ((c = getc(data)) != EOF){
			markComment(c,data);
			putc(c,html);
		}
	}
	fclose(data);
	return 0;
}
