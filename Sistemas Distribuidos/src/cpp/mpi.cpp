#include<bits/stdc++.h>
#include<mpi.h>
#include "Timer.cpp"
#include "utils.cpp"

using namespace std;


class SpeedupTest{
	public:
		int world_rank, world_size, partition_num;
		const int dim, hdim;
		double **mat, *diagonal;

		SpeedupTest(int world_rank, int world_size): dim(16000), hdim(8000){
			this->world_rank = world_rank;
			this->world_size = world_size;

			mat = new double*[dim];
			diagonal = new double[dim];
			for(int i=0; i<dim; i++)
				mat[i] = new double[dim];

			if(world_rank == 0){
				for(int i=0; i < dim; i++){
					for(int j=0; j < dim; j++)
						mat[i][j] = generate_random();
					diagonal[i] = mat[i][i];
				}
			}else{
				partition_num = world_rank - 1;
				int i_delta = get_i_delta(partition_num);
				int j_delta = get_j_delta(partition_num);
				int row_size = (world_size <= 3)? dim : hdim;
				MPI_Recv(diagonal+i_delta, hdim, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

				for(int i=i_delta; i<i_delta+hdim; i++)
					MPI_Recv(mat[i]+j_delta, row_size, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
			}
		}

		~SpeedupTest(){
			delete[] diagonal;
			for(int i=0; i<dim; i++)
				delete[] mat[i];
			delete[] mat;
		}

		void send_mpi(){
			if(world_rank == 0 and world_size > 1){
				for(int num=0; num<world_size-1; num++){
					int i_delta = get_i_delta(num);
					int j_delta = get_j_delta(num);
					int row_size = (world_size <= 3)? dim : hdim;
					MPI_Send(diagonal+i_delta, hdim, MPI_DOUBLE, num+1, 0, MPI_COMM_WORLD);
					for(int i=i_delta; i<i_delta+hdim; i++)
						MPI_Send(mat[i]+j_delta, row_size, MPI_DOUBLE, num+1, 0, MPI_COMM_WORLD);
				}
			}
		}

		int get_i_delta(int partition_num){
			return (partition_num % 2) * hdim;
		}

		int get_j_delta(int partition_num){
			return (partition_num > 1) * hdim;
		}

		double work(){
			double ans = 0;
			int i_delta, j_delta;
			int row_size = ((world_rank == 0) or (world_size <= 3))? dim : hdim;
			int column_size = (world_rank == 0)? dim : hdim;
			if(world_rank == 0){
				i_delta = j_delta = 0;
			}else{
				i_delta = get_i_delta(partition_num);
				j_delta = get_j_delta(partition_num);
			}			
			for(int i=0; i<column_size; i++)
				for(int j=0; j<row_size; j++)
					ans += mat[i_delta + i][j_delta + j] * diagonal[i_delta + i];
			return ans;
		}
};

main(){
	MPI_Init(NULL, NULL);
	int world_rank, world_size;
	double local_sum, global_sum;
	local_sum = global_sum = 0;
	MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
	MPI_Comm_size(MPI_COMM_WORLD, &world_size);
	srand(time(NULL));

	SpeedupTest obj(world_rank, world_size);
	Timer timer;
	if(world_rank == 0){
		obj.send_mpi();
	}else{
		local_sum = obj.work();
		printf("local sum: %lf, rank: %d\n", local_sum, obj.world_rank);
	}

	MPI_Reduce(&local_sum, &global_sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	if(world_rank == 0)
		printf("global sum: %lf,  elapsed time: %lf\n", global_sum, timer.get_elapsed_time());

	MPI_Finalize();
}