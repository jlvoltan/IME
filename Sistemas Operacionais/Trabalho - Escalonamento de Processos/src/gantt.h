#include <bits/stdc++.h>

using namespace std;

class Gantt{
private:
	vector<int> inicio, fim, vPId;
public:
	void inserir(int pId, int tInicio, int tFim){
		if(!vPId.empty() and fim.back() != tInicio){
			vPId.push_back(0);
			inicio.push_back(fim.back());
			fim.push_back(tInicio);
		}
		vPId.push_back(pId);
		inicio.push_back(tInicio);
		fim.push_back(tFim);
	}
	void imprimir(){
		for(int i=0; i < vPId.size(); i++)
			printf("Processo: %d, Inicio: %d ms, Fim: %d ms\n", vPId[i], inicio[i], fim[i]);
	}
};