function Gauss_Jordan(A,b)
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
        temp=b(nmax);
        b(nmax)=b(j);
        b(j)=temp;
        for i=(j+1):length(A)
            b(i)=b(i)-(A(i,j)/A(j,j))*b(j);
            A=jacobirow(A,i,j,A(i,j)/A(j,j));
        end
    end
    for i=1:length(A)
        b(i)=b(i)/A(i,i);
        A=rowmult(A,i,1/A(i,i));
    end
    U=A;
    L=A0/U;
    for i=length(A)-1:-1:1
        for j=length(A):-1:i+1
             b(i)=b(i)-A(i,j)*b(j);
            A=jacobirow(A,i,j,A(i,j));
        end
    end
    disp([A b]);
end