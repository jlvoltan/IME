#include<bits/stdc++.h>
#include "Timer.cpp"
#include "utils.cpp"

using namespace std;


class SpeedupTest{
	public:
		const int dim, hdim;
		double **mat;

		SpeedupTest(): dim(16000), hdim(8000){
			mat = new double*[dim];
			for(int i=0; i < dim; i++){
				mat[i] = new double[dim];
				for(int j=0; j < dim; j++)
					mat[i][j] = generate_random();
			}
		}

		~SpeedupTest(){
			for(int i=0; i<dim; i++)
				delete[] mat[i];
			delete[] mat;
		}

		double work(){
			double ans = 0;
			for(int i=0; i<dim; i++)
				for(int j=0; j<dim; j++)
					ans += mat[i][j] * mat[i][i];
			return ans;
		}
};

main(){
	srand(time(NULL));
	SpeedupTest obj;
	Timer timer;
	printf("global sum: %lf,  elapsed time: %lf\n", obj.work(), timer.get_elapsed_time());
}