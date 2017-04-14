class Processo{
public:
	int tExecutando, nIO, tCPU;
	Processo(int tCPU = -1, int nIO = -1) : tCPU(tCPU), nIO(nIO){
		tExecutando = 0;
	}
};