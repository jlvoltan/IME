function bissecao
    erro=input('Insira o erro: \n');
    a=input('Insira o inicio do intervalo: \n');
    b=input('Insira o fim do intervalo: \n');
    f=@(x)cos(x)-x;
    c=(b-a)/2;
    while abs(f(a+c))>erro
        if f(a)*f(a+c)>0
            a=a+c;   
        else
            b=a+c;
        end
        c=(b-a)/2;
    end
    disp(a+c);
end