/*
 
Escreva em Prolog um programa definindo o predicado diff (L1, L2, L) que dadas duas listas L1 e L2, nos retorna L1 - L2. Defina todos os predicados que utilizar.

Exemplo: diff([2,7,2,11], [3,4,5,2,8,7], L) nos dará a resposta L=[11].

*/

diff(L1, L2, L):-
    diffAcc(L1, L2, [], L),!.

diffAcc([],_,Res,Res).

diffAcc([Head|Tail], L2, Acc, Res):-
    not( member(Head, L2) ),
    Acc_new = [ Head | Acc ],
    diffAcc(Tail, L2, Acc_new, Res).

diffAcc([Head|Tail], L2, Acc, Res):-
    member(Head, L2),
    diffAcc(Tail, L2, Acc, Res).
