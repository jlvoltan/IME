/*

3 Escreva em Prolog um programa definindo o predicado prog (L1, L2, L) que dadas duas listas L1 e L2 com repetição, nos retorna a interseção com repetição L dessas listas. Defina todos os predicados que utilizar.

*/

prog(L1, L2, L):-
    progAcc(L1, L2, [], L),!.

progAcc([], _, Res, Res):-!.

progAcc([Head | Tail], L2, Acc, Res):-
    member(Head, L2),
    !,
    Acc_new = [Head | Acc],
    progAcc(Tail, L2, Acc_new, Res).

progAcc([Head | Tail], L2, Acc, Res):-
    not( member(Head, L2) ),
    progAcc(Tail, L2, Acc, Res).
