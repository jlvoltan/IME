% 1. Soma lista                soma_lista([1,2,3,4],K).              K = [1,3,6,10];false


soma_lista([Head|Tail], Res):-
	soma_listaAcc(Tail, [Head], K),
	rev(K, Res).

soma_listaAcc([], Res, Res).
soma_listaAcc([Head|Tail], [AccHead | AccTail], K):-
	X is Head + AccHead,
	Acc_new = [X, AccHead | AccTail],
	soma_listaAcc(Tail, Acc_new, K).

%Inversão da lista  --> rev( lista_original , lista_invertida) 
accRev([H|T],A,R):-
    accRev(T,[H|A],R).
accRev([],A,A).
rev(L,R):- accRev(L,[],R).


% 2. Escreva em Prolog um programa definindo o predicado potencia (X,Y, Z) verdadeiro se somente se X^Y=Z.  Defina todos os predicados que utilizar.
% Exemplo: potencia(2,3,Z) nos dará a resposta Z=8.


potencia(_,0,1):-!.
potencia(X,Y,Z):-
	Y_anterior is Y-1,
	potencia(X,Y_anterior,Z_anterior),
	 Z is Z_anterior*X,!.


% 3. Considere 8 letras diferentes . Faça um programa que compare duas listas formadas por 4 letras com repetição nas listas, e resposta quantos elementos da lista são iguais na posição correta e quantos são iguais mas em uma posição errada.
% Ex: p([a,b,c,d],[b,e,a,d],X,Y) devera retornar X=1 e Y = 2.


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

%Obs.: Há um erro para o caso p([a,b,a,b],[a,c,b,b],X,Y)
%Resultado esperado: X = 2 e Y = 1  ;  Resultado calculado: X = Y, Y = 2

% 4. Defina em Prolog a relação sublista que possui como argumentos uma lista S e uma lista L tais que S ocorre em L como sublista. Assim, é verdadeira a afirmação:
% sublista([c, d, e], [a, b, c, d, e, f]) mas é falso declarar que  sublista([c, e], [a,b,c,d,e,f]).


%Concatenação       -->  concatenar(lista1, lista2, lista1+lista2)
concatenar([],L,L).
concatenar([H|T],L2,[H|L3]) :-
    concatenar(T,L2,L3).

%Sublistas          --> sublista( resposta, lista)
prefixo(P,L):-
    concatenar(P,_,L). 
sufixo(S,L):- 
    concatenar(_,S,L).
sublista(SubL,L):- sufixo(S,L), prefixo(SubL,S).


% 5. Escreva em prolog um programa que de todas as permutações de uma lista sem repetições:
% perm([1, 4, 7], X).
% X = [1, 4, 7]; X = [1, 7, 4]; X = [4, 1, 7]; X = [4, 7, 1]; X = [7, 1, 4]; X = [7, 4, 1]; false.


%Verifica se um dado elemento está contido na lista --> membro(elemento,lista)
membro(X,[X|_]).
membro(X,[_|Y]):-
    membro(X,Y).

%Remoção de um elemento     --> remover(elemento , lista antes da remoção, lista após a remoção)   obs.: apenas a primeira aparição é removida
remover(A1 , [A1 | A_tail] , A_tail ).
remover(_, [], []).
remover(X, [A1 | A_tail], [A1 | R] ):-
    not(X=A1),
    remover(X, A_tail,R).

perm([],[]).
perm(L, [Head|Tail]):-
	membro(Head,L),
	remover(Head, L, L_new),
	perm(L_new, Tail).