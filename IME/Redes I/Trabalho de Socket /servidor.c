//O numero da porta é passado como argumento pelo terminal
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <assert.h>

#define PACKAGE 1000

void error(const char *msg)
{
    perror(msg);
    exit(1);
}

int main(int argc, char *argv[])
{
     int sockfd, newsockfd, portno;
     socklen_t clilen;
     char source_file[256], continua, recebido;
     struct sockaddr_in serv_addr, cli_addr;
     int n, parte = 1;
     if (argc < 2)
         error("ERRO, a porta nao foi fornecida.\n");

     sockfd = socket(AF_INET, SOCK_STREAM, 0);
     if (sockfd < 0) 
        error("ERRO ao abrir o socket do lado do servidor.\n");
     
     bzero((char *) &serv_addr, sizeof(serv_addr));
     portno = atoi(argv[1]);
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(portno);
     
     if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
     	error("ERRO no binding.");
     listen(sockfd,5);
     clilen = sizeof(cli_addr);
     
     newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
     if (newsockfd < 0)
     	error("ERRO no accept.\n");
     bzero(source_file,256);
     n = read(newsockfd,source_file,255);
     if (n < 0) error("ERRO ao ler do socket no lado do servidor.\n");


     printf("Transferindo arquivo: %s\n",source_file);
     FILE *source;
     long lSize;
     char * buffer;
     size_t result;

     source = fopen(source_file, "rb");
    if( source == NULL )
        error("Erro ao abrir arquivo original.\n");
    
    // obtenção do tamanho do arquivo:
    fseek (source , 0 , SEEK_END);
    lSize = ftell (source);
    rewind (source);

    // alocar memória para todo o arquivo:
    buffer = (char*) malloc (sizeof(char)*lSize);
    if (buffer == NULL)
        error("Erro ao alocar memoria para o buffer do servidor.\n");

    // copiar o arquivo para o buffer:
    result = fread (buffer,sizeof(char),lSize,source);
    if (result != lSize)
        error("Erro ao ler a partir do arquivo original no servidor.\n");

    // o arquivo completo está agora carregado na memória do buffer.

    ssize_t total_bytes_written = 0;
    while (total_bytes_written != lSize)
    {
        assert(total_bytes_written < lSize);
        ssize_t bytes_written = write(  newsockfd,
                                        &buffer[total_bytes_written],
                                        lSize - total_bytes_written < PACKAGE? lSize - total_bytes_written : PACKAGE);

        n = read(newsockfd, &recebido, 1);
        if(n<0)
        	error("ERRO ao confirmar envio\n");
        printf("Parte %d enviada com sucesso: %lu bytes enviados.\n", parte++, bytes_written);

        if (bytes_written < 0)
        {
            error("Erro ao transferir arquivo.\n");
            break;
        }
        total_bytes_written += bytes_written;
        if(total_bytes_written == lSize){
            continua = '0';
            ssize_t bytes_written = write(  newsockfd,
                                            &continua,
                                            1);
        }
        else{
            continua = '1';
            ssize_t bytes_written = write(  newsockfd,
                                            &continua,
                                            1);   
        }

    }
    printf("Envio finalizado com sucesso.\n");

    close(newsockfd);
    close(sockfd);
    fclose(source);
    free(buffer);
    return 0; 
}