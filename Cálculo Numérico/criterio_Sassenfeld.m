%Criterio de convergencia para o m�todo de Gauss Seidel, se bmax<1, ent�o o
%m�todo iterativo gera sequ�ncia convergente para a solu��o do sistema
%linear dado, independentemente da aproxima��o inicial.
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