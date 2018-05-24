#include<bits/stdc++.h>
#include<mpi.h>
#include <pthread.h>
#include "Timer.cpp"
#include "utils.cpp"

using namespace std;

void * work(void * args);

class SpeedupTest{
	public:
		int world_rank, world_size, partition_num;
		const int dim, hdim;
		double **mat;

		SpeedupTest(int world_rank, int world_size): dim(16000), hdim(8000){
			this->world_rank = world_rank;
			this->world_size = world_size;

			mat = new double*[dim];
			for(int i=0; i<dim; i++)
				mat[i] = new double[dim];

			if(world_rank == 0){
				for(int i=0; i < dim; i++)
					for(int j=0; j < dim; j++)
						mat[i][j] = generate_special_matrix(i);
			}else{
				partition_num = world_rank - 1;
				int i_delta = get_i_delta(partition_num);

				for(int i=i_delta; i<i_delta+hdim; i++)
					MPI_Recv(mat[i], dim, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
			}
		}

		~SpeedupTest(){
			for(int i=0; i<dim; i++)
				delete[] mat[i];
			delete[] mat;
		}


		void send_mpi(){
			if(world_rank == 0 and world_size == 3)
				for(int num=0; num<2; num++){
					int i_delta = get_i_delta(num);
					for(int i=i_delta; i<i_delta+hdim; i++)
						MPI_Send(mat[i], dim, MPI_DOUBLE, num+1, 0, MPI_COMM_WORLD);
				}
		}

		double threads_calc(){
			double ans = 0;
			int threads_count = 2;
			pthread_t threads[threads_count];
			double partial_sum[threads_count];
			Thread_args args[threads_count];
			for(int i=partition_num; i<threads_count; i++){
				args[i].thread_id = i + (i > partition_num);
				args[i].friend_this = this;
				args[i].ans = partial_sum + i;
				partial_sum[i] = 0;
				pthread_create(&threads[i], NULL, &work, &args[i]);
			}
			for(int i=partition_num; i<threads_count; i++){
				pthread_join(threads[i], NULL);
				ans += partial_sum[i];
			}
			return ans;
		}

		int get_i_delta(int partition_num){
			return (partition_num % 2) * hdim;
		}

		int get_j_delta(int partition_num){
			return (partition_num > 1) * hdim;
		}

		friend void * work(void * args);
};

void * work(void * args){
	Thread_args * thread_args = (Thread_args *) args;
	SpeedupTest * friend_this = thread_args->friend_this;
	double * ans = thread_args->ans;
	int thread_id = thread_args->thread_id;

	int i_delta = friend_this->get_i_delta(thread_id);
	int j_delta = friend_this->get_j_delta(thread_id);

	const int hdim = friend_this->hdim;

	for(int i=0; i<hdim; i++)
		for(int j=0; j<hdim; j++)
			(*ans) += friend_this->mat[i_delta + i][j_delta + j] * friend_this->mat[i_delta + i][i_delta + i];
	printf("local sum: %lf,  thread id: %d\n", *ans, thread_id);
}

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
		local_sum = obj.threads_calc();
		printf("local sum: %lf, rank: %d\n", local_sum, obj.world_rank);
	}

	MPI_Reduce(&local_sum, &global_sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	if(world_rank == 0){
		printf("global sum: %lf\n", global_sum);
		printf("elapsed time: %lf\n", timer.get_elapsed_time());
	}

	MPI_Finalize();
}