function B=pivot(A)
    A0=A;
    for j=1:(length(A)-1)   
        max=0;
        for i=j:length(A)
            if abs(A(i,j))>abs(max)
                max=A(i,j);
                nmax=i;
            end
        end
        A=swaprow(A,nmax,j);
        for i=(j+1):length(A)
            A=jacobirow(A,i,j,A(i,j)/A(j,j));
        end
    end
    for i=1:length(A)
        A=rowmult(A,i,1/A(i,i));
    end
    U=A;
    L=A0/U;
    for i=length(A)-1:-1:1
        for j=length(A):-1:i+1
            A=jacobirow(A,i,j,A(i,j));
        end
    end
    B=A;
end