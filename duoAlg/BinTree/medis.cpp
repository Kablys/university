#include <iostream>
#include <stdlib.h>

using namespace std;
class BinTree{
	private:
		struct Node{
			string name;	// key value
			Node* left;
			Node* right;
			int phone;
		};
		
		Node* root;
	public:
		BinTree(){
			root = NULL;
		};
		~BinTree(){
			destroyTree(root);
		};

		void setNode (string name, int phone, Node* leaf){//TODO
			leaf = new Node;
			leaf->name = name;
			leaf->phone = phone;
			leaf->left = NULL;
			leaf->right = NULL;
		};

		void insertNode(string _name, int _phone, Node* leaf){
			if(_name < leaf->name){
				if (leaf->left!=NULL){
					insertNode (_name, _phone, leaf->left);
				}else{
					setNode(_name, _phone, leaf->left);//TODO
				}
			}else if(_name >= leaf->name){
				if (leaf->right!=NULL){
					insertNode (_name, _phone, leaf->right);
				}else{
					setNode(_name, _phone, leaf->right);//TODO
				}
			}
		};

		void insertNode(string _name, int _phone){
			if(root!=NULL){
				insertNode(_name, _phone, root);
			}else{
				setNode(_name, _phone, root);//TODO
			}
		}
		void printTree(Node *leaf){
			if(leaf!=NULL){
				printTree(leaf->left);
				printTree(leaf->right);
				delete leaf;
			}
		};

		void destroyTree(Node *leaf){
			if(leaf!=NULL){
				destroyTree(leaf->left);
				destroyTree(leaf->right);
				delete leaf;
			}
		};
}

int main (){
	BinTree medis;
	medis.insert(112,"Gelbetojas")
}

//def binary_tree_delete(self, key):
//    if key < self.key:
//        self.left_child.binary_tree_delete(key)
//    elif key > self.key:
//        self.right_child.binary_tree_delete(key)
//    else: # delete the key here
//        if self.left_child and self.right_child: # if both children are present
//            successor = self.right_child.find_min()
//            self.key = successor.key
//            successor.binary_tree_delete(successor.key)
//        elif self.left_child:   # if the node has only a *left* child
//            self.replace_node_in_parent(self.left_child)
//        elif self.right_child:  # if the node has only a *right* child
//            self.replace_node_in_parent(self.right_child)
//        else: # this node has no children
//            self.replace_node_in_parent(None)
