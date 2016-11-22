function B=rowmult(A,r,m)
    for i=1:length(A)
        A(r,i)=m*A(r,i);
    end
    B=A;
end