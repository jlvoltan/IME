#include<bits/stdc++.h>

using namespace std;

typedef enum {
    // palavras reservadas
    ARRAY, BOOLEAN, BREAK, CHAR, CONTINUE, DO, ELSE, FALSE, FUNCTION, IF,
    INTEGER, OF, STRING, STRUCT, TRUE, TYPE, VAR, WHILE,
    // simbolos
    COLON, SEMI_COLON, COMMA, EQUALS, LEFT_SQUARE, RIGHT_SQUARE,
    LEFT_BRACES, RIGHT_BRACES, LEFT_PARENTHESIS, RIGHT_PARENTHESIS, AND,
    OR, LESS_THAN, GREATER_THAN, LESS_OR_EQUAL, GREATER_OR_EQUAL,
    NOT_EQUAL, EQUAL_EQUAL, PLUS, PLUS_PLUS, MINUS, MINUS_MINUS, TIMES,
    DIVIDE, DOT, NOT,
    // tokens regulares
    CHARACTER, NUMERAL, STRINGVAL, ID,
    // token deconhecido
    UNKNOWN
} t_token;

t_token searchKeyWord(char *name );
/*
Cada palavra reservada e cada símbolo válido da linguagem deverão ter um token associado.
Para saber que uma palavra lida é uma palavra reservada e não um identificador criado pelo
programador é necessário fazer uma busca em uma tabela de palavras reservadas.
Considerando que o conjunto de palavras reservadas de uma linguagem é fixo, esta tabela
pode ser implementada por meio de um vetor de palavras, ordenado alfabeticamente, onde é
feita uma busca binária para procurar uma palavra lida. Se a palavra lida for encontrada no
vetor, sua posição corresponderá ao valor do seu token. Caso não seja encontrada o token
correspondente aos identificadores deverá ser retornado. Para buscar as palavras reservadas
na tabela de palavras reservadas, o Analisador Léxico deve usar uma função como
*/

int searchName(char *name);
/*
Ao receber o token ID da função searchKeyWord() e concluir que uma palavra não é
reservada, o Analisador Léxico deve determinar o seu token secundário. Para tal, uma tabela
de identificadores deve ser criada para associar a cada identificador o seu token secundário. O
token secundário dos identificadores, chamado de nome, pode ser apenas um número inteiro
representando a ordem em que foi lido do arquivo de entrada. Assim, o primeiro identificador
tem o nome igual 0, o segundo igual a 1 e assim sucessivamente. É importante observar que
cada identificador deve ocorrer apenas uma vez nesta tabela e estar associado ao token que
lhe foi atribuído em sua primeira ocorrência. Uma algoritmo de Hash é a implementação mais
recomendada para esta tabela, pois tem tempo de busca e inserção quase constante. Para
inserir e buscar identificadores na tabela de nomes, o Analisador Léxico deve usar uma função
como
*/

t_token nextToken(void){
    // loop do estado inicial para pular os separadores
    while(isspace(nextChar)){
        nextChar = readChar();
    }
    if(isalpha(nextChar)){
        char text[MAX_ID_LEN+1];
        int i = 0;

        do{
            text[i++] = nextchar;
            nextChar = readChar();
        }while( isalnum(nextChar) || nextChar == ‘_’ );

        text[i] = ‘\0’;
        token = searchKeyWord( text );
        if( token == ID ){
            tokenSecundario = searchName( text );
        }
    }
    else
        if( isdigit(nextChar) ){
            char numeral[MAX_NUM_LEN+1];
            int i = 0;

            do{
                numeral [i++] = nextchar;
                nextChar = readChar();
            }while( isdigit(nextChar) );

            numeral [i] = ‘\0’;
            token = NUMERAL;
            tokenSecundario = addIntConst(numeral);
        }
        else
            if( nextChar == ‘”’ ){
                char string[MAX_STR_LEN+1];
                int i = 1;

                do{
                    string [i++] = nextchar;
                    nextChar = readChar();
                }while( nextChar != ‘”’ );

                numeral [i++] = ‘”’;
                numeral [i] = ‘\0’;
                token = STRING;
                tokenSecundario = addStringConst(numeral);
            }
            else
                switch(ch){
                    case ‘\’’:
                        nextChar = readChar();
                        token = CHARACTER;
                        tokenSecundario = addCharConst(nectChar);
                        nextChar = readChar(); // pular o ‘
                        nextChar = readChar();
                        break;
                    case ‘:’:
                        nextChar = readChar();
                        token = COLON;
                        break;
                    case ‘+’:
                        nextChar = readChar();
                        if( nextChar == ‘+’ ){
                            token = PLUS_PLUS;
                            nextChar = readChar();
                        }
                        else{
                            token = PLUS;
                        }
                        break;
                    ...
                    default:
                        token = UNKNOWN;
                }
    return token;
}

main(){

}