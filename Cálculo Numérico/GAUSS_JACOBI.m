function GAUSS_JACOBI
    TOL=input('Insira tolerancia de erro: ');
    NMI=input('Insira o numero maximo de iteracoes: ');
    A=input('Insira a matriz dos coeficientes: ');
    b=input('Insira o vetor "b" de AX=b: ');
    X=input('Insira o vetor [a;b;...;c] de valores iniciais: ');
    n=length(X);
    C=zeros(n,n);
    g=zeros(n,1);
    for i=1:n
        g(i)=b(i)/A(i,i);
        for j=1:n
            if i~=j
                C(i,j)=-A(i,j)/A(i,i);
            end
        end
    end
    i=0;
    max=100;
    while abs(max)>TOL && i<NMI
        Xtemp=C*X+g;
        max=0;
        for j=1:n
            if abs(Xtemp(j)-X(j))>abs(max)
                max=Xtemp(j)-X(j);
            end
        end
        X=Xtemp
        i=i+1;
    end
    if i>NMI
        disp('Numero de iteracoes maximo excedido');
    end
    disp(X)
end        