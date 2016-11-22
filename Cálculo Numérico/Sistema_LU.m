function Sistema_LU(A,b)
    [L,U,P]=lu(A);
    disp('L:');disp(L);
    disp('U:');disp(U);
    b=P*b;
    disp('b:');disp(b);
    disp('L*y=b');
    y=L\b;
    disp('y:');disp(y);
    disp('U*x=y');
    x=U\y;
    disp('x:');disp(x);
end