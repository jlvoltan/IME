class Processo{
public:
	int tExecutando, nIO, pId, tCPU;
	Processo(int tCPU = -1, int nIO = -1, int pId = -1) : pId(pId), tCPU(tCPU){
		this->tExecutando = 0;
		this->nIO = nIO;
	}
};