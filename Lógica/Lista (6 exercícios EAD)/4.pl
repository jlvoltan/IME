/*

4. Escreva em Prolog um programa definindo o predicado prog (L1, L2, L) que dadas duas listas L1 e L2 com repetição, nos retorna a interseção sem repetição L dessas listas. Defina todos os predicados que utilizar.

Exemplo: prog([2,7,2,11], [3,4,5,2,8,2,7], L) nos dará a resposta L=[2,7] ou qualquer permutação dessa lista.

*/

remover(X, L, Res):-
    removerAcc(X, L, [], Res),!.

removerAcc(_, [], Res, Res).

removerAcc(X, [Head | Tail], Acc, Res):-
    Head == X,
    removerAcc(X, Tail, Acc, Res).

removerAcc(X, [Head | Tail], Acc, Res):-
    Head \== X,
    Acc_new = [Head | Acc],
    removerAcc(X, Tail, Acc_new, Res).

prog(L1, L2, L):-
    progAcc(L1, L2, [], L),!.

progAcc([], _, Res, Res).

progAcc([Head | Tail], L2, Acc, Res):-
    member(Head, L2),
    remover(Head, L2, L2_new),
    Acc_new = [Head | Acc],
    progAcc(Tail, L2_new, Acc_new, Res).

progAcc([Head | Tail], L2, Acc, Res):-
    not( member(Head, L2) ),
    progAcc(Tail, L2, Acc, Res).
