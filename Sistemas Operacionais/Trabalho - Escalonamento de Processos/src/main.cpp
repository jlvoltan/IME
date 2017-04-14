#include <bits/stdc++.h>
#include "gerenciador.h"

#define db(x) cerr << #x << " == " << x << endl
#define dbs(x) cerr << x << endl		//dbs(a _ b);
#define _ << ", " <<

using namespace std;

main(){
	Gerenciador gerenciador;
	int n;
	printf("Insira o numero de processos em Q0:\n");
	scanf("%d", &n);
	for(int i=1; i<=n; i++){
		int tCPU, nIO;
		printf("Insira a duracao do surto de CPU e o numero de operacoes de E/S do processo %d: \n", i);
		scanf("%d%d",&tCPU, &nIO);
		gerenciador.inserirQ0(tCPU, nIO);
	}
	printf("\nInsira o numero de processos em Q1:\n");
	scanf("%d", &n);
	for(int i=1; i<=n; i++){
		int tCPU, nIO;
		printf("Insira a duracao do surto de CPU e o numero de operacoes de E/S do processo %d: \n", i);
		scanf("%d%d",&tCPU, &nIO);
		gerenciador.inserirQ1(tCPU, nIO);
	}
	gerenciador.simular();
}