function newtonraphson

    syms x;
    syms f;
    f=input('Insira a funcao: ');
    g=@(y)subs(f,x,y);
    erro=input('Insira o valor do erro: ');
    x0=input('Insira o valor de x0: ');
    h=@(y) y-g(y)/subs(diff(f),x,y);
    temp=100;
    i=0;
    while abs(temp-x0)>erro
        i=i+1;
        temp=x0;
        x0=h(x0);
        fprintf('Iteração: %d\nERRO: %f\nX: %f\n\n',i,eval(abs(temp-x0)),eval(x0));
    end
    disp('A raiz eh aproximadamente: ');
    disp(eval(x0));
end
%Exemplo para f: exp(x)-2*cos(x) ; erro=0001; x0=0.5;