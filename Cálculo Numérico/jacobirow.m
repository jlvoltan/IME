function B=jacobirow(A,r1,r2,m)
    for i=1:length(A)
        A(r1,i)=A(r1,i)-m*A(r2,i);
    end
    B=A;
end