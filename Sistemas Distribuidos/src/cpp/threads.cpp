#include<bits/stdc++.h>
#include <pthread.h>
#include "Timer.cpp"
#include "utils.cpp"

using namespace std;

void * work(void * args);

class SpeedupTest{
	public:
		const int dim, hdim;
		double **mat;

		SpeedupTest(): dim(16000), hdim(8000){
			mat = new double*[dim];
			for(int i=0; i<dim; i++)
				mat[i] = new double[dim];

			for(int i=0; i < dim; i++){
				for(int j=0; j < dim; j++)
					mat[i][j] = generate_random();
			}
		}

		~SpeedupTest(){
			for(int i=0; i<dim; i++)
				delete[] mat[i];
			delete[] mat;
		}

		double threads_calc(int threads_count){
			double ans = 0;
			pthread_t threads[threads_count];
			double partial_sum[threads_count];
			Thread_args args[threads_count];
			for(int i=0; i<threads_count; i++){
				args[i].thread_id = i;
				args[i].threads_count = threads_count;
				args[i].friend_this = this;
				args[i].ans = partial_sum + i;
				partial_sum[i] = 0;
				pthread_create(&threads[i], NULL, &work, &args[i]);
			}
			for(int i=0; i<threads_count; i++){
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
	int threads_count = thread_args->threads_count;
	int thread_id = thread_args->thread_id;

	int i_delta, j_delta;
	int row_size = (threads_count <= 2)? friend_this->dim : friend_this->hdim;
	int column_size = friend_this->hdim;

	i_delta = friend_this->get_i_delta(thread_id);
	j_delta = friend_this->get_j_delta(thread_id);

	for(int i=0; i<column_size; i++)
		for(int j=0; j<row_size; j++)
			(*ans) += friend_this->mat[i_delta + i][j_delta + j] * friend_this->mat[i_delta + i][i_delta + i];
	printf("local sum: %lf,  thread id: %d\n", *ans, thread_id);
}

main(int argc,char* argv[]){
	srand(time(NULL));
	SpeedupTest obj;
	int threads_count = int (argv[1][0] - '0');
	Timer timer;
	printf("global sum: %lf,  elapsed time: %lf\n", obj.threads_calc(threads_count), timer.get_elapsed_time());
}