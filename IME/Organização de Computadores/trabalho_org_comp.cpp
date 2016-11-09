#include <bits/stdc++.h>
using namespace std;

enum tipo_dado{
    CARACTERES, INTEIRO
};

enum formato{
	LITTLE, BIG
};

class Armazenamento{
private:
		
	vector< pair<string, tipo_dado> > dados;

	void memorizar(string x){
   		int numero_palavras = (3 + x.length()) / 4, pos = 0;
   		for(int i=0; i< numero_palavras; i++){
   			char *temp;
   			temp = new char[4];
   			for(int j=0; j<4; j++){
   				if(pos <x.length())
   					temp[j] = x[pos];
   				else
   					temp[j] = 0;
   				pos++;
   			}
   			memoria.push_back(temp);
   			qual.push_back(CARACTERES);
   		}
   	}

   	void memorizar(int x){
   		char *salvar;
		salvar = new char[4];
		endian(salvar, x);
		memoria.push_back(salvar);
		qual.push_back(INTEIRO);
   	}

   	void memorizar(){
   		for(int i=0; i<dados.size(); i++)
   			if(dados[i].second == CARACTERES)
   				memorizar(dados[i].first);
   			else
   				memorizar( atoi(dados[i].first.c_str()) );
   	}

protected:

	std::vector<char*> memoria;
	std::vector<tipo_dado> qual;

	int converte_byte_int(char x){
		int res = 0, pot2 = 1;
		for(int k=0; k<8; k++){
			if(x & 1<<k)
				res += pot2; 
			pot2 *= 2;
		}
		return res;
	}

	virtual void endian(char* salvar, int x) = 0; 	
    
public:

	virtual void imprimir() = 0;

    ~Armazenamento(){
    	for(int i=0; i<memoria.size(); i++)
    		delete[] memoria[i];
    }

    void set_memoria(){
    	string entrada;
    	int i = 0;
    	cout<<"Insira o conjunto de informacoes:"<<endl;
    	getline(cin, entrada);
	   	while(i<entrada.size()){
	       	bool numero = true;
	       	string temp ="";
	       	while(i<entrada.size() and entrada[i]!=' '){
	           	if(entrada[i]>'9'||entrada[i]<'0')
	               	numero = false;
	           	temp+=entrada[i++];
	       	}
	       	if(temp != ""){
	           	if(numero)
	               	dados.push_back( make_pair(temp, INTEIRO) );
	           	else
	               	if(dados.size() && dados.back().second == CARACTERES )
	                   	dados.back().first+=" "+temp;
	               	else
	                   	dados.push_back( make_pair(temp, CARACTERES) );
	       	}
	       	i++;
	   	}
	   	memorizar();
    }

    void leitura(formato f){
    	cout << "Leitura " << (f == BIG? "Big Endian" : "Little Endian") << ":\n";
    	for(int i=0; i<memoria.size(); i++){
    		if(qual[i] == CARACTERES){
    			for(int j=0; j<4; j++){
    				if(memoria[i][j])
    					cout<<memoria[i][j];
    				else
    					break;
    			}
    		}
    		else{
    			cout << endl;
    			int pot256 = 1, temp = 0;
    			if(f == BIG)
    				for(int j = 3; j >=0; j--){
    					temp += converte_byte_int(memoria[i][j])*pot256;
    					pot256 *= 256;
    				}
    			else
    				for(int j = 0; j<4; j++){
    					temp+= converte_byte_int(memoria[i][j])*pot256;
    					pot256 *= 256;
    				}
    			cout << temp << endl;
    		}
    	}
    }

    int get_n_bytes(){
    	return memoria.size()*4;
    }

    int get_n_bits(){
    	return get_n_bytes()*8;
    }

    bool get_bit(int pos){	//obs.: pos < n_bits
    	bool res;
    	int linha, coluna, intra_byte;
    	linha = pos/32;
    	coluna = (pos%32)/8;
    	intra_byte = (pos%32)%8;
    	if(memoria[linha][coluna] & 1<<(7-intra_byte))
    		res = true;
    	else
    		res = false;
    	return res;
    }
    
};

class Little_Endian: public Armazenamento{
private:

