#include <memory>
#include <iostream>

/// Binary Search Tree
template<class T> class bstree {
protected:
	struct node;	// forward declaration
	typedef std::unique_ptr<node> ptr;
	struct node {
		ptr left;	// left node (if any)
		ptr right;	// right node (if any)
		T value;	///< stored value
	//------------------------------------------------ node: construction
		node() {}
		node( const T& value, node* left = nullptr, node* right = nullptr)
		: left(left), right(right), value(value) {}
		node( T&& value, node* left = nullptr, node* right = nullptr)
		: left(left), right(right), value(value) {}
	//--------------------------------------------------- node: deep copy
	///	Make a deep copy of all nodes. May be called on null as well.
		node* copy() {
			return !this ? nullptr : new node(value, left->copy(), right->copy());
		}
	//-------------------------------------------------- node: find value
	/// Find node with specified value. May be called on null as well.
		node* find(const T& what) {
			node* it = this;
			while(it) {
				if(what < value)
					it = it->left.get();	// get() yra std::unique_ptr priklausanti funkcija
				else if(what > value)
					it = it->right.get();
				else break;
			}
			return it;	//kai it pasieks nullptr while baigsis ir funkcija grazins nullptr
		}
	//------------------------------------------------- node: place value
	/// Find place for new node \return null if already there
		ptr* where(const T& what) {
			node* it = this;
			ptr* where;
			while(true) {
				if(what < it->value) {
					if(!it->left) 
						return &it->left;
					it = it->left.get();
				} else if(what > it->value) {
					if(!it->right) 
						return &it->right;
					it = it->right.get();
				} else return nullptr;
			}
		}
	};
//================================================================== data
protected:
	ptr root;		///< root node
	size_t count;	///< total number of nodes
//====================================================== ctor, copy, move
public:
///	Default constructor for empty tree
	bstree(): root(), count(0) {}
//note: no need for a destructor, we use managed pointers
//	~bstree() {}
///	Copy constructor
	bstree(const bstree& src)
	: root(src.root->copy()), count(src.count) {}
///	Move constructor
	bstree(bstree&& rhs)
	: root(std::move(rhs.root)), count(rhs.count) {
		rhs.count = 0; }
///	Move assignment
	bstree& operator = (bstree&& rhs) {
		root.swap(rhs.root);
		std::swap(count, rhs.count);
		return *this; }
///	Copy assignment
	bstree& operator = (const bstree& rhs) {
		if (this != &rhs) {// no self-copy
			root.reset(rhs.root->copy());
			count = rhs.count; }
		return *this; }
//=============================================================== methods
public:
	bool contains(const T& value) {
		return root && root->find(value); 
	}
	bool insert(const T& value) {
		ptr* where = &root;
		if(root) {
			where = root->where(value);
			if(!where) 
				return false; 
		}
		where->reset(new node(value));
		++count; 
		return true;
	}
	bool insert(T&& value) {
		ptr* where = &root;
		if(root) {
			where = root->where(value);
			if(!where) 
				return false; 
		}
		where->reset(new node(value));
		++count; 
		return true;
	}
};

//#######################################################################

using std::cout;
using std::endl;

class test: protected bstree<int> {
	typedef bstree<int> base;
	void print(node* it) {
		if(!it) return;
		cout << '<' << it->value << ':';
		print(it->left.get()); cout << '|';
		print(it->right.get()); cout << '>';
	}
public:
	using base::contains;
	using base::insert;
public:
	test() { cout << "new" << endl; }
	test(test&& rhs): base(rhs) { cout << "move .ctor" << endl; }
	test(const test& src): base(src) { cout << "copy .ctor" << endl; }
	test& operator = (test&& rhs) {
		cout << "move assign" << endl;
		base::operator = ((base&&)rhs);
		return *this; }
	test& operator = (const test& src) {
		cout << "copy assign" << endl;
		base::operator = (src);
		return *this; }
	void print() {
		print(root.get()); cout << endl; }
};

int main() {
	test tree;
	tree.insert(3);
	tree.insert(2);
	tree.insert(4);
	cout << std::boolalpha << tree.insert(2) << endl; //boolalpha nustato kad true ir false spausdintu kaip teksta
	cout << tree.contains(3) << ' ' << tree.contains(1) << endl;
	tree.print();
	tree = tree;
	tree = std::move(tree);
	tree.print();
	tree.insert(1);
	tree.insert(5);
	tree.print();
}
