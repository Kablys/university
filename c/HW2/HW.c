#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#define MIN 2
#define MAX 100
int checkInput(int lowerLimit,int upperLimit){	//checks if input is number and if it between limits
	int n = 0;
	while (1){
		if((scanf("%d",&n) == 1) && (n >= lowerLimit) && (n <= upperLimit) && (getchar() == '\n')){
			break;
		}
		else{
			printf("You need to input number between %d and %d:",lowerLimit,upperLimit);
			while(getchar() != '\n')
			;
		}
	};
	return n;	
}//chechInput

int checkMainArg(int argc,char argv[]){
	if (argc >= 2){
		if (argc > 2){
			printf("Using just first argument %s\n", argv);
		}
		char *end;
		int j = strtol(argv, &end, 10); //turn string argv into integer j if string is wrong gives pointer end to wrong string
			
		if (!*end){
			if (j >= MIN){
				printf("Maximum size of array set to %d\n", j);
				return j;
			}
			else{
				printf("Argument value must be more then %d, in your case it was %d\n",MIN, j); 
				printf("Maximum size of array set to default value %d\n", MAX);
				return MAX;
			}
		}
		else{
			printf("Argument conversion error, non-convertible part: %s\n", end); 
			printf("Maximum size of array set to default value %d\n", MAX);
			return MAX;
		}
	}
	else{
		printf("No argument received\n"); 
		printf("Maximum size of array set to default value %d\n", MAX);
		return MAX;
	}
}//checkMainArg	

int sumArray(int z,int arr[]){		//returns sum of all array numbers
	int sum = 0,
		i = 0;
	for (i = 0; i < z; i++){
			sum += arr[i];
	};
	return sum;
}//sumArray

void copyArray(int n,int to[],int from[]){
	int i = 0;
	for (i = 0; i < n; i++){
		to[i] = from[i];
	}
}//copyArrayz

int absoluteValue(int value){
	if (value < 0)	//makes difference into absolute value
		value *= -1;
	return value;	
}//absoluteValue

void iterateBinArr (int oneZero[]){
	int i = 0;
	while(1){
			if (oneZero[i] == 0){
				oneZero[i] = 1;
				break;
			}
			else if (oneZero[i] == 1){
				oneZero[i] = 0;
				i += 1;
			}
	}
}//iteratebinarr	

void checkArray(int n, int oneZero[], int start[], int *dif, int resultArray1[], int resultArray2[]){
	int difference = 0,
		*interim1 = calloc(n,sizeof(int)),
		*interim2 = calloc(n,sizeof(int));
	int i = 0,
		j = 0,
		k = 0;
	for (i = 0, j = 0, k = 0; i<n; i++){	//splits array in two according to oneZero
		if(oneZero[i] == 1){
			interim1[j] = start[i];
			j++;
		}
		else if (oneZero[i] == 0)
		{
			interim2[k] = start[i];
			k++;	
		}
	}

	//assigns difference of two arrays and makes it absolute value
	difference = sumArray(n,interim1) - sumArray(n,interim2);
	difference = absoluteValue(difference);

	if (difference < *dif){	//checks new difference with old one
		*dif = difference;	//if smaller assigns smaller value
		copyArray(n,resultArray1,interim1);		//and new arrays
		copyArray(n,resultArray2,interim2);
	}
	free(interim1);
	free(interim2);
}//checkArray

void printArray(int z,int arr[]){	//prints int array(excluding 0)
	int i = 0;
	printf("[");
	for (i = 0; i < z; i++){
		if (arr[i] != 0){
			if (i > 0)
				printf(", ");
			printf("%d",arr[i]);
		}
	}
	printf("]\n");
}//printArray

void printResults(int n, int dif, int resultArray1[], int resultArray2[]){
	printf("The smallest difference was %d and arrays are\n",dif);
	printArray(n, resultArray1);
	printArray(n, resultArray2);

}//printResults

void drawMenu(){
	printf("\n");
	printf("Input Action \n");
	printf("1     Enter size of array\n");
	printf("2     Enter integers fot array\n");
	printf("3     Split array\n");
	printf("4     Print results\n");
	printf("5     Exit program\n");
	printf("Your input:");
}//drawMenu

int nextStep (int current,int last){
	if (last < current-1){
		printf("You missed step %d\n",last+1);
		return 0;
	}
	return 1;
}//nextStep

int main (int argc, char *argv[] ){
	int n = 0,			//size of arrays
		i = 0,
		maxArraySize = checkMainArg(argc, argv[2]), //changes array size depending on arguments given to program
		dif = INT_MAX,	//for searching smalles difference
		step = 0,
		exit = 1,
		navigMenu = 0,
		*data = malloc(1 * sizeof (*data)), 		//array for input data
		*oneZero = malloc(1 * sizeof (*oneZero)),		//holds binary numbers for comparing arrays
		*resultArray1 = malloc(1 * sizeof (*resultArray1)),	//holds first result array
		*resultArray2 = malloc(1 * sizeof (*resultArray2));
	
	while (exit){
		drawMenu();
		switch (navigMenu = checkInput(1, 5)){

		case 1://Enter size of array
			printf("Size of array(number between %d-%d):", MIN, maxArraySize);
			n=checkInput(MIN, maxArraySize);
			data = realloc(data, n*sizeof(int)), 		//array for input data
			oneZero = realloc(oneZero, n*sizeof(int)),		//holds binary numbers for comparing arrays
			resultArray1 = realloc(resultArray1, n * sizeof(int)),	//holds first result array
			resultArray2 = realloc(resultArray2, n * sizeof(int));	//holds second result array
			step = 1;
			break;

		case 2://Enter integers fot array
			if ((nextStep(navigMenu,step)) == 0){break;};
			printf("Input %d numbers\n",n);
			for (i = 0; i < n; i++){				//input for data array
				data[i] = checkInput(INT_MIN, INT_MAX);
			};
			step = 2;
			break;

		case 3://Split array
			if ((nextStep(navigMenu,step)) == 0){break;};
			while (oneZero[n-1] == 0){				//creates binary number represented as array
				iterateBinArr(oneZero);
				checkArray(n, oneZero, data, &dif, resultArray1, resultArray2);
				printf("Sucsses! array was split\n");
			};
			step = 3;
			break;

		case 4://Print results
			if ((nextStep(navigMenu,step)) == 0){break;};
			printResults(n, dif, resultArray1, resultArray2);
			break;

		case 5://Exit program
			printf("Good Bye\n");
			exit = 0;
			break;

		default:
			printf("error %d %d", navigMenu, exit);
			break;
		}
	}
	free(data);
	free(oneZero);
	free(resultArray1);
	free(resultArray2);
	return 0;
}

