#include <bits/stdc++.h>
#include "processo.h"
#include "gantt.h"

using namespace std;

const int INF = 0x3f3f3f3f;

class Fila{
protected:
	vector<Processo> * mapId;
	queue<int> qPId;
public:
	Fila(vector<Processo> * mapId = NULL) : mapId(mapId){}
	virtual void inserir(int pId, int tempo) = 0;
};

//forward declaration
class Q1;
class IO;

class Q0 : public Fila{
private:
	int quantum;
	int inicio;
	bool ativo;
public:
	Q0(vector<Processo> * mapId = NULL, int quantum = 10) : Fila(mapId), quantum(quantum){
		ativo = false;
	}
	bool ativar(int tempo){
		if(!qPId.empty() and !ativo){
			inicio = tempo;
			ativo = true;
		}
		return ativo;
	}
	void inserir(int pId, int tempo){
		qPId.push(pId);
		ativar(tempo);
	}
	int tProximoEvento(bool & preempcao){
		preempcao = false;
		
		if(qPId.empty())
			return INF;
		else{
			Processo atual = (*mapId)[qPId.front()];
			if( min(quantum, atual.tCPU - atual.tExecutando) == quantum and
				atual.tCPU - atual.tExecutando != quantum)
				preempcao = true;
			return inicio + min(quantum, atual.tCPU - atual.tExecutando);
		}
	}
	void finalizar(int tempo, Gantt & gantt, Q1 & q1, IO & io, int & n);
};

class IO : public Fila{
private:
	int tInicio;
	int tIO;
public:
	IO(vector<Processo> * mapId = NULL, int tIO = 20) : Fila(mapId), tIO(tIO){
		tInicio = INF;
	}
	void inserir(int pId, int tempo){
		if(qPId.empty())
			tInicio = tempo;
		qPId.push(pId);
	}
	int tProximoEvento(){
		if(qPId.empty())
			return INF;
		else
			return tInicio+tIO;
	}
	bool finalizar(int tempo, Q0 & q0){
		int pId = qPId.front();
		qPId.pop();
		if(!qPId.empty())
			tInicio = tempo;
		else
			tInicio = INF;
		if(--(*mapId)[pId].nIO >= 0){
			//Repassando para Q0
			q0.inserir(pId, tempo);
			return true;
		}
		else
			return false;
	}
};

class Q1 : public Fila{
private:
	int tPromocao;
	int executando, tInicioExecucao;
	queue<int> qTChegada;
public:
	Q1(vector<Processo> * mapId = NULL, int tPromocao = 40) : Fila(mapId), tPromocao(tPromocao){
		executando = 0;
	}
	void inserir(int pId, int tempo){
		qPId.push(pId);
		qTChegada.push(tempo);
	}
	int tProximaPromocao(){
		if(qPId.empty())
			return INF;
		else
			return qTChegada.front() + tPromocao;
	}
	int tProximoCompleto(){
		if(executando){
			Processo atual = (*mapId)[executando];
			return tInicioExecucao + atual.tCPU - atual.tExecutando;	
		}
		else
			return INF;
	}
	void parar(int tempo, Gantt & gantt, bool preempcao){
		if(executando){

			gantt.inserir(executando, tInicioExecucao, tempo);
			if(preempcao)
				inserir(executando, tempo);

			(*mapId)[executando].tExecutando += tempo - tInicioExecucao;
			executando = 0;
		}
	}
	void ativar(int tempo){
		if(!executando and !qPId.empty()){
			tInicioExecucao = tempo;
			executando = qPId.front();
			qPId.pop();
			qTChegada.pop();
		}
	}
	void promover(int tempo, Gantt & gantt, Q0 & q0){
		int pId = qPId.front();
		parar(tempo, gantt, true);
		//repassando para Q0
		q0.inserir(pId, tempo);
		qPId.pop();
		qTChegada.pop();
		
	}
	void finalizar(int tempo, Gantt & gantt, IO & io, int & n){
		int pId = executando;
		parar(tempo, gantt, false);
		(*mapId)[pId].tExecutando = 0;
		if((*mapId)[pId].nIO){
			//repassando para IO
			io.inserir(pId, tempo);
		}
		else
			n--;
		ativar(tempo);
	}
};

void Q0::finalizar(int tempo, Gantt & gantt, Q1 & q1, IO & io, int & n){
	bool preempcao;
	tProximoEvento(preempcao);
	int pId = qPId.front();
	qPId.pop();
	ativo = false;

	gantt.inserir(pId, inicio, tempo);

	(*mapId)[pId].tExecutando += tempo - inicio;

	if(preempcao){
		//repassando para Q1
		q1.inserir(pId, tempo);
	}
	else{
		(*mapId)[pId].tExecutando = 0;
		if((*mapId)[pId].nIO){
			//repassando para IO
			io.inserir(pId, tempo);
		}
		else
			n--;
	}
	ativar(tempo);
}