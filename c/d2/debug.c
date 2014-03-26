// reikia prideti #include <stdio.h> nes naudojamas "printf", "scanf"
// reikia prideti #include <stdlib.h> nes naudojamas "malloc", "system("pause")";
int main(){
	int *b; // "b" yra nadojamas kaip kintamasis nurodantis masyvo dydi, delto jis neturetu buti rodykle.Bet jei naudojama rodykle tai ji turi buti aluokuota atminties "malloc(1 * sizeof(int))"
	r(b);
	int *a = (int *)malloc(b); // malloc reikia argumentai turetu atroyti "(b * sizeof (int))""
	f(a,b); //funkcija f priama 1 argumenta
	for(int i = 0; i < 10; printf("%d",*a++));// inecilizuoti kintamuosius for cikle galima tik naudojant C99 standarta. Vietoje 10 turetu buti vartojo nurodytas kiekis(b). a++ nesuka nekeicia i reiksmes delto gauname amzina cikla turetu buti i++. Printf del aiskumo turetu buti iskeltas
		{}//lauztiniai skliaustai nieko neapskiaudzia, beto jei turime tik viena vygdymo sakini tai ju nereikia
		system("pause");//system("pause") tinka tik DOS ir Windows sistemoms, del portatibilumo naudoti "getchar()""
		
	//main yra int tipo delto reikia "return 0";
}
//funkcijos naudojamos main turi buti sukurtos virs main
void f(a){//nenurodomas a tipas, is pavadinimo neaisku ka atlieka funkcija
	for(i = 0; i <= b; i++){ // kintamasis i nesukurtas 
		*(a + i) = 1;//nereikalinga eilute
		for(int j = 1; j <= i; j++){ // inecilizuoti kintamuosius for cikle galima tik naudojant C99 standarta
			a[i] *= j;
		}
	}
}
void r(b){//nenurodomas b tipas, is pavadinimo neaisku ka atlieka funkcija
	scanf("%d\n", b);//\n nereikalingas ivedant duomenis
}