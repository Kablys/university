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
	int low_value  = (comm_rank) * (n) / comm_size;
	int high_value = (comm_rank + 1) * (n) / comm_size;
//printf(" ir kitas %d, %d, %d, %d",high_value, comm_rank, n,comm_size);

int max = 0;
int index = 0;

		for(int i = low_value; i <= high_value; i++){
int x = i;
			 int j = 0;
			  while (x > 1) {
			    if (x%2 == 1) x = 3*x + 1;
			    else x = x/2;
			    j++;	
			  }
			if (j > max){
			 max = j;
			index = i;
			}
			  	
		}
//printf("%d, %d, %d,",max, low_value, high_value);


	//Sum results from all processes
	int global_max;
	if (comm_size > 1) {
		//From functional programming fold/inject
		MPI_Reduce(&max, 	//data to be sent
				&global_max,	//result, only for root process
				2,				//result size
				MPI_INT, 		//result type
				MPI_MAX,		//operation to apply to all data
				0,				//root node rank
				MPI_COMM_WORLD);//communicator
	} else {
		global_max = max;
	}
	
	runtime += MPI_Wtime();
	if (comm_rank == 0) {
		printf("Using %d processes, in %f seconds we found max iterations %d less than or equal to %d.\n",
			comm_size, runtime, global_max, n);
	}
	
	MPI_Finalize();
	return 0;
}
