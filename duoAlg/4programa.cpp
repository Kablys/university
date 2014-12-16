#include <iostream>

using namespace std;
int main (){
	char A[10] = {'a', 'a', 'a', 'm', 'm', 0, 0, 0, 0, 0},
		 B[10] = {'t', 't', 'e', 'i', 'k', 0, 0, 0, 0, 0},
		 C[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	int a = 0,
		b = 0,
		c = 0;
//Prasideda eile operaciju
	for (a = 0; a < 4; a++){
		C[10-a] = A[a];
		c = 10 - a;
		A[a] = 0;
		
	}
	
}
