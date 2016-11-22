/*

5. Considere 8 letras diferentes . Faça um programa que compare duas listas formadas por 4 letras distintas, e resposta quantos elementos da lista são iguais na posição correta e quantos são iguais mas em uma posição errada.

Ex: p([a,b,c,d],[b,e,a,d],X,Y) devera retornar X=1 e Y = 2.

 */

p(L1, L2, X, Y):-
    pAcc(L1, L2, L2, 0, X, 0, Y),!.

pAcc([], [], _, X, X, Y, Y).

pAcc( [L1s_Head | L1s_Tail ], [ L2s_Head | L2s_Tail ], L2, XAcc, X, YAcc, Y):-
    L1s_Head == L2s_Head,
    XAcc_new is XAcc+1,
    pAcc( L1s_Tail, L2s_Tail, L2, XAcc_new, X, YAcc, Y).

pAcc( [L1s_Head | L1s_Tail ], [ L2s_Head | L2s_Tail ], L2, XAcc, X, YAcc, Y):-
    L1s_Head \== L2s_Head,
    member( L1s_Head, L2),
    YAcc_new is YAcc+1,
    pAcc( L1s_Tail, L2s_Tail, L2, XAcc, X, YAcc_new, Y).


pAcc( [L1s_Head | L1s_Tail ], [ L2s_Head | L2s_Tail ], L2, XAcc, X, YAcc, Y):-
    L1s_Head \== L2s_Head,
    not( member( L1s_Head, L2) ),
    pAcc( L1s_Tail, L2s_Tail, L2, XAcc, X, YAcc, Y).
