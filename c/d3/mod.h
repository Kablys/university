#include <stdlib.h>
#define MAX_DATA 30

struct Stack {
  int *data;
  int size;
};  
// This function adds element to the end of the structure.
void push(struct Stack *s, int value);

// This function removes element from the end of the structure.
int pop(struct Stack *s);

// This function prints how many elements and how many there are in Stack
void printStack(struct Stack *s);
