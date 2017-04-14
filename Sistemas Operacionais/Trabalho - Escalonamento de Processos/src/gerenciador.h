#include <bits/stdc++.h>
#include "filas.h"

using namespace std;

class Gerenciador{
private:
	vector<Processo> mapId;
	Q0 q0;
	Q1 q1;
	IO io;
	Gantt gantt;
	int tempo, n;
public:
	Gerenciador(int nProcessos = 1000){
		q0 = Q0(&mapId);
		q1 = Q1(&mapId);
		io = IO(&mapId);
		tempo = n = 0;
		mapId.resize(nProcessos);
	}
	void inserirQ0(int tCPU, int nIO){
		n++;
		mapId[n] = Processo(tCPU, nIO);
		q0.inserir(n, tempo);
	}
	void inserirQ1(int tCPU, int nIO){
		n++;
		mapId[n] = Processo(tCPU, nIO);
		q1.inserir(n, tempo);
	}
	void simular(){
		bool preempcao;
		if(!q0.ativar(tempo))
			q1.ativar(tempo);
		while(n){
			vector<int> tempos;
			tempos.push_back(q0.tProximoEvento(preempcao));
			tempos.push_back(io.tProximoEvento());
			tempos.push_back(q1.tProximaPromocao());
			tempos.push_back(q1.tProximoCompleto());
			sort(tempos.begin(), tempos.end());
			tempo = tempos[0];
			if(tempo == q1.tProximoCompleto()){
				q1.finalizar(tempo, gantt, io, n);
			}
			else if(tempo == q1.tProximaPromocao()){
				q1.promover(tempo, gantt, q0);
			}
			if(tempo == io.tProximoEvento()){
				if(io.finalizar(tempo, q0))
					q1.parar(tempo, gantt);
			}
			if(tempo == q0.tProximoEvento(preempcao)){
				q0.finalizar(tempo, gantt, q1, io, n);
				if(q0.ativar(tempo) == false){
					q1.ativar(tempo);
				}
			}
		}
		gantt.imprimir();
	}
};