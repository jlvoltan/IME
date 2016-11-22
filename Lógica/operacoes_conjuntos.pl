%União                  --> Res = A uniao B         --> uniao(A,B,Res)
uniao([], A, A).
uniao(A, [], A).

uniao([A1|A_tail], B, [A1|R_tail]):-
    remover(A1,B,B_new),
    uniao(A_tail, B_new, R_tail).

%Interseção             --> Res = A intersecao B    --> intersecao(A,B,Res)
intersecao([],_,[]).

intersecao([A1|A_tail], B, [A1|R_tail]):-
    member(A1,B),
    intersecao(A_tail, B, R_tail).

intersecao([A1|A_tail], B, R):-
    not(member(A1,B)),
    intersecao(A_tail, B, R).

%Diferença              --> Res = A-B               --> diferenca(A,B,Res)
diferenca(A,[],A).

diferenca(A, [B1|B_tail], Res):-
    remover(B1, A, A_new),
    diferenca(A_new, B_tail, Res).

%Complemento            --> Res = Complemento de A em B  --> complemento(A,B,Res).
complemento(A,B,Res):-
    intersecao(A,B,Inter),
    diferenca(B,Inter,Res).

%Produto cartesiano     --> Res = AxB           --> p_cartesiano(A,B,Res)
p_cartesiano_1xn([_],[],A,A).

p_cartesiano_1xn([A], [B1|B_tail], Acc, Res):-
    Acc_new = [[A,B1]|Acc],
    p_cartesiano_1xn([A], B_tail, Acc_new, Res).

p_cartesiano_1xn([A], B, Res):-
    p_cartesiano_1xn([A], B, [], Res).

p_cartesiano([], _, A, A).

p_cartesiano([A1|A_tail], B, Acc, Res):-
    p_cartesiano_1xn([A1], B, Acc1),
    append(Acc,Acc1, Acc_new),
    p_cartesiano(A_tail, B, Acc_new, Res).

p_cartesiano(A,B,Res):-
    p_cartesiano(A, B, [], Res).





%EXTRA
%Remoção de um elemento             %remover(elemento , lista antes da remoção, lista após a remoção)
remover(A1 , [A1 | A_tail] , A_tail ).

remover(_, [], []).

remover(X, [A1 | A_tail], [A1 | R] ):-
    not(X=A1),
    remover(X, A_tail,R).
