#include "mpi.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char ** argv) {
	MPI_Init(&argc, &argv);
	int comm_rank;
	int comm_size;
	MPI_Comm_rank(MPI_COMM_WORLD, &comm_rank);// Id of thread
	MPI_Comm_size(MPI_COMM_WORLD, &comm_size);// Total number of threads

	MPI_Barrier(MPI_COMM_WORLD);//Block
	double runtime = -MPI_Wtime();//We subtrackt to get diffrence between beginning and end

	if (argc != 2) {
		if (comm_rank == 0){
			printf("Please supply a range.\n");
		}
		MPI_Finalize();
		exit(1);
	}
	int n = atoi(argv[1]);
  
	//Calculate size of array for each process
	long int low_value  = 2 + (long int)(comm_rank) * (long int)(n - 1) / (long int)comm_size;
	long int high_value = 1 + (long int)(comm_rank + 1) * (long int)(n - 1) / (long int)comm_size;
	int size = high_value - low_value + 1;
	
	char * marked = (char *) calloc(size, sizeof(char));// 0 prime, 1 non-prime
	
	if (marked == NULL) {
		printf("Unsuccessful memory allocation of size:%d for process %d \n", size, comm_rank);
		MPI_Finalize();
		exit(1);
	}
	
	int prime = 2;
	int first;	
	int index;
	if (comm_rank == 0){
		index = 0;
	}
	do {
		// determen where to start marking
		if (prime * prime > low_value) {
			first = prime * prime - low_value;
		} else {
			//if lower bound is multiple of prime
			if ((low_value % prime) == 0) {
				first = 0;
			}else {
				first = prime - (low_value % prime);
			}
		}
		
		//mark all multiples of prime
		for (int i = first; i < size; i += prime){
			marked[i] = 1;
		}
		
		if (comm_rank == 0) {
			while (marked[++index]);
			prime = index + 2;
		}
		
		if (comm_size > 1){
			MPI_Bcast(&prime,	//buffer
					1,			//buffer size
					MPI_INT,	//buffer data type
					0,			//root node rank
					MPI_COMM_WORLD);//communicator
		}
	} while (prime * prime <= n);
	
	//Count number of primes
	int count = 0;
	for (int i = 0; i < size; i++){
		if (marked[i] == 0){
			count++;
		}
	}

	//Sum results from all processes
	int global_count;
	if (comm_size > 1) {
		//From functional programming fold/inject
		MPI_Reduce(&count, 	//data to be sent
				&global_count,	//result, only for root process
				1,				//result size
				MPI_INT, 		//result type
				MPI_SUM,		//operation to apply to all data
				0,				//root node rank
				MPI_COMM_WORLD);//communicator
	} else {
		global_count = count;
	}
	
	runtime += MPI_Wtime();
	if (comm_rank == 0) {
		printf("Using %d processes, in %f seconds we found %d primes less than or equal to %d.\n",
			comm_size, runtime, global_count, n);
	}
	
	MPI_Finalize();
	return 0;
}
