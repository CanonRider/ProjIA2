# **Manual Técnico**  

Inteligência Artificial - Escola Superior de Tecnologia de Setúbal  
Ano letivo 2020/2021 - 1º Semestre  

Realizado por:  
João Azevedo nº 180221119  
Sara Carvalho nº 180221048

<div style="page-break-after: always"></div>

## **Aquitetura do Sistema**  

Ao desenvolver este projeto, dividimos o código 3 ficheiros lisp, são eles:

- algoritmo.lisp
- interact.lisp
- jogo.lisp


No ficheiro **algoritmo.lisp** implementamos todas as funções relativas ao algoritmo em si. No nosso caso optámos por escolher o algoritmo negamax para implementar. Qualquer função relativa a este algoritmo está implementada neste ficheiro.

No ficheiro **interact.lisp** implementamos funções responsáveis por ler e escrever em ficheiros e implementamos também funções responsáveis pela interação com o utilizador. Temos funções que leem em que modo o utilizador deseja que o jogo ocorra, se humano vs computador ou computador vs computador, temos funções de leitura de tempos limite, tanto para o computador jogar como para o jogo decorrer, e temos uma função que pede a profundidade máxima que o utilizador deseja.

No ficheiro **jogo.lisp** implementamos funções auxiliares para ajudar no funcionamento  do jogo responsáveis pela manipulação de nós. Isto é, desde funções simples como funções que nos dão posições das peças, que nos dizem se uma peça é repetida ou não, até funções mais complexas como funções que imprimem o estado do jogo, que avalião os nós para estes terem um valor atribuído. É também neste ficheiro que se encontram as funções responsáveis pela geração de nós.


Estes 3 ficheiros estão interligados uma vez que o ficheiro **interact.lisp** vai usar funções implementadas no ficheiro **algoritmo.lisp** e o ficheiro **algoritmo.lisp** vai usar funções implementadas no ficheiro **jogo.lisp** e é por esta razão, que antes de usar o comando *(iniciar)*, temos de abrir e compilar os ficheiros pela seguinte ordem:

1. jogo.lisp
2. algoritmo.lisp
3. interact.lisp


<div style="page-break-after: always"></div>

## **Algoritmo e a sua implementação** 

### Negamax

O algoritmo Negamax implementado por nós começa por criar uma variáel com o nome "nos-filhos" que será uma lista de nós filhos do nó recebido como argumento (na primeira iteração do algoritmo será o nó root) e irá ter os nós já de forma ordenada pelo seu valor, cria também uma variável "value" com o maior número possível negativo, uma vez que o objetivo é que esta variável contenha o menor número possível. Após isto o algoritmo começa por testas se a profundidade chegou ao seu limite (limite desejado inserido pelo humano) e se o nó em que estamos é um nó folha, ou seja, um nó terminal em que já não é possível expandir mais aquele ramo. Caso se verifique uma destas condições, o algoritmo chama uma função responsável por avaliar o nó folha, assim este nó terá um valor atribuído, calculado segundo regras definidas por nós previamente,
caso nenhuma das condições se verifique o algoritmo entra num ciclo em que só termina quando o valor da variável "alfa", passada como parâmetro da função, for maior ou igual à variável "beta", também ela passada como parâmetro. Enquanto não se verificar a condição de paragem, a variável "nos-filhos", criada no ínicio, será percorrida e enquanto não for pecorrida na sua totalidade o algoritmo irá atribuir o máximo valor à variável "value", também ela criada co início, entre o seu própio valor e a chamada recursiva à função negamax com os parâmetros ajustados a um novo nível de uma árvore, em que a profundidade irá diminuir, e os valores de beta e alfa irão ser o simétrico do nível acima deste. O algoritmo faz também uma atribuição ao valor de "alfa" que irá ter como resultado o valor máximo entre o própio valor da variável "alfa" e o valor da variável "value"  


```lisp
lugar para o codigo negamax
```

<div style="page-break-after: always"></div>

#### Resultados da execução do algoritmo




<div style="page-break-after: always"></div>

## **Limitações técnicas e ideias para desenvolvimento**  

- A*, especificamente as funções auxiliares
- Correção do dfs, especificamente na condição de paragem
- Criação de uma nova heuristica para ser utilizada no algoritmo A*
- Resolução dos problemas D, E e F utilizando o algoritmo DFS

