#include<bits/stdc++.h>
#include "raw_code.cpp"
#include "tokens.cpp"
#include "constants.cpp"

using namespace std;

const int MAX_ID_LEN = 30;
const int MAX_NUM_LEN = 30;
const int MAX_STR_LEN = 100;

t_token nextToken(RawCode & code, Tokenizer & tokens, Constants & constants){
    t_token token = UNKNOWN;
    int tokenSecundario;

    // loop do estado inicial para pular os separadores
    while(code.isspace()){
        code.readChar();
    }
    if(code.isalpha()){
        char text[MAX_ID_LEN+1];
        int i = 0;
        do{
            text[i++] = code.nextChar;
            code.readChar();
        }while(code.isalnum() || code.nextChar == '_' );

        text[i] = '\0';
        token = tokens.searchKeyWord(text);
        if(token == ID){
            tokenSecundario = tokens.searchName(text);
        }
    }
    else
        if(code.isdigit()){
            char numeral[MAX_NUM_LEN+1];
            int i = 0;

            do{
                numeral[i++] = code.nextChar;
                code.readChar();
            }while(code.isdigit());

            numeral[i] = '\0';
            token = NUMERAL;
            tokenSecundario = constants.addIntConst(numeral);   // TODO
        }
        else
            if(code.nextChar == '"'){
                char str[MAX_STR_LEN+1];
                int i = 1;

                do{
                    str[i++] = code.nextChar;
                    code.readChar();
                }while(code.nextChar != '”' );

                str[i++] = '"';
                str[i] = '\0';
                token = STRING;
                tokenSecundario = constants.addStringConst(str);
            }
            else
                switch(code.nextChar){
                    case '\'':
                        code.readChar();
                        token = CHARACTER;
                        tokenSecundario = constants.addCharConst(code.nextChar);
                        code.readChar(); // pular o '
                        code.readChar();
                        break;
                    case ':':
                        code.readChar();
                        token = COLON;
                        break;
                    case '+':
                        code.readChar();
                        if(code.nextChar == '+'){
                            token = PLUS_PLUS;
                            code.readChar();
                        }
                        else{
                            token = PLUS;
                        }
                        break;
                    ... // TODO
                    default:
                        token = UNKNOWN;
                }
    return token;
}

main(){
    RawCode code("example_code");
    Tokenizer tokens;
    Constants constants;
}