	void endian(char* salvar, int x){
		for(int i=0; i<4; i++){
			char temp = 0;
			for(int j=0; j<8; j++){
				if( x & 1<<(8*i+j))
					temp = temp | (1<<j);
			}
			salvar[i] = temp;
		}
	}

public:

	void imprimir(){
		cout<<"Little Endian"<<endl;
		for(int i=0; i<memoria.size(); i++){
			cout << setw(5);
			for(int j=3; j>=0; j--){
				if(qual[i] == INTEIRO){
					cout << '|' << setw(5) << converte_byte_int(memoria[i][j]);
				}
				else
					cout << '|' << setw(5) << (memoria[i][j] == 0? '0' : memoria[i][j]);
			}
			cout<< '|' << setw(5) << 4*i << endl;
		}
	}
};

class Big_Endian: public Armazenamento{
private:

	void endian(char* salvar, int x){
		for(int i=3; i>=0; i--){
			char temp = 0;
			for(int j=0; j<8; j++){
				if( x & 1<<(8*i+j))
					temp = temp | (1<<j);
			}
			salvar[3-i] = temp;
		}
	}

public:

	void imprimir(){
		cout<<"Big Endian"<<endl;
		for(int i=0; i<memoria.size(); i++){
			cout << setw(5) << 4*i << setw(5);
			for(int j=0; j<4; j++){
				if(qual[i] == INTEIRO){
					cout << '|' << setw(5) << converte_byte_int(memoria[i][j]);
				}
				else
					cout << '|' << setw(5) << (memoria[i][j] == 0? '0' : memoria[i][j]);
			}
			cout<< '|' << endl;
		}
	}
};

class Hamming{
private:

	bitset<9> total;	/*	Por conveniência, o bit na posição 8 é o bit extra para teste 
							de paridade ímpar e o bit na posição 0 é desconsiderado */
	bool gera_paridade(int paridade){
		int soma = 0;
		if(paridade == 8){
			soma = 1; //bit de paridade ímpar
			for (int i = 1; i < 8; ++i)
				if (total[i]) soma++;
		}
		else
			for(int i = paridade + 1; i< 8; i++){
				if((paridade & i) and total[i])
					soma++;
			}
		return (soma%2);
	}

	void dados_total(bitset<4> dados){
		total[3] = dados[0];
		total[5] = dados[1];
		total[6] = dados[2];
		total[7] = dados[3];
		for(int i = 1; i<=8; i*=2)
			total[i] = gera_paridade(i);
	}

public:

	Hamming(bitset<4> dados){
		dados_total(dados);
	}

	Hamming(string str){
		for(int i=0; i<str.length()/2; i++)
			swap(str[i],str[3-i]);
		bitset<4> dados(str);
		dados_total(dados);
	}

	Hamming(int x){
		int pot2 = 1;
		bitset<4> dados;
		for(int i=0; i<4; i++)
			if(x & 1<<i)
				dados[3-i] = true;
		dados_total(dados);
	}

	Hamming(bitset<9> total){
		this->total = total;
	}

	bitset<4> get_bits_dados(){
		bitset<4> res;
		res[0] = total[3];
		res[1] = total[5];
		res[2] = total[6];
		res[3] = total[7];
		return res;
	}

	bitset<4> get_bits_paridade(){
		bitset<4> res;
		res[0] = total[1];
		res[1] = total[2];
		res[2] = total[4];
		res[3] = total[8];
		return res;
	}

	int corrige_erro(){
		/*
		Retorna: 
			Se houver um bit errado 		-> retorna sua posição
			Se houver dois bits errados		-> retorna -1
			Se não houver erro 				-> retorna 0
		*/
		int res = 0;
		for(int i = 1; i<=7; i*=2)
			if(total[i] != gera_paridade(i))
				res+=i;

		if(total[8] != gera_paridade(8)){
			if(!res)
				res = 8;
		}
		else
			if(res) res = -1;
		if(res > 0) total.flip(res);
		
		return res;
	}

	void recupera_paridade(){
		for(int i = 1; i<=8; i*=2)
			total[i] = gera_paridade(i);
	}

	int inserir_erro(int x){//recebe posição do bit a ser invertido
		total.flip(x);
	}

