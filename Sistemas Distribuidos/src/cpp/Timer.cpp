#include <sys/time.h>


class Timer{
	struct timeval begin;
	double begin_seconds;
public:

	Timer(){
		reset();
	}

	void reset(){
		gettimeofday(&begin, NULL);
		begin_seconds = begin.tv_sec + begin.tv_usec*1e-6;
	}

	double get_elapsed_time(){
		struct timeval end;
		gettimeofday(&end, NULL);
		double end_seconds = end.tv_sec + end.tv_usec*1e-6;
		return end_seconds - begin_seconds;
	}
};