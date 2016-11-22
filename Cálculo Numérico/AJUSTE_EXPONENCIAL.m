function AJUSTE_EXPONENCIAL
    m=input('Insira o numero de exponenciais: '); %fm(x)=exp(m*x)
    n=input('Insira o numero de pontos: ');
    X=input('Insira um vetor com as coordenadas "x" dos pontos: ');
    Y=input('Insira um vetor com as coordenadas "y" dos pontos: ');
    A=zeros([m,m]);
    b=zeros([m,1]);
    for k=1:m
        for i=1:m
            for j=1:n
                A(k,i)=A(k,i)+exp(X(j)*(i+k));
            end
        end
        for j=1:n
            b(k)=b(k)+Y(j)*exp(k*(X(j)));
        end
    end
    c=A\b; %c=inv(A)*b
    disp('Os coeficientes dos fatores exponenciais partindo do termo de menor expoente para o termo de maior expoente sao: ');
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
        temp=0;
        for i=1:m
            temp=temp+c(i)*exp(X(j)*i);
        end
        numerador=numerador+(Y(j)-temp)^2;
        denominador=denominador+(Y(j)-Ymedio)^2;
    end
    R2=1-numerador/denominador;
    disp('O coeficiente de determinacao é: ');
    disp(R2);
end