function MPF
    erro=input('Insira o valor do erro: ');
    x=input('Insira x inicial para a análise: ');
    f=@(x)(5*x^(-2)+2);
    i=1;
    while abs(f(x)-x)>erro
        i=i+1;
        x=f(x);
    end
    disp(x);
    disp(i);
end