	friend ostream& operator<<(ostream &os,const Hamming &x);
};

ostream& operator<<(ostream &os,const Hamming &x){
	for(int i=1; i<=8; i++)
			os << x.total[i];
		os << endl;
	return os;
}

class Alfabeto{
private:

	std::vector<Hamming> palavras;

public:

	Alfabeto(){
		for(int i=0; i<16; i++)
			palavras.push_back(Hamming(i));
	}

	void imprimir(){
		for(int i=0; i<16; i++)
			cout << i << "	" << palavras[i];
	}

	void selecionar_palavrar_erro(int palavra, int pos){//1<=pos<=8
		palavras[palavra].inserir_erro(pos);
	}

	bool receptor(int palavra){
		cout << "Recebido: " << palavras[palavra];
		int pos;
		pos = palavras[palavra].corrige_erro();
		if(pos == -1){
			cout << "Há dois bits errados, correcao impossivel" << endl;
		}
		else{
			if(pos){
				cout << "Erro detectado na posicao: " << pos << endl;
				cout << "Palavra corrigida: " << palavras[palavra];
			}
			else
				cout << "Nao houve erro na recepcao" << endl;
		}
		return pos > 0;
	}
};

class Discos{
private:

	Big_Endian fonte;
	std::vector<char*> discos;
	bool paridade_ok;

	void set_dados(Hamming linha_bits, char* linha){
		bitset<4> dados = linha_bits.get_bits_dados();
		for(int i=0; i<4; i++){
			linha[i] = 0;
			if(dados[i])
				linha[i] |= 1;
		}
	}

	void set_paridade(Hamming linha_bits, char* linha){
		bitset<4> pariadade = linha_bits.get_bits_paridade();
		linha[4] = 0;
		for(int i=0; i<4; i++)
			if(pariadade[i])
				linha[4] |= 1<<i;
	}

	void set_linha(Hamming linha_bits, char* linha){
		set_dados(linha_bits, linha);
		set_paridade(linha_bits, linha);
	}

	bool get_bit(int pos, char* linha){// 1<=pos<=8
		if(pos<5){
			if(linha[pos-1] & 1)
				return true;
			else
				return false;
		}
		else{
			if(linha[4] & 1<<(pos-5))
				return true;
			else
				return false;
		}
	}

	bool verifica_pot2(int x){
		bool pot2 = true;
		int count = 0;
		for(int i=0; i<8; i++){
			if(x & 1<<i)
				count++;
			if(count > 1){
				pot2 = false;
				break;
			}
		}
		return pot2;
	}

	Hamming converte_linha_Hamming(char* linha){
		bitset<9> total;
		int paridade = 5;
		int dado = 1;
		for(int i=1; i<9; i++){
			if(verifica_pot2(i))
				total[i] = get_bit(paridade++, linha);
			else
				total[i] = get_bit(dado++, linha);
		}
		/*
		Equivalente a:
		total[1] = get_bit(5, linha);
		total[2] = get_bit(6, linha);
		total[3] = get_bit(1, linha);
		total[4] = get_bit(7, linha);
		total[5] = get_bit(2, linha);
		total[6] = get_bit(3, linha);
		total[7] = get_bit(4, linha);
		total[8] = get_bit(8, linha);
		*/
		return Hamming(total);
	}

public:

	Discos(){
		paridade_ok = true;
		fonte.set_memoria();
		for(int i=0; i<fonte.get_n_bits(); i+=4){
			string temp="";
			for(int j=0; j<4; j++){
				if(fonte.get_bit(i+j))
					temp += "1";
				else
					temp += "0";
			}
			Hamming linha_bits(temp);
			char* linha = new char[5];
			set_linha(linha_bits, linha);
			discos.push_back(linha);
		}
	}

	~Discos(){
		for(int i=0; i<discos.size(); i++)
			delete[] discos[i];
	}

	void destruir_disco(int qual){	// 0<=qual<=4
		for(int i=0; i<discos.size(); i++)
			discos[i][qual] = 0;
		if(qual == 4)
			paridade_ok = false;
	}

