function Runge_Kutta_ordem4
    % PVI:   y'=f(x,y) ,  y(X(1))=Y(1)
    %Passo=h
    h=input('Insira o valor do passo: ');
    xi=input('Insira o valor da coordenada x do ponto inicial: ');
    yi=input('Insira o valor da coordenada y do ponto inicial: ');
    xf=input('Insira o valor da coordenada x do ponto final: ');
    f=input('Insira a expressão de f(x,y) (Ex: @(x,y) x+2*y ) : ');
    n=(xf-xi)/h;
    n=round(n);
    X=zeros(1,n+1);
    Y=zeros(1,n+1);
    YA1=zeros(1,n+1);
    YA2=zeros(1,n+1);
    YA3=zeros(1,n+1);
    R1=zeros(1,n+1);
    R2=zeros(1,n+1);
    R3=zeros(1,n+1);
    R4=zeros(1,n+1);
    R=zeros(1,n+1);
    X(1)=xi;
    Y(1)=yi;
    for i=2:n+1
        X(i)=X(i-1)+h;
        R1(i)=f(X(i-1),Y(i-1));
        YA1(i)=Y(i-1)+R1(i)*(h/2);
        R2(i)=f(X(i-1)+(h/2),YA1(i));
        YA2(i)=Y(i-1)+R2(i)*(h/2);
        R3(i)=f(X(i-1)+(h/2),YA2(i));
        YA3(i)=Y(i-1)+R3(i)*h;
        R4(i)=f(X(i-1)+h,YA3(i));
        R(i)=(R1(i)+2*R2(i)+2*R3(i)+R4(i))/6;
        Y(i)=Y(i-1)+h*R(i);
    end
     fprintf('\nx=%f   ;   y=%f\n',X(1),Y(1));
    for i=2:n+1
        fprintf('\nx=%f   ;   y=%f\nR1=%f   ;   R2=%f   ;   R3=%f   ;   R4=%f   ;   R=%f\nYA=%f     ;   YB=%f   ;   YC=%f\n',X(i),Y(i),R1(i),R2(i),R3(i),R4(i),R(i),YA1(i),YA2(i),YA3(i));
    end
end