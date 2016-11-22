function MPF_sistemas_nlineares
    TOL=input('Insira tolerancia de erro: ');
    NMI=input('Insira o numero maximo de iteracoes: ');
    X=input('Insira o vetor [a;b;...;c] de valores iniciais: ');
    N=length(X);
    K=0;
    ZM=1;
    F=zeros([N,1]);
    while (K<=NMI)&& abs(ZM)>TOL
        Xtemp=X;
        for i=1:N
            Xtemp(i)=FUNCOES(i,X);
        end
        ZM=abs(Xtemp(1)-X(1));
        for i=2:N
            if abs(Xtemp(i)-X(i))>ZM
                ZM=abs(Xtemp(i)-X(i));
            end
        end
        K=K+1;
        X=Xtemp;
    end
    fprintf('Solucao [x1,x2,x3,...,xn]: \n');
    disp(X);
end
        