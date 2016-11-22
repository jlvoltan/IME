/*

2. Escreva em Prolog um programa definindo o predicado prog (X, L, L1,L2) que divide uma lista numérica L em duas sublistas L1 e L2, onde em L1 encontramos os elementos de L menores que X e em L2 os elementos de L maiores ou iguais a X. Nessas sublistas L1 e L2 os elementos não estão repetidos. Em L pode haver repetição de elementos. Defina todos os predicados que utilizar.

*/

prog(X, L, L1, L2):-
    progAcc(X, L, [], L1, [], L2),!.

progAcc(_, [], L1, L1, L2, L2):-!.

progAcc(X, [Head|Tail], L1Acc, L1, L2Acc, L2):-
    Head<X,
    not( member( Head, L1Acc ) ),
    !,
    L1Acc_new = [Head | L1Acc],
    progAcc(X, Tail, L1Acc_new, L1, L2Acc, L2).

progAcc(X, [Head|Tail], L1Acc, L1, L2Acc, L2):-
    Head<X,
    member(Head, L1Acc),
    !,
    progAcc(X, Tail, L1Acc, L1, L2Acc, L2).

progAcc(X, [Head | Tail], L1Acc, L1, L2Acc, L2):-
    Head >= X,
    not( member( Head, L2Acc) ),
    !,
    L2Acc_new = [Head | L2Acc],
    progAcc(X, Tail, L1Acc, L1, L2Acc_new, L2).

progAcc(X, [Head | Tail], L1Acc, L1, L2Acc, L2):-
    Head >= X,
    member( Head, L2Acc),
    !,
    progAcc(X, Tail, L1Acc, L1, L2Acc, L2).
