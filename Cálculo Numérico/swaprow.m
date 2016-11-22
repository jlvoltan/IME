function B=swaprow(A,r1,r2)
    for i=1:length(A)
        l=A(r1,i);
        A(r1,i)=A(r2,i);
        A(r2,i)=l;
    end
    B=A;
end