%Criterio de convergencia para o método de Gauss Seidel, se bmax<1, então o
%método iterativo gera sequência convergente para a solução do sistema
%linear dado, independentemente da aproximação inicial.
function bmax=criterio_Sassenfeld(A)
    n=length(A);
    b=ones(1,n);
    for i=1:n
        numerador=0;
        for j=1:n
            if i~=j
                numerador=numerador+abs(A(i,j))*b(j);
            end
        end
        b(i)=numerador/A(i,i);
    end
    bmax=0;
    for i=1:n
        if b(i)>bmax
            bmax=b(i);
        end
    end
end