Implementar um algoritmo paralelo usando MPI e threads para realizar as seguintes operações em uma matriz quadrada:
Multiplicar os elementos de cada linha pelo elemento da diagonal da linha correspondente.
Somar todos os elementos da matriz resultante.
Apenas um nó vai ler a matriz de um arquivo e vai distribuir a matriz pelos nós de processamento. Esta distribuição deve ser por blocos, isto é, cada nó vai receber uma sub-matriz de mesmo tamanho. O tamanho da matriz será 16000x16000. 
No caso da divisão por 2 processadores, o tamanho das sub-matrizes será 8000X16000. E no caso da divisão por 4 processadores o tamanho das sub-matrizes será 8000X8000.

Implementar as seguintes versões:
Usando apenas MPI e executar com 2 e 4 processadores.
Usando apenas threads e executar com 2 e 4 processadores.
Usando MPI e threads e executar com 2 nós e 2 threads por nó.
As versões que usam MPI devem usar a operação coletiva MPI_reduce para obter a soma total dos elementos da matriz.
Deve-se calcular o tempo de execução e gerar um gráfico com o speedup de cada execução. Sugestão: usar a função gettimeofday.
Além dos arquivos fonte dos programas, deve-se entregar um relatório contendo os gráficos e uma análise dos mesmos.
