#include<bits/stdc++.h>

using namespace std;

class SpeedupTest;

struct Thread_args{
    int thread_id, threads_count;
	SpeedupTest * friend_this;
	double * ans;
};

double generate_random(){
	const int max_rand = 10000;
	double ans = rand() % max_rand;
	return ans / max_rand;
}

double generate_special_matrix(int row){
	if(row < 4000)
		return 1;
	if(row >= 8000)
		return 2;
	return 0;
}