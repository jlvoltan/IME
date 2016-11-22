%Criterio de convergencia para o m�todo de Gauss Jacobi, se bmax<1, ent�o o
%m�todo iterativo gera sequ�ncia convergente para a solu��o do sistema
%linear dado, independentemente da aproxima��o inicial.
function amax=criterio_linhas(A)
    amax=0;
    n=length(A);
    for i=1:n
        temp=0;
        for j=1:n
            if i~=j
                temp=temp+abs(A(i,j))/abs(A(i,i));
            end
        end
        if temp>amax
            amax=temp;
        end
    end
end