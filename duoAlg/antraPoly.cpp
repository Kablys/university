#include <iostream>

using namespace std;

struct Node {
	int coff, a, b, c;
	bool sign; //true +, false -
	Node *next;

	Node (int coff, int a, int b, int c, bool sign, Node *next){
		this->coff = coff;
		this->a = a;
		this->b = b;
		this->c = c;
		this->sign = sign;
		this->next = next;
	};

	int isSame(int d,int e,int f){
		if ((a == d) && (b == e) && (c == f)){
			return 0;
		}else if ((a > d) && (b > e) && (c > f)) {
			return 1;
		}else {
			return -1;
		}
	}
};

main(){
	//poly1
	Node part5(0,0,0,0,false,NULL); 
	Node part4(1,0,4,0,true,&part5);
	Node part3(-4,3,2,0,true,&part4);
	Node part2(1,5,0,0,true,&part3);
	Node part1(1,5,2,0,true,&part2);
	//poly2
	Node part11(0,0,0,0,false,NULL); 
	Node part10(-4,0,1,0,true,&part5);
	Node part9(-3,0,2,0,true,&part4);
	Node part8(2,2,1,0,true,&part3);
	Node part7(-1,5,0,0,true,&part2);
	Node part6(-3,5,3,0,true,&part2);

	Node *Q;
	Node *P;
	cout << part5.a << endl;	
	return 0;
}
