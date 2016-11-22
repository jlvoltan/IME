function EDP_Laplace
    n=input('Insira o número de pontos com temperatura a ser determinada: ');
    A=4*eye(n);
    T=zeros(n,1);
    for i=1:n
        j=0;
        fprintf('\nPonto %d\n',i);
        while 1
            if j<4
                y=input('Digite a numeração dos pontos vizinhos desconhecidos, insira 0 para terminar: ');
                if y
                    A(i,y)=-1;
                    j=j+1;
                else
                    break; 
                end
            else
                break;
            end
        end
        while j<4
            y=input('Digite a temperatura dos pontos vizinhos conhecidos: ');
            T(i)=T(i)+y;
            j=j+1;
        end
    end
    fprintf('A*U=T\nA=\n');
    disp(A);
    fprintf('T=\n');
    disp(T);
    fprintf('U=\n');
    U=A\T;
    disp(U);
end