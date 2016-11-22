%ATENÇÃO-> p deve atender: 0<p<=h*h/(2*a)
%caso deseje outro valor, altere na linha 13, p está padronizado inicialmente em h*h/(2*a) 

function EDP_parabolica

    l=input('Insira o comprimento da barra: ');
    %a=(alfa)²
    a=input('Insira o valor do coeficiente de difusividade (alfa)² : ');
    ui=input('Insira o valor da temperatura da fonte à esquerda da barra: ');
    ub=input('Insira a função de distribuição inicial de temperatura (exemplo de entrada @(x)x^3+1): ');
    n=input('Insira o número de divisões da barra: ');
    h=l/n;
    p=h*h/(2*a);
    isol=input('Se a extremidade da direita for isolada, insira 1, caso contrário, insira 0: ');
    if isol==1
        nc=n+2;
        uf=ub(l);
    else
        nc=n+1;
        uf=input('Insira o valor da temperatura da fonte à direita da barra: ');
    end
    et=input('Insira 1 caso deseje calcular o tempo até o equilíbrio térmico ser atingido, insira 0 caso deseje calcular a distribuição de temperatura em um determinado instante: ');
    if et==1
        tol=input('Insira o valor da tolerância de erro: ');
        nmi=input('Insira o número máximo de iterações: ');
    else
        tempo=input('Insira o instante para análise da distribuição de temperatura: ');
        nmi=round(floor(tempo/p));
        tol=0;
    end
    u=zeros(1,n+1);
    for i=2:1:n
        u(i)=ub(h*(i-1));
    end
    d=1;    %Indicador de convergência
    c=0;    %Contador de iterações
    t=0;    %Contador de tempo
    v=zeros(1,n+1);
    %Valores de contorno
    u(1)=ui;v(1)=ui;
    u(n+1)=uf;v(n+1)=uf;
    fprintf('\nIterações\n');
    fprintf('tempo=%f   ',0);disp(u);
    while (d>0)&&(c<=nmi)
        d=0;
        if (nc>n+1)
            u(nc)=u(n);
        end
        c=c+1;
        t=t+p;
        for i=2:1:(nc-1)
            vx=v(i);
            v(i)=p*a*(u(i-1)+u(i+1))/(h*h)+(1-2*p*a/(h*h))*u(i);
            if abs(vx-v(i))>tol
                d=1;
            end
        end
        fprintf('tempo=%f   ',t);disp(v);
        for j=2:1:(nc-1)
                u(j)=v(j);
        end
    end
    if c>nmi
        fprintf('\nO número máximo de iterações foi ultrapassado\n');
    end
end