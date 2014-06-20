// This module provides functions, which is necessary working with stack.

// Version history:
// v0: Created mod.c and mod.h files
// v1: used if sentences to fix some problems
//     added debugging mode (#define DEBUG 0)
// v2: now functions can operate with all types of variables

#define DEBUG 0
#include <stdio.h>
#include"mod.h"

//------------------------------------------------------------------------------
void push(struct Stack *s, int value)
{
  if (s->size >= MAX_DATA - 1)
  {
    #if DEBUG
      printf("Elementas nepridetas. Neuztenka masyve vietos.\n");
    #endif
  }
  else
  {
	s->data = realloc(s->data, (sizeof(s->data) + sizeof(int)));
    s->data[s->size] = value;
    s->size++;
    #if DEBUG
      printf("Pridetas elementas.\n");
    #endif
  }
}

//------------------------------------------------------------------------------
int pop(struct Stack *s)
{
  if (s->size > 0)
  {
    #if DEBUG
      printf("ispopintas elementas.\n");
    #endif
	
	s->data = realloc(s->data,sizeof(s->data) - sizeof(int));
    return s->data[--s->size];       
  }
  	printf("Stack nebeliko duomenu");
	return 1;
}

//------------------------------------------------------------------------------
void printStack(struct Stack *s){
	printf("There are %d elements in Stack\n", s->size);
	int i = 0;
	for(i = 0; i < s->size; i++){
		printf("%d elementas yra %d\n", i, s->data[i]);
	}
}
