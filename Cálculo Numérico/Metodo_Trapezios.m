function Metodo_Trapezios
    %Inserir função em f(x):
    f=@(x)exp(x);
    E=input('Insira o valor máximo para o erro: ');
    a=input('Insira o início do intervalo: ');
    b=input('Insira o fim do intervalo: ');
    M=input('Insira o valor máximo de |f"(x)| em [a,b]: ');
    h=sqrt(E*12/((b-a)*abs(M)));
    n=ceil((b-a)/h);
    h=(b-a)/n;
    I=0;
    for i=0:(n-1)
        I=I+(h/2)*(f(a+i*h)+f(a+(i+1)*h));
    end
    fprintf('O valor da integração numérica é de: %f \n',I);
end