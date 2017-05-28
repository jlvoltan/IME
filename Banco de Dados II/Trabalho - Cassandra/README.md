##Trabalho de Otimização de Consultas no Cassandra em Aplicações Analíticas

O trabalho consiste em avaliar o desempenho de um Banco de Dados projetado para armazenamento no SGBD Cassandra (http://cassandra.apache.org), utilizando duas modelagens lógicas distintas e visões materializadas, em uma aplicação tipicamente analítica (modelada originalmente como esquema estrela).  

A ideia é usar  os dados gerados pelo Benchmark CNSSB (https://github.com/Dehdouh/DBGEN-CNSSB), para comparar o desempenho do Cassandra. Para isso, foi instalado um ambiente de teste em máquinas no laboratório da SE8, com as ferramentas SPARK e Cassandra, bem como, com o conjunto de dados a ser utilizado, nas duas modelagens distintas, já armazenados sob o Cassandra.

Os dados gerados segundo cada modelagem estarão armazenados em um Key Space distinto. Assim,  serão utilizados dois key spaces. O primeiro key space (CNSSB) tem os dados gerados de acordo com uma modelgem onde o esquema estrela SSB é totalmente desnormalizado emu ma única tabela. O segundo key space (CNSSB_CF) os dados são gerados de modo semelhante ao anterior, porém particionado de modo que os dados detalhados de cada dimensão estejam armazenados em tabelas separadas.

Para comparação, cada grupo deve utilizar o conjunto de 4 consultas, atribuídas a cada grupo (ver anexo). Estas consultas são descritas no artigo do Benchmark SSB, disponível em http://www.cs.umb.edu/~poneil/StarSchemaB.PDF

Cada consulta deve ser executada sobre as duas modelagens (CNSSB e CNSSB_CF) .

O ambiente usado informa o tempo de execução da consulta, e este deve ser capturado para análise. Uma vez realizadas as consultas sobre os key spaces gerados, deve-se comparar os resultados. Depois, deve-se gerar um ou mais índices, e  uma  ou  mais visões materializadas de modo a otimizar as consultas, nas duas modelagens.

O grupo deve gerar um relatório, estruturado da seguinte forma:

(1) as consultas e os respectivos tempos de execução;

(2) uma comparação do desempenho nas 2 modelagens;

(3) uma discussão sobre a otmização proposta, justificando as escolhas das visões e índices;

(4) as consultas sobre as visões/índices criados e os respectivos tempos de execução;

(5) comparação dos tempos obtidos comparados às consultas iniciais (sobre o BD original sem visões/índices),  discutindo sobre os ganhos de desempenho obtidos;

(6) dificuldades encontradas (se for o caso).