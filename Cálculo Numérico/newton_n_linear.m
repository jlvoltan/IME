function newton_n_linear
    syms x1 x2 x3 f1 f2 f3 F J A B X;
    f1=(x1^2+x2*x1^2-x1*x3+6);
    f2=exp(x1)+exp(x2)-x3;
    f3=x2^2-2*x1*x3-4;
    F=[f1;f2;f3];
    J=jacobian(F);
    X=[-1;-2;1];
    erro=100;
    while erro>0.001
        A=subs(J,x1,X(1));
        A=subs(A,x2,X(2));
        A=subs(A,x3,X(3));
        Z=A;
        B=subs(F,x1,X(1));
        B=subs(B,x2,X(2));
        B=subs(B,x3,X(3));
        Y=B;
        S=Z\(-Y); %S=inv(Z)*(-Y);
        erro=0;
        for i=1:length(F)
            if abs(S(i,1))>erro
                erro=abs(S(i,1));
            end
        end
        X=S+X;
        eval(X)
    end
end