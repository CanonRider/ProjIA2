# **Manual do Utilizador**  

Inteligência Artificial - Escola Superior de Tecnologia de Setúbal  
Ano letivo 2020/2021 - 1º Semestre  

Realizado por:  
João Azevedo nº 180221119  
Sara Carvalho nº 180221048

<div style="page-break-after: always"></div>

## **O jogo do 4: Regras**

O jogo do 4 é um jogo de tabuleiro. Este tabuleiro está dividido em 4 linhas e em 4 colunas. O grande objetivo do jogo, que precisa de ser cumprido para se vencer o jogo, é o alinhamento quer seja por uma linha, por uma coluna ou pelas diagonais de 4 peças que contenham pelo menos 1 característica em comum. O primeiro jogador a conseguir fazer isso ganha o jogo. Caso o tabuleiro fique cheio e não se verificar uma condição de viória o jogo acaba empatado.

Cada jogador, à vez, tem a oportunidade de fazer 1 jogada.

Primeiramente ao iniciar o jogo, o utilizador será questionado sobre o modo de jogo que deseja tendo as seguintes opções: Humano vs Computador ou Computador vs Computador. O utilizador deverá escolher a sua preferência através do teclado inserindo a opção correspondente que deseja. Após isso o utilizador terá de inserir informações que serão do critério do utilizador, estas informações são importantes para o jogo, como por exemplo a duração que deseja que tenha um jogo na sua totalidade ou a duração que deseja que o computador tenha para realizar a sua jogada. As perguntas que lhe forem solicitadas dependeram de escolhas que o utilizador fez previamente, por exemplo se optar pelo modo de jogo "1" irá ser-lhe pedida a duração que o computador terá para realizar a sua jogada, se escolher o modo de jogo "2" será pedida a duração limite que o jogo entre computador vs computador terá.

Será também pedido um valor para uma profundidade máxima que terá influência no decorrer do jogo na medida em que afetará o algoritmo implementado por nós e este valor dependerá apenas da decisão do utilizador que o insirá através do teclado.

<div style="page-break-after: always"></div>

## **Exemplos de questões**

```
Qual o modo de jogo? 
1- Humano vs computador 
2- Computador vs Computador 
R:    
```

```
Qual a profundidade limite? 
R:
```

````
Quanto tempo limite para o computador jogar? (entre 1000 e 5000 ms) 
R:
````

````
Que jogador começa? 
1- Humano 
2- Computador 
R:
````

São alguns exemplos de questões em que irão ser solicitadas respostas ao utilizador no inicio do jogo.



## **Limitações do utilizador**  

No nosso "jogo do 4" o utilizador apenas tem poder de decisão na jogada que realiza cada vez que é o seu turno de jogo e nas questões que le são colocadas no início de jogo, fora isso a maneira como se processa o jogo está escondida do jogador, este apenas tem acesso a uma representação do tabuleiro para decidir qual irá ser a sua jogada. A maneira como serão processados os dados e a própria jogada do computador o jogador não tem qualquer tipo de acesso.

<div style="page-break-after: always"></div>

## **Informação produzida durante a execução do jogo**

Durante a duração do jogo vão sendo guardados dados resultantes de operações efetuadas como o número de nós analisados, o número de cortes efetuados, o tempo gasto em cada jogada e o tabuleiro de jogo. Isto será guardado num ficheiro com o nome de "log.dat"