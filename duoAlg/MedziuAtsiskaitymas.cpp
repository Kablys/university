#include <iostream>
#include <stdlib.h>
#include <string>
#include <vector>

using namespace std;
class BinTree{
	private:
		struct Node{
			string name, surname, address;
			int number;						//key value
			vector<long> phones;
			float bill;
			Node* left;
			Node* right;
		};

		void insertNode(string name, string surname, string address, int number, vector<long> phones, float bill, Node* leaf){
			cout << "insetDepp" << endl;
			if(number < leaf->number){
			cout << "i left" << endl;
				if (leaf->left!=NULL){
					insertNode (name, surname, address, number, phones, bill, leaf->left);
				}else{
					setNode(name, surname, address, number, phones, bill, leaf->left);
				}
			}else if(number >= leaf->number){
			cout << "i right" << endl;
				if (leaf->right!=NULL){
					insertNode (name, surname, address, number, phones, bill, leaf->right);
				}else{
					setNode(name, surname, address, number, phones, bill, leaf->right);
				}
			}
		};

		void setNode (string name, string surname, string address, int number, vector<long> phones, float bill, Node *leaf){
			cout << "setNode" << endl;
			leaf = new Node;
			leaf->name = name;
			leaf->surname = surname;
			leaf->address = address;
			leaf->number = number;
			leaf->phones = phones;
			leaf->bill = bill;
			leaf->left = NULL;
			leaf->right = NULL;
			cout << leaf << endl;
		};
	public:
		Node* root; 	//Root node'as nuo kurio viskas prasideda
		int i = 0;

		BinTree(){
			cout << "BinTree konstruktorius iskviestas" << endl;
			root = NULL;
		};

		~BinTree(){
			cout << "BinTree destruktorius iskviestas" << endl;
		};

		//function overload'as nes kad vartotojui nereiktu nurodyti tevo nod'o
		void insertNode(string name, string surname, string address, int number, vector<long> phones, float bill){
			cout << "inset" << endl;
			cout << root << endl;
			//if(root != NULL){
			cout << "jau ideta " << i << "naudu" <<  endl;
			if(i == 0){
				cout << "Root tuscias" << endl;
				setNode(name, surname, address, number, phones, bill, root);
				i++;
			}else{
				cout << "Root uzpildytas" << endl;
				insertNode(name, surname, address, number, phones, bill, root);
				i++;
			}
		};
		void printTree(Node *leaf){
			cout << "print" << endl;
			if(leaf!=NULL){
				printTree(leaf->left);
				cout << leaf->surname << leaf->address << leaf->number;
				vector<long>::iterator it;
				for (it = leaf->phones.begin(); it != leaf->phones.end(); it++){
					cout << *it;
				}
				cout << leaf->bill << leaf->left << leaf->right << endl;
				printTree(leaf->right);
			}
		};

};

int main (){
	BinTree medis;
	vector<long> num1;
	num1.push_back(862751666);
	num1.push_back(123456789);
	medis.insertNode("Vardenis","Pavardenis","Nebuties gatve 7",1,num1,123.45);
	medis.insertNode("Gintvile","Berger","testing gatve 17",2,num1,239.45);
	medis.insertNode("Samsonas","Blabla","bandyas gatve 1",3,num1,62.29);
	medis.printTree(medis.root);
	return 0;
}
