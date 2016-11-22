function AJUSTE_POLINOMIAL
    m=input('Insira o grau do polinomio: ');
    n=input('Insira o numero de pontos: ');
    X=input('Insira um vetor com as coordenadas "x" dos pontos: ');
    Y=input('Insira um vetor com as coordenadas "y" dos pontos: ');
    A=zeros([m+1,m+1]);
    b=zeros([m+1,1]);
    for k=1:m+1
        for i=1:m+1
            for j=1:n
                A(k,i)=A(k,i)+(X(j))^((i-1)+(k-1));
            end
        end
        for j=1:n
            b(k)=b(k)+Y(j)*(X(j))^(k-1);
        end
    end
    disp(A);disp(b);
    c=A\b; %c=inv(A)*b
    disp('Os coeficientes do polinomio partindo do termo de menor grau para o termo de maior grau sao: ');
    disp(c);
    %CALCULO DO COEFICIENTE DE DETERMINACAO
    numerador=0;
    denominador=0;
    Ymedio=0;
    for j=1:n
        Ymedio=Ymedio+Y(j);
    end
    Ymedio=Ymedio/n;
    for j=1:n
        temp=B_R_H(c,X(j));
        numerador=numerador+(Y(j)-temp(1))^2;
        denominador=denominador+(Y(j)-Ymedio)^2;
    end
    R2=1-numerador/denominador;
    disp('O coeficiente de determinacao eh: ');
    disp(R2);
end