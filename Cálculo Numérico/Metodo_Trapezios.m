function Metodo_Trapezios
    %Inserir fun��o em f(x):
    f=@(x)exp(x);
    E=input('Insira o valor m�ximo para o erro: ');
    a=input('Insira o in�cio do intervalo: ');
    b=input('Insira o fim do intervalo: ');
    M=input('Insira o valor m�ximo de |f"(x)| em [a,b]: ');
    h=sqrt(E*12/((b-a)*abs(M)));
    n=ceil((b-a)/h);
    h=(b-a)/n;
    I=0;
    for i=0:(n-1)
        I=I+(h/2)*(f(a+i*h)+f(a+(i+1)*h));
    end
    fprintf('O valor da integra��o num�rica � de: %f \n',I);
end