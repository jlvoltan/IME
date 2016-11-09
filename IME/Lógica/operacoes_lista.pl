%Operações para listas em Prolog

%Verifica se um dado elemento está contido na lista --> membro(elemento,lista)
membro(X,[X|_]):-!.
membro(X,[_|Y]):-
    membro(X,Y).

%Concatenação       -->  concatenar(lista1, lista2, lista1+lista2)
concatenar([],L,L).
concatenar([H|T],L2,[H|L3]) :- 
    concatenar(T,L2,L3).

%Interseção         --> intersecao(lista1, lista2, resposta) 
intersecao([] ,_, []).

intersecao([A1 | A_tail] , B, [A1 | Res_tail]):-
	membro(A1,B),
    remover(A1, B, B_menos_A1),
    intersecao(A_tail,B_menos_A1,Res_tail).

intersecao([A1 | A_tail], B, Res):-
    not(membro(A1,B)),
    intersecao(A_tail,B,Res).

%Remoção de um elemento     --> remover(elemento , lista antes da remoção, lista após a remoção)   obs.: apenas a primeira aparição é removida
remover(A1 , [A1 | A_tail] , A_tail ).

remover(_, [], []).

remover(X, [A1 | A_tail], [A1 | R] ):-
    not(X=A1),
    remover(X, A_tail,R).

%Maior elemento da lista  --> max(lista,maximo)
accMax([H|T],A,Max) :-              %   accMax(lista, "valor minimo base, ex: 0", maximo)
   H > A,
   accMax(T,H,Max).

accMax([H|T],A,Max) :-
   H =< A,
   accMax(T,A,Max).

accMax([],A,A).

max([P1|Tail],Max):-
    accMax(Tail,P1,Max).

%Menor elemento da lista  --> min(lista,minimo)
accMin([H|T],A,Min) :-              %   accMin(lista, "valor maximo base, ex: 99999", minimo)
    H >= A,
    accMin(T,A,Min).

accMin([H|T],A,Min) :-
    H < A,
    accMin(T,H,Min).

accMin([],Min,Min).

min(Lista,Min):-
    Lista = [P1|_],
    accMin(Lista,P1,Min).

%Ordenação          --> ordenar(lista_antes, lista_depois)
ordenar([],[]).

ordenar(A, [R1 | R_tail]):-
    min(A, R1),
    remover(R1,A,A_new),
    ordenar(A_new, R_tail).

%Multiplicação por um escalar   --> scalarMult(escalar , lista , resposta)
scalarMult(_,[],[]).

scalarMult(X,[A|B],Z):-
    Y is X*A,
	Z = [Y|Tail],
    scalarMult(X,B,Tail).

%Produto escalar        --> dot(lista1, lista2, resposta)      obs.: lista1 e lista2 devem ter o mesmo tamanho
accDot([],[],Res,Res).

accDot([A1 | A_tail], [B1 | B_tail], Acc, Res):-
    Acc_new is Acc+A1*B1,
    accDot( A_tail, B_tail, Acc_new, Res).

dot(A,B,Res):-
    accDot(A,B,0,Res).

%Inversão da lista  --> rev( lista_original , lista_invertida) 
accRev([H|T],A,R):-
    accRev(T,[H|A],R).

accRev([],A,A).

rev(L,R):- accRev(L,[],R).
