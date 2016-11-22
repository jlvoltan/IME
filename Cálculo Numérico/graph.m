x=0:0.01:0.5;
y=abs(exp(-x)+sin(x));
plot(x,y);
xlabel('x');
ylabel('y');
title('Grafico de f(x)');
grid on;