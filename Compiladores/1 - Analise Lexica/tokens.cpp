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


class Tokenizer{
public:
    vector<string> keywords{
        "array", "boolean", "break", "char", "continue", "do", "else", "false", "function",
        "if", "integer", "of", "string", "struct", "true", "type", "var", "while"};
    unordered_map<string, int> identifers_hash;

    t_token searchKeyWord(char * name){
        string str_name = string(name);
        int token_num = lower_bound(keywords.begin(), keywords.end(), str_name) - keywords.begin();
        if(token_num < keywords.size())
            return t_token(token_num);
        else
            return t_token::ID;
    }

    int searchName(char *name){
        string str_name = string(name);
        if(identifers_hash.find(str_name) == identifers_hash.end())
            identifers_hash[str_name] = identifers_hash.size();
        return identifers_hash[str_name];
    }
};