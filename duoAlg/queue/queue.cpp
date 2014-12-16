#include <iostream>
#include <stdlib.h>

using namespace std;
struct queue{
	struct Node {
		int data;
		Node* next;
	};

	Node* head = NULL;
	Node* tail = NULL;

	void enqueue (int i) {
		Node* p = new Node();
		p->data = i;
		p->next = NULL;
		
		if (tail != NULL) {
			tail->next = p;
		}
		tail = p;
			
		if (head == NULL) {
			head = tail;
		}
	}

	Node* dequeue() {
		Node* p = head;
		if (p != NULL) {
			head = p->next;
		}
		return p;
	}


	void print(){
		Node* p = head;
		while (p != NULL) {
			cout << p->data << endl;
			p = p->next;
		}
	}
};

bool isLess (int A, int B, int j){
	if (A > B)
		return true;
	else if (A > B) 
		return false;
	if ((j % 2) == 0)
		return true;
	else
		return false;
}

int main(int argc, char *argv[]) {
	queue A, B;
	A.enqueue (6);
	A.enqueue (5);
	A.enqueue (4);
	B.enqueue (3);
	B.enqueue (2);
	B.enqueue (1);
	int j = 0;
	while (j != 3){
		if (isLess(A.head->data, B.head->data, j)){
			A.enqueue(A.dequeue()->data);
			A.enqueue(B.dequeue()->data);
		}else {
			B.enqueue(B.dequeue()->data);
			B.enqueue(A.dequeue()->data);
		};
		j++;

	}
	cout << "A" << endl;
	A.print();
	cout << "B" << endl;
	B.print();

	//cout << "Iveskite pirmos eilutes duomenis" << endl;
	//int x;
	//queue A, B;
	//for(int i = 1; i < 5; i++){
	//	cin >> x;
	//	A.enqueue(x);
	//}
	//int x;
	//cin >> x;
	//cout << "Iveskite antras eilutes duomenis" << endl;
	// implement
	return 0;
}
