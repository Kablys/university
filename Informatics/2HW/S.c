#include <stdio.h>
void beginHtml(FILE *html){
	fprintf(html, "<!DOCTYPE HTML> \n");
	fprintf(html, "</html> \n");
	fprintf(html, "   <head> \n");
	fprintf(html, "      <title>Java Syntax</title> \n");
	fprintf(html, "	<link href=""special.css"" rel=""stylesheet"" type=""text/css""> \n");
	fprintf(html, "   </head> \n");
	fprintf(html, "<body> \n");
	fprintf(html, "<pre>\n");
}

int main(){
	int	c;
	FILE *data,
		 *html;
	data = fopen("Code.java", "r");
	html = fopen("index.html", "w");
	beginHtml(html);
	if (data) {
		while ((c = getc(data)) != EOF)
			putc(c,html);
		fclose(data);
	}
	return 0;
}
