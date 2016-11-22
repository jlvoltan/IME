function INTERPOLACAO_LAGRANGE
    syms P L x numerador denominador X Y;
    n=input('Insira o numero de pontos: ');
    X=input('Insira um vetor com as coordenadas "x" dos pontos: ');
    Y=input('Insira um vetor com as coordenadas "y" dos pontos: ');
    P=0;
    for i=1:n
        L(i)=1;
    end
    for j=1:n
        numerador=1;
        denominador=1;
        for i=1:n
            if i~=j
                numerador=numerador*(x-X(i));
                denominador=denominador*(X(j)-X(i));
            end
        end
        L(j)=numerador/denominador;
        P=P+Y(j)*L(j);
    end
    disp(P);
    disp('ou');
    disp(expand(P));
end