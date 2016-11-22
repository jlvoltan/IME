function Runge_Kutta_ordem2
    % PVI:   y'=f(x,y) ,  y(X(1))=Y(1)
    %Passo=h
    h=input('\nInsira o valor do passo: ');
    xi=input('Insira o valor da coordenada x do ponto inicial: ');
    yi=input('Insira o valor da coordenada y do ponto inicial: ');
    xf=input('Insira o valor da coordenada x do ponto final: ');
    f=input('Insira a expressão de f(x,y) (Ex: @(x,y) x+2*y ) : ');
    n=(xf-xi)/h;
    n=round(n);
    X=zeros(1,n+1);
    Y=zeros(1,n+1);
    Ye=zeros(1,n+1);
    X(1)=xi;
    Y(1)=yi;
    for i=2:n+1
        X(i)=X(i-1)+h;
        Ye(i)=Y(i-1)+h*f(X(i-1),Y(i-1));
        Y(i)=Y(i-1)+(f(X(i-1),Y(i-1))+f(X(i),Ye(i)))*(h/2);
    end
    fprintf('x=%f   ;   y=%f\n',X(i),Y(i));
    for i=2:n+1
        fprintf('x=%f   ;   y=%f    ;   ye=%f\n',X(i),Y(i),Ye(i));
    end
end