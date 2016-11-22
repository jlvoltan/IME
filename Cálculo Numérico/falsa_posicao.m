function falsa_posicao
    erro=input('Insira o erro: \n');
    a=input('Insira o inicio do intervalo: \n');
    b=input('Insira o fim do intervalo: \n');
    f=@(x)cos(x)-x;
    c=(a*abs(f(b))+b*abs(f(a)))/(abs(f(a))+abs(f(b)));
    while abs(f(c))>erro
        if f(a)*f(c)>0
            a=c;   
        else
            b=c;
        end
        c=(a*abs(f(b))+b*abs(f(a)))/(abs(f(a))+abs(f(b)));
    end
    disp(c);
end