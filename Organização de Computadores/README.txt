Construir programa em linguagem de programação seguindo o paradigma e as boas práticas de
programação orientada a objetos, podendo ser desktop, via linha de comando ou web, podendo ser
Java ou C++, atendendo aos seguintes requisitos nos seus menus:

a. Programa deve receber um conjunto de informações (uma linha, caracteres e números inteiros) e
ter opção para fazer a gravação dos mesmos em formato Little Endian ou Big Endian. Após isso
deve prover a possibilidade da leitura ser realizada e a mesma ser apresentada escolhendo-se o
formato Little Endian ou Big Endian, mostrando também qual foi o formato e conteúdo gravados
originalmente.

b. Programa deve ter a capacidade de uma vez definidos um alfabeto para transmissão de 4 bits de
informação (todas as possibilidades possíveis), fazer o código a ser transmitido com as
redundâncias para detecção e recuperação de um bit, além de um bit extra para teste de paridade
ímpar. Após isso deve ser possível escolher uma das palavras código e selecionar um bit para ser
invertido (simulação de erro na transmissão). Posteriormente deve ser simulado o receptor, que irá
verificar a paridade e dizer se a recepção foi correta ou não, no caso de incorreção deve ter a
capacidade de recuperar a informação correta. Tudo deve ser implementado e calculado utilizando o
algoritmo de Hamming e os conceitos matemáticos associados a bits, paridade e operações lógicas.

c. Programa deve simular o esquema de armazenamento e recuperação RAID 3 com um bit de
informação por disco ao invés de uma tira, recebendo um conjunto de informações em tempo de
execução (uma linha, caracteres e números inteiros), com quatro discos para informação e um para
as redundâncias e paridade. Deve ser simulada a perda de um disco e recuperação dos dados
perdidos.