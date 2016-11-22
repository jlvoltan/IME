function integral_dupla
    %Inserir função em f(x,y):
    %Integral de f(x,y)dydx
    f=@(x,y)sqrt(x*y+y^2);
    %Borda inferior Bi(x)
    Bi=@(x)(2+x)/3;
    %Borda superior Bs(x)
    Bs=@(x)6-x;
    n=input('Insira o número de subintervalos no eixo x: ');
    m=input('Insira o número de subintervalos no eixo y: ');
    X(1)=input('Insira o valor mínimo de x em toda a região a ser integrada: ');
    X(n+1)=input('Insira o valor máximo de x em toda a região a ser integrada: ');
    for i=2:n
        X(i)=X(1)+(i-1)*(X(n+1)-X(1))/n;
    end
    Ix=zeros(1,n+1);
    for k=1:n+1
        %a -> início do intervalo
        a=Bi(X(k));
        %b -> fim do intervalo
        b=Bs(X(k));
        h=(b-a)/m; %comprimento de cada subintervalo
        %Z ->vetor com as coordenadas "z" dos pontos
        %Y ->vetor com as coordenadas "y" dos pontos
        Z=zeros(1,m+1);
        Y=zeros(1,m+1);
        for i=1:m+1
            Y(i)=a+((b-a)/(m))*(i-1);
            Z(i)=f(X(k),Y(i));
        end
        Ix(k)=(Z(1)+Z(m+1));
        for i=2:m
            if rem(i,2)==0
                Ix(k)=Ix(k)+4*Z(i);
            else
                Ix(k)=Ix(k)+2*Z(i);
            end
        end
        Ix(k)=Ix(k)*h/3; 
    end
    I=(Ix(1)+Ix(n+1));
    for i=2:n
        if rem(i,2)==0
            I=I+4*Ix(i);
        else
            I=I+2*Ix(i);
        end
    end
    I=I*(X(n+1)-X(1))/(3*n);
    for i=1:n+1
        fprintf('Ix(%f)= %f\n',X(i),Ix(i));
    end
    fprintf('\nI=(%.3f/3)*(Ix(%.2f)',(X(n+1)-X(1))/n,X(1));
    for i=2:n
        if rem(i,2)==0
           fprintf('+4*Ix(%.2f)',X(i));
        else
           fprintf('+2*Ix(%.2f)',X(i));
        end
    end
    fprintf('+Ix(%.2f) )=%f\n->I=%f\n\n',X(n+1),I,I);
end