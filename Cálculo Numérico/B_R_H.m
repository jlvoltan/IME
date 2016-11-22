function b=B_R_H(a,x)
    b(length(a))=a(length(a));
    for i=length(a)-1:-1:1
        b(i)=x*b(i+1)+a(i);
    end
end