function Regra_simpson_repetida
    %Inserir função em f(x):
    f=@(x)exp(-x)-sin(x);
    a=input('Insira o início do intervalo: ');
    b=input('Insira o fim do intervalo: ');
    m=input('Insira o número de subintervalos: ');
    h=(b-a)/m;
    n=m+1;  %numero de pontos
    %X ->vetor com as coordenadas "x" dos pontos
    %Y ->vetor com as coordenadas "y" dos pontos
    X=zeros(1,n);
    Y=zeros(1,n);
    for i=1:n
        X(i)=a+((b-a)/(n-1))*(i-1);
        Y(i)=f(X(i));
    end
    I=(Y(1)+Y(n));
    for i=2:n-1
        if rem(i,2)==0
            I=I+4*Y(i);
        else
            I=I+2*Y(i);
        end
    end
    I=I*h/3;
    disp(I);
end