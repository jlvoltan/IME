function INTERPOLACAO_NEWTON_comdiferencadividida
    n=input('Insira o numero de pontos: ');
    X=input('Insira um vetor com as coordenadas "x" dos pontos: ');
    Y=input('Insira um vetor com as coordenadas "y" dos pontos: ');
    D=zeros(n,n);
    for i=1:n
        D(i,1)=Y(i);
    end
    for i=2:n
        for j=1:n-i+1
            D(j,i)=(D(j+1,i-1)-D(j,i-1))/(X(j+i-1)-X(j));
        end
    end
    disp('Diferencas divididas: ');
    for i=1:n
        for j=1:n-i+1
            fprintf('%f   ',D(i,j));
            if j==n-i+1
                fprintf('\n');
            end
        end
    end
end