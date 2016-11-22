function Briot_Ruffini_Newton_Raphson
    clear;
    a=input('Insira os coeficientes do polinomio como um vetor ( Ex:[1,2,3]), iniciando do termo de grau 0 e seguindo em ordem crescente: ');
    n=length(a)-1;
    erro=input('Insira o valor do erro: ');
    x=input('Insira x inicial para a análise: ');
    raizes=0;
    i=0;
    d=zeros([1,n]);
    while raizes<n
        i=i+1;
        b=B_R_H(a,x);
        disp(x);
        c=B_R_H(b,x);
        if abs(b(raizes+1))<erro
            raizes=raizes+1;
            d(raizes)=x;
            a=b;
        else
            if c(raizes+2)==0
                disp('obs.: Erro no metodo de Newton-Raphson, zero no denominador, tente novamente com um novo valor de x inicial');
                break;
            else
                x=x-(b(raizes+1)/c(raizes+2));
            end
        end
        if i>100000
            disp('obs.: O programa nao foi executado completamente, as demais raizes provavelmente sao complexas');
            break;
        end
    end
    disp('As raizes reais sao: ');
    for j=1:raizes
        disp(d(j));
    end
end