#define MAX 100

struct bst{
	int data;
	int lindex;
	int rindex;
};

void MakeNote(struct bst * tree, int data){
	tree->data = data;
	tree->lindex = -1;
	tree->rindex = -1;
}

void Insertleft( struct bst *tree, int data){
	MakeNode(tree, data);
}

void Insertright( struct bst *tree, int data){
	MakeNode(tree, data);
}

void Insert(struct bst * tree, int treeIndex, int data){
	int  baseIndex = 0;

	while(baseIndex <= treeIndex){
		if (data <= tree[baseIndex].data){
			if (tree[baseIndex].lindex == -1){
				tree[baseIndex].lindex = treeIndex;
				Insertleft(&tree[treeIndex], data);
				return;
			}
			else{
				baseIndex = tree[baseIndex].lindex;
				continue;
			}
		}
		else{
			if(tree[baseIndex].rindex == -1){
				tree[baseIndex].rindex = treeIndex;
				Insertright(&tree[treeIndex], data);
				return;
			}
			else{
				baseIndex = tree[baseIndex].lindex
				continue;
			}
		}
	}
}
int main(){
	struct bst tree[MAX];
	memset(tree, 0, sizeof(tree));
	int treeIndex = 0;

	MakeNote(&tree [treeIndex], 50);
	treeIndex++;
	Insert(tree, treeIndex, 10);
	return 0
}
