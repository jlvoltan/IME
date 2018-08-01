#include<bits/stdc++.h>

using namespace std;

struct t_const{
    char type; // 0-char, 1-int, 2- string
    union{
        char cVal;
        int nVal;
        char * sVal;
    } _;

    t_const(char cVal){
        this->_.cVal = cVal;
        this->type = 0;
    }
    t_const(int nVal){
        this->_.nVal = nVal;
        this->type = 1;
    }
    t_const(char * sVal){
        this->_.sVal = new char[strlen(sVal)+1];
        strcpy(this->_.sVal, sVal);
        this->type = 2;
    }
};

class Constants{
public:
    vector<t_const> vConsts; // nNumConsts == vConsts.size()

    int addCharConst(char c){
        t_const new_const(c);
        vConsts.push_back(new_const);
    }
    int addIntConst(int n){
        t_const new_const(n);
        vConsts.push_back(new_const);
    }
    int addStringConst(char * s){
        t_const new_const(s);
        vConsts.push_back(new_const);
    }
    char getCharConst(int n){
        return vConsts[n]._.cVal;
    }
    int getIntConst(int n){
        return vConsts[n]._.nVal;
    }
    char * getStringConst(int n){
        return vConsts[n]._.sVal;
    }
};