%Obs.: É importante que o valor de TOL seja pequeno o suficiente para o
%cálculo da derivação numérica.
function SEQNL_NEWTON_MODIFICADO
    TOL=input('Insira tolerancia de erro: ');
    NMI=input('Insira o numero maximo de iteracoes: ');
    X=input('Insira o vetor [a;b;...;c] de valores iniciais: ');
    N=length(X);
    K=0;
    ZM=1;
    F=zeros([N,1]);
    A=zeros([N,N]);
    for i=1:N
        for j=1:N
            X(j)=X(j)+TOL;
            A(i,j)=FUNCOES(i,X);
            X(j)=X(j)-2*TOL;
            A(i,j)=(A(i,j)-FUNCOES(i,X))/(2*TOL);
            X(j)=X(j)+TOL;
        end
    end
    while (K<=NMI)&& abs(ZM)>TOL
        for i=1:N
            F(i)=-FUNCOES(i,X);
        end
        Z=A\F;   %Z=inv(A)*F
        ZM=Z(1);
        X(1)=X(1)+Z(1);
        for i=2:N
            if abs(ZM)<=abs(Z(i))
                ZM=Z(i);
            end
            X(i)=X(i)+Z(i);
        end
        K=K+1;
        fprintf('iteração:%d      ERRO=%f\n',K,ZM);disp(X);
    end
    if K>NMI
        disp('Ultrapassou o numero maximo de iteracoes');
    else
        disp(X);
    end
end