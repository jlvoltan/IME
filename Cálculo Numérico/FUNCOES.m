function b=FUNCOES(i,x)
    switch i
        case 1
            b=(x(1)^3+(x(1)^2)*x(2)-x(1)*x(3)+6);
        case 2
            b=exp(x(1))+exp(x(2))-x(3);
        case 3
            b=x(2)^2-2*x(1)*x(3)-4;
    end
end
    