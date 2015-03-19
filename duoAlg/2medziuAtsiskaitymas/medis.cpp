#include <iostream>
#include <string>
//#include <vector>

using namespace std;

struct Node{
	int num;
	string name;
	string surname;
	string address;
	//vector<int> numbers;
	double account;
	Node* left;
	Node* right;
};
class BinTree{
	private:
		Node* root; 	//Root node'as nuo kurio viskas prasideda

		void insert (Node** tree,int num, string name, string surname, string address, double account){
			Node *temp = NULL;
			if (!(*tree)){
				temp = new Node;
				temp->left  = NULL;
				temp->right = NULL;
				temp->num  = num;
				temp->name  = name;
				temp->surname  = surname;
				temp->address  = address;
				temp->account  = account;
				*tree = temp;
				return;
			}
			if (num < (*tree)->num){
				insert(&(*tree)->left, num, name, surname, address, account);
			}else if (num >= (*tree)->num){
				insert(&(*tree)->right, num,  name, surname, address, account);
			}
		}

		Node* search(Node ** tree, int num, int count) {
			++count;
			if(!(*tree)) {
				cout << "Vartotojas su tokiu numeriu nerastas" << endl;
				cout << "Perejo per " << count << " elementus" << endl;
				return NULL;
			}

			if(num < (*tree)->num) {
				search(&((*tree)->left), num, count);
			}
			else if(num > (*tree)->num) {
				search(&((*tree)->right), num, count);
			}
			else if(num == (*tree)->num) {
				// Mano pakeitimas del nepavykusio tel.numeriu masyvo implementacijos
				// Vietoj masyvo dydzio tikrinama saskaitos numerio reiksme
				if ((*tree)->account < 0) {
					cout << (*tree)->name << ' ' << (*tree)->surname << ' '<< (*tree)->account << ' ' << endl;
				}
				cout << "Perejo per " << count << " elementu" << endl;
				return *tree;

			}
		}

		void print_inorder(Node * tree) {
			if (tree) {
			print_inorder(tree->left);

			cout << tree->num  << ' ' << tree->name << ' ' << tree->surname << ' ' << tree->address << ' ' << tree->account << ' ' << endl;

			print_inorder(tree->right);
			}
		}

	public:
		//Funkcijos skirtos "vartotojui"
		void insert(int num, string name, string surname, string address, double account){
			insert(&root,num, name, surname, address, account);
		}
		void printTree(){
			print_inorder(root);
		}

		Node* search(int num){
			search(&root, num, 0);
		}

		BinTree(){
			root = NULL;
		}

		~BinTree(){
		}



};

int main (){
	BinTree medis;
	medis.insert(5, "Benas", "Pavardenis", "Nebuties g. 1", 132.46);
	medis.insert(8, "Adoms", "Balionas", "Nebuties g. 2", 132465.00);
	medis.insert(3, "Carlo", "Polo", "Nebuties g. 3", -132.465);
	medis.insert(1, "Jonas", "Jonaitis", "Nebuties g. 4", 0.10);
	medis.insert(2, "Saulė", "Menulytė", "Nebuties g. 5", -777.0);
	medis.insert(4, "Testas", "Feilas", "Nebuties g. 6", 654.321);
	medis.insert(6, "Gailius", "Nežinomas", "Nebuties g. 7", -1.00);
	medis.insert(7, "Tomas", "Chormas", "Nebuties g. 8", 0.465);
	medis.insert(9, "Ona", "One", "Nebuties g. 9", 7683.54);
	medis.insert(10, "Paula", "Cola", "Nebuties g. 10", 375.23);
	medis.printTree();
	medis.search(2);
	medis.search(11);
	
	return 0;
}