	void recupera_disco(){
		for(int i=0; i<discos.size(); i++){
			Hamming temp = converte_linha_Hamming(discos[i]);
			if(paridade_ok)
				temp.corrige_erro();
			else
				temp.recupera_paridade();
			set_linha(temp, discos[i]);
		}
		paridade_ok = true;
	}

	void imprimir(){
		cout << setw(16) << "Discos de dados" << setw(26) << "Disco de paridade\n";
		for(int i=0; i<discos.size(); i++){
			for(int j=1; j<5; j++){
				cout << "|" << setw(5) << get_bit(j, discos[i]);
			}
			cout << "|" << setw(5);
			for (int j = 5; j < 9; j++)
			{
				cout << get_bit(j, discos[i]);
			}
			cout << "|" << endl;
		}
	}
};

class Menu{
private:

	char questao;

	formato escolher_endian(){
		char endian_selecao = 'X';
		while((endian_selecao != 'L') and (endian_selecao != 'B')){
			cout << "Insira 'L' para Little Endian ou 'B' para Big Endian: ";
			cin >> endian_selecao;
			cin.ignore(10000, '\n');
			if((endian_selecao != 'L') and (endian_selecao != 'B'))
				cout << "Escolha invalida, tente novamente." << endl;
		}
		formato res = endian_selecao == 'L'? LITTLE : BIG;
		return res;
	}

	void questao_a(){
		formato endian_selecao = escolher_endian();
		if(endian_selecao == LITTLE){
			Little_Endian obj;
			q_a_parcial(&obj, endian_selecao);
		}
		else{
			Big_Endian obj;
			q_a_parcial(&obj, endian_selecao);
		}
	}

	void q_a_parcial(Armazenamento* obj, formato endian_selecao){
		obj->set_memoria();
		cout << "\nRegistro na maquina:" << endl;
		obj->imprimir();
		cout << "\nEscolha um formato de leitura" << endl;
		endian_selecao = escolher_endian();
		cout << endl;
		obj->leitura(endian_selecao);
	}

	void questao_b(){
		Alfabeto obj;
		int palavra_erro;
		cout << "Alfabeto:\n";
		obj.imprimir();
		cout << "\nInsira um numero correspondente a uma das palavras do alfabeto:\n";
		cin >> palavra_erro;
		char usuario_erro = 'S';
		while(usuario_erro == 'S'){
			cout << "\nDeseja inserir erro na palavra selecionada?" <<endl;
			cout << "Pressione S para inserir erro ou outro caractere para continuar: ";
			cin >> usuario_erro;
			if(usuario_erro == 'S'){
				int bit_erro;
				cout << "Insira um numero de 1 a 8 que correspondente a um bit a ser invertido: ";
				cin >> bit_erro;
				obj.selecionar_palavrar_erro(palavra_erro, bit_erro);
			}
		}
		cout << "\nA palavra selecionada foi enviada para um receptor.\n";
		obj.receptor(palavra_erro);
	}

	void questao_c(){
		Discos obj;
		int disco_destruido;
		cout << "Representacao dos dados nos discos\n";
		obj.imprimir();
		cout << "\nInsira um valor de 0 a 4 correspondente a um disco a ser destruido: ";
		cin >> disco_destruido;
		obj.destruir_disco(disco_destruido);
		cout << "\n Discos apos a destruicao do disco " << disco_destruido << endl;
		obj.imprimir();
		cout << "\n Discos apos a recuperacao do disco " << disco_destruido << endl;
		obj.recupera_disco();
		obj.imprimir();
	}

public:

	Menu(){
		questao = 'a';
	}

	void executar(){
		while((questao == 'a') or (questao == 'b') or (questao == 'c')){
			cout << "a. Simulacao Big Endian ou Little Endian\n";
			cout << "b. Simulacao alfabeto para correcao de erro\n";
			cout << "c. Simulacao RAID 3 com recuperacao de disco\n";
			cout << "\nInsira um caractere correspondente a uma questao ou outro para encerrar: ";
			cin >> questao;
			cin.ignore(10000, '\n');
			cout << endl;
			switch(questao){
				case 'a':
					questao_a();
					break;
				case 'b':
					questao_b();
					break;
				case 'c':
					questao_c();
					break;
			}
			cout << "\n\n";
		}
	}

};

main(){
	Menu principal;
	principal.executar();
}