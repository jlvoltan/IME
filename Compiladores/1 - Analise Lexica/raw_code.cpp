#include<bits/stdc++.h>

using namespace std;

class RawCode{
public:
    ifstream code_file;
    char nextChar = '\x20';

    RawCode(string file_name){
        code_file.open(file_name, std::ifstream::in);
    }

    char readChar(){
        if(code_file >> std::noskipws >> nextChar)
            return nextChar;
        else
            return EOF;
    }

    bool isspace(){
        return nextChar == ' ';
    }

    bool isalpha(){
        return (nextChar >= 'a' and nextChar <= 'z')
            or (nextChar >= 'A' and nextChar <= 'Z');
    }

    bool isdigit(){
        return (nextChar >= '0' and nextChar <= '9');
    }

    bool isalnum(){
        return isdigit() or isalpha();
    }
};