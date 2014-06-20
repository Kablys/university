//Dominyko Ablingio 2 programa
/*REIKALAVIMAI*/
//Trečios užduoties tikslas - sukurti primityvią duomenų bazę valdymo sistemą (DBVS), kuri privalo turėti pagrindinius elementus:
//	Visus saugomus duomenis laikyti failinėje sistemoje. Tai yra paleidus iš naujo programą, duomenys niekur nedingsta.
//	Paleista programa leidžia atlikti pasirinktą funkciją. Kiekvienai funkcijai jei reikia papildomai įvedami parametrai.
//	Privalo būti standartinės funkcijos:
//		Elemento įterpimas - duomenų pildymas vienu elementu.
//		Elemento ištrynimas - vieno ar kelių elementų ištrynimas.
//		Duomenų importavimas - nurodomas failas iš kurio užkrauti visą aibę duomenų.
//		Elemento(ų) paieška - ieškomas sąrašas elementų atitinkančių taisikles.
//		Galimybė nurodyti paieškos rezultatų rūšiavimo kriterijų.
//		Galimybė ar rezultatai bus išvedami į failą ar į standartinį išvedimo įrenginį (stdout).
//	Ieškomiems laukams yra sukurti indeksai (priemonės atlikti greitesnę paiešką). Tai gali būti medžiai, maišos(hash) lentelės.
//Papildomi balai skiriami už:
//	Apdorojamas duomenų kiekis didesnis, nei išskirta atmintis.
//	Kreipiniai į funkcijas vykdomi sava kalba. Pvz.: SQL
//	Paieškos kriterijai gali būti ne tik '='(lygu), bet ir '<', '>', '<=', '>=', 'IN(...)'

/*UZDUOTIS*/
//DB saugomi elementai susidės iš atributų: kino pavadinimas, laikas, eilė ir vieta.
//Paieška turi būti vykdoma pagal: eilę ir/arba vietą
//Rūšiavimas galimas pagal: eilę ir/arba vietą.
//Papildomi veiksmai: įterpti naują įrašą galima tik, tai jeigu tokio įrašo dar nėra.

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
typedef struct {//struct for f
	char *title;
	int	hour,	//0-23
		min,	//0-59
		row,
		seat;
} film;

int checkInput(int lowerLimit,int upperLimit){	//checks if input is number and if it between limits
	int n = 0;
	while (1){
		if((scanf("%d",&n) == 1) && (n >= lowerLimit) && (n <= upperLimit) && (getchar() == '\n')){
			break;
		}
		else{
			printf("You need to input number between %d and %d:",lowerLimit,upperLimit);
			while(getchar() != '\n')
			;
		}
	};
	return n;
}//chechInput

int file_exist (char *filetitle)
{
  struct stat   buffer;
  return (stat (filetitle, &buffer) == 0);
}

int numLine(FILE *f){
	fseek(f,0,SEEK_SET);
	int lines = 0;
	while (EOF != (fscanf(f,"%*[^\n]"), fscanf(f,"%*c")))
		++lines;
	rewind(f);
	return lines;
}
char *getString ()				// inputs char array from stdin
{
	char *line = (char *) malloc (1);
	int length = 0;
	line[length] = (char) fgetc(stdin);
	
	while ((line[length] != '\n') && (length < 100))
	{
		length++;
		line = (char *) realloc (line, (length + 1));
		line[length] = (char) fgetc(stdin);
		if (line[length] == ' '){
			line[length] = '_' ;
		}
	}
	line[length] = '\0';
	return line;
}


void readUsr(film *interim){
	printf("Filmo pavadinimas(tarpai yra paverciami'_'):");
	interim->title = calloc(100,1);
	interim->title = getString();
	//scanf("%s", interim->title);

	printf("Filmo pradzios valanda(0-23):");
	interim->hour = checkInput(0,23);

	printf("Filmo pradzios minute(0-59):");
	interim->min = checkInput(0,59);

	printf("Eile(1-32):");
	interim->row = checkInput(1,32);

	printf("Vieta(1-32):");
	interim->seat = checkInput(1,32);
}

void readFile(FILE *f, film *cinema){
	cinema->title = calloc(100,1);
	fscanf(f, "%s %d %d %d %d",
			cinema->title, &cinema->hour, &cinema->min, &cinema->row, &cinema->seat);
}

void Push(FILE *f, film *interim){
	fprintf(f,"%s ", interim->title);
	fprintf(f,"%d ", interim->hour);
	fprintf(f,"%d ", interim->min);
	fprintf(f,"%d ", interim->row);
	fprintf(f,"%d ", interim->seat);
	fprintf(f,"\n");
}

void Print(film *interim){
	printf("%s ", interim->title);
	printf("%d ", interim->hour);
	printf("%d ", interim->min);
	printf("%d ", interim->row);
	printf("%d ", interim->seat);
	printf("\n");
}
void change(film first,film second){
	film interim;
	interim.title = calloc(1,100);

	strcpy(interim.title, first.title);
	interim.hour = first.hour;
	interim.min = first.min;
	interim.row = first.row;
	interim.seat = first.seat;

	//memset(first.title, 0, 100);
	//strcpy(first.title, second.title);
	memcpy(first.title, second.title, 100);
	first.hour = second.hour;
	first.min = second.min;
	first.row = second.row;
	first.seat = second.seat;

	strcpy(second.title,interim.title);
	second.hour = interim.hour;
	second.min = interim.min;
	second.row = interim.row;
	second.seat = interim.seat;
}

int main( int argc, char *argv[]){
	film *cinema,
		 interim;
	FILE *f,
		 *t;
	char action,
		 *word = calloc(100,1);
	int lines = 0,
		search = 0;
	int found = 0;
	if( argc == 2 ){
		action = argv[1][0];
	}
	else if( argc > 2 ){
		printf("Suteikta perdaug argumentu.\n");
		return 1;
	} else{
		printf("Formatas: main <action>.\n");
			printf("actions: a = prideti elementa\n l = atspausdinti elementus\n i = importuoti elements\n f = surasti elementa\n d = istrinti elementa\n s = isrusiuoti\n"); 
		return 1;
	}
	switch (action){
		case 'a':
			f = fopen ("database.txt","a");
			if (f == NULL){
				printf("nerastas duombazes failas");
				return 1;
			}
			readUsr(&interim);
			//lines = numLine(f);
			//cinema = calloc(lines,sizeof(film));
			//film tarpinis;
			//for(int i = 0; i < lines; i++){ 
			//	readFile(f, &tarpinis);
			//	printf("tikrinimas\n");
			//	if ((strcmp(interim.title,tarpinis.title)) && (interim.hour == tarpinis.hour) && (interim.min == tarpinis.min) && (interim.row == tarpinis.row) && (interim.seat == tarpinis.seat)){
			//		printf("toks failmas jau yra");
			//		free(interim.title);
			//		//free(cinema);
			//		fclose(f);
			//		break;

			//	}
			//}
			//fseek(f,0,SEEK_SET);
			Push(f, &interim);
			free(interim.title);
			//free(cinema);
			fclose(f);
			break;

		case 'l':
			f = fopen ("database.txt","r");
			if (f == NULL){
				printf("nerastas duombazes failas");
				return 1;
			}
			lines = numLine(f);
			cinema = calloc(sizeof(film),lines);
			for(int i = 0; i < lines; i++){
				readFile(f, cinema);
				Print(cinema);
			}
			fclose(f);
			free(cinema);
			break;

		case 'i':
			f = fopen ("database.txt","a");
			if (f == NULL){
				printf("nerastas duombazes failas");
				return 1;
			}
			printf("ivesk faila kuri noretum skaityti: ");
			scanf("%s", word);
			t = fopen(word, "r");
			if (t == NULL){
				printf("failas nerastas\n");
				fclose(f);
				break;
			}
			else{
				printf("failas sekmingai rastas\n");
			}

			lines = numLine(t);
			cinema = calloc(lines,sizeof(film));
			for(int i = 0; i < lines; i++){
				readFile(t, cinema);
				Push(f, cinema);
			}

			fclose(f);
			free(cinema);
			break;
		case 'f':
			f = fopen ("database.txt","r");
			if (f == NULL){
				printf("nerastas duombazes failas");
				return 1;
			}
			search = 0;
			printf("Iveskite numeri pagal kuri noretumet ieskoti:\n");
			printf("1. Pagal eile\n");
			printf("2. Pagal vieta\n");
			printf("3. Pagal eile ir vieta\n");
			search = checkInput(1,3);
			lines = numLine(f);
			if (search == 1){
				printf("Iveskite eiles numeri:\n");
				search = checkInput(1,32);
				for(int i = 0; i < lines; i++){ //searchFile(f, word
					readFile(f, &interim);
					if (interim.row == search){
						Print(&interim);
						found = 1;
					}
				}

			}else if(search == 2){
				printf("Iveskite vietos numeri:\n");
				search = checkInput(1,32);
				for(int i = 0; i < lines; i++){ //searchFile(f, word
					readFile(f, &interim);
					if (interim.seat == search){
						Print(&interim);
						found = 1;
					}
				}
			
			}else if(search == 3){
				printf("Iveskite eiles numeri:\n");
				search = checkInput(1,32);
				printf("Iveskite vietos numeri:\n");
				int search2 = checkInput(1,32);
				for(int i = 0; i < lines; i++){ //searchFile(f, word
					readFile(f, &interim);
					if ((interim.seat == search) && (interim.row == search2)){
						Print(&interim);
						found = 1;
					}
				}
			}
			if (!found) printf("Filmas nerastas\n");
			fclose(f);
			break;
		case 'd':
			f = fopen ("database.txt","r");
			if (f == NULL){
				printf("nerastas duombazes failas");
				return 1;
			}
			printf("Ivesk filmo kuri norite istrinti pavadiniman:\n");
			scanf("%s", word);
			lines = numLine(f);
			cinema = calloc(sizeof(film),lines);
			for(int i = 0; i < lines; i++){
				readFile(f, cinema+i);
			}
			for(int i = 0; i < lines; i++){
				if (!strcmp(cinema[i].title, word)){
					i++;
					while(i < lines){
						cinema[i-1] = cinema[i];
						i++;
					}
					freopen("database.txt","w",f);
					for(int i = 0; i < lines-1; i++){
						Push(f, cinema+i);
					}
					found = 1;
					break;
				}

			}
			if (!found) printf("Filmas nerastas\n");
			free(cinema);
			fclose(f);
			break;
		case 's':
			f = fopen ("database.txt","r");
			if (f == NULL){
				printf("nerastas duombazes failas");
				return 1;
			}
			search = 0;
			printf("Iveskite numeri pagal kuri noretumet rusiuoti:\n");
			printf("1. Pagal eile\n");
			printf("2. Pagal vieta\n");
			printf("3. Pagal eile ir vieta\n");
			search = checkInput(1,3);
			lines = numLine(f);
			cinema = calloc(lines,sizeof(film));
			for(int i = 0; i < lines; i++){
				readFile(f, cinema);
			}
			if (search == 1){
				for(int i = 0; i < lines - 1; ++i){ 
					for(int j = 0; j < lines - i; ++j){
						if (cinema[j].row > cinema[j+1].row){
							change(cinema[j], cinema[j+1]);						
						}
					}

				}
				for(int i = 0; i < lines; i++){
					Print(cinema);
				}
			}else if(search == 2){
				for(int i = 0; i < lines - 1; i++){ 
					for(int j = 0; j < lines - i; j++){
						printf("tikrina");
						if (cinema[j].row > cinema[j+1].row){
							change(cinema[j], cinema[j+1]);						
						}
					}

				}
				for(int i = 0; i < lines; i++){
					Print(cinema);
				}
			}else if(search == 3){
				printf("Iveskite eiles numeri:\n");
				search = checkInput(1,32);
				printf("Iveskite vietos numeri:\n");
				int search2 = checkInput(1,32);
				for(int i = 0; i < lines; i++){ //searchFile(f, word
					readFile(f, &interim);
					if ((interim.seat == search) && (interim.row == search2)){
						Print(&interim);
						found = 1;
					}
				}
			}
			if (!found) printf("Filmas nerastas\n");
			fclose(f);
			break;
		default:
			printf("netinkamas action %d", action);
			printf("Formatas: main <action>.\n");
			printf("a = prideti elementa\n l = atspausdinti elementus\n i = importuoti elements\n f = surasti elementa\n d = istrinti elementa\n s = isrusiuoti\n"); break;
	}

	return 0;
}
