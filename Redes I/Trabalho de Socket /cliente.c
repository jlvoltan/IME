// O endereco IP e o número da porta são passados como argumentos pelo terminal 
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> 
#include <arpa/inet.h>

#define BUFFSIZE 40000

void error(const char *msg)
{
    perror(msg);
    exit(0);
}

int main(int argc, char *argv[])
{
    FILE *target;
    int sockfd, portno, n_bytes, parte = 1;
    struct sockaddr_in serv_addr;
    char continua = '1', buffer[BUFFSIZE], target_file[100], confirma = '1';
    size_t result;

    if (argc < 3) {
       fprintf(stderr,"Uso: %s IP_address port\n", argv[0]);
       exit(0);
    }

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) 
        error("ERRO ao abrir socket do cliente.");

    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET; /* Internet/IP */
	serv_addr.sin_addr.s_addr = inet_addr(argv[1]); /* IP address */
	serv_addr.sin_port = htons(atoi(argv[2])); /* server port */

    
    printf("Insira o nome do arquivo a ser gerado:\n");
    scanf(" %s",target_file);
 
    target = fopen(target_file, "wb");
    if( target == NULL )
    {
      printf("Erro ao criar %s .\n", target_file);
      exit(EXIT_FAILURE);
    }
    
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) 
        error("ERRO ao conectar com o servidor.");
    printf("Insira o nome do arquivo jpg e seu caminho no servidor: \n( Ex.: /home/user/Documents/teste.jpg )\n");
    bzero(buffer,256);
    scanf("%s", buffer);
    n_bytes = write(sockfd,buffer,strlen(buffer));
    if (n_bytes < 0) 
         error("ERRO ao escrever para o socket a partir do lado do cliente.");
    
    while(continua == '1'){

        bzero(buffer,BUFFSIZE);
        n_bytes = read(sockfd,buffer,BUFFSIZE);
        if (n_bytes < 0) 
            error("ERRO ao ler do socket no lado do cliente.");
        
        result = fwrite (buffer , sizeof(char), n_bytes, target);

        if(result != n_bytes)  error("Erro ao escrever no novo arquivo imagem.\n");
        else  printf("Parte %d do arquivo copiada com sucesso: %d bytes recebidos.\n", parte++, n_bytes);

        n_bytes = write(sockfd, &confirma, 1);
    	if (n_bytes < 0) 
        	error("ERRO ao escrever para o socket para confirmacao de envio parcial.\n");

        bzero(buffer,256);
        n_bytes = read(sockfd,buffer,255);
        if (n_bytes < 0) 
            error("ERRO ao ler do socket no lado do cliente.");
        continua = buffer[0];

    }

    printf("Imagem copiada com sucesso.\n");
    close(sockfd);
    fclose(target);
    return 0;
}