function INTERPOLACAO_NEWTON_semdiferencadividida
    n=input('Insira o numero de pontos: ');
    X=input('Insira um vetor com as coordenadas "x" dos pontos: ');
    Y=input('Insira um vetor com as coordenadas "y" dos pontos: ');
    a=zeros([1,n]);
    a(1)=Y(1);
    for i=2:n
        produto=ones(1,n);
        numerador=0;
        for j=2:i
            produto(j)=produto(j-1)*(X(i)-X(j-1));
        end
        for j=1:(i-1)
            numerador=numerador+a(j)*produto(j);
        end
        a(i)=(Y(i)-numerador)/produto(i);
    end
    disp(a);
end