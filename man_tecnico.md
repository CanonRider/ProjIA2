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

O algoritmo Negamax implementado por nós começa por criar uma variável com o nome "nos-filhos" que será uma lista de nós filhos originados através do nó recebido como argumento, na primeira iteração do algoritmo será o nó root. Esta variável (nos-filhos) irá receber os nós filhos já ordenados pelo seu valor, graças à função auxiliar "ordena-nos". É também criada uma variável com o nome "value" com o maior número possível negativo, uma vez que o objetivo é que esta variável represente inicialmente o infinito negativo. Após isto o algoritmo começa por testas se a profundidade chegou ao seu limite (limite desejado inserido pelo humano) e se o nó em que estamos é um nó folha, ou seja, um nó terminal em que já não é possível expandir mais aquele ramo. Caso se verifique uma destas condições, o algoritmo chama uma função auxiliar responsável por nos dar o valor do nó folha encontrado que é a função "get-valor".
No caso de nenhuma das condições se verificar, o algoritmo entra num ciclo em que só termina quando o valor da variável "alfa", que é passada como parâmetro da função, for maior ou igual à variável "beta", também ela passada como parâmetro. Enquanto não se verificar a condição de paragem, a variável "nos-filhos", criada no ínicio, será percorrida e enquanto não for pecorrida na sua totalidade o algoritmo irá atribuir o máximo valor à variável "value" entre o seu própio valor e a chamada à função negamax com os parâmetros ajustados a um novo nível de uma árvore, em que a profundidade irá diminuir, e os valores de beta e alfa irão ser o simétrico. O algoritmo faz também uma atribuição ao valor de "alfa" em que "alfa" irá ter como valor o valor máximo entre o própio valor da variável "alfa" e o valor da variável "value".  

```lisp
(defun negamax(no profundidade alfa beta)
  ""
  (let ((nos-filhos (ordena-nos (gerar-sucessores no profundidade)))
        (value most-negative-fixnum))
    (cond ((or (= profundidade 0) (equal (no-folha no) T)) (get-valor no))
          (t (loop for i from 0 to (- (list-length nos-filhos) 1) do
                (setq value (max value -(negamax i (- profundidade 1) (- beta) (- alfa))))
                (setq alfa (max alfa value))
                (when (>= alfa beta) (return)))))))
```

<div style="page-break-after: always"></div>

## **Funções auxiliares**

As funções auxiliares utilizadas no algoritmo negamax implementado por nós foram:

- ordena-nos;
- gerar-sucessores;
- no-folha;
- get-valor;
- list-length;
- max;


### **Funções auxiliares: ordenar-nos**

```lisp
(defun ordenar-nos (lista)
  "Ordena os nós da lista pelo seu valor"
    (cond ((null lista) "lista ordenada")
          (t (sort lista #'> :key 'get-valor)))
)
```

### **Funções auxiliares: gerar-sucessores**

Esta função gera todos os sucessores de um dado nó. Caso este nó não tenha peças de reserva então a função retorna nul, caso contrário a função é responsável por retornar uma lista com todos os nós filhos do nó recebido como argumento.

```lisp
(defun gerar-sucessores(no profundidade)
  "Retorna lista dos filhos do no. Caso a reserva esteja vazia retorna nil"
    (cond
     ((null (reserva no)) nil)
     ((= profundidade 0) no)
     (t (gerar-colunas no))))
     

(defun gerar-colunas (no &optional (col 4) (lista '()))
    "Recebe um nó vai gerar nós para todas as posições de todas as colunas"
  (cond ((< col 1) lista)
        (t (gerar-colunas no (- col 1) (gerar-linhas no col lista)))))

(defun gerar-linhas (no col lista &optional (lin 4))
    "Recebe um nó, uma coluna e uma lista e vai gerar nós para todas as posições com a coluna indicada e todas as linhas"
  (cond ((< lin 1) lista)
        ((casa-vaziap col lin (tabuleiro no)) (gerar-linhas no col (juntar-listas lista (gerar-nos-posicao col lin no (reserva no))) (- lin 1)))
        (t (gerar-linhas no col lista (- lin 1)))))
```

#### **Funções auxiliares: no-folha**

A função "no-folha" diz-nos se um nó que recebe como argumento é um nó folha ou não, testando se este nó não tem peças de reserva e se é um nó solução do problema. Caso estas duas condições se verifiquem retorna verdadeiro caso contrário retorna falso.

```lisp
(defun no-folha (no)
  "Retorna T se nó for um nó folha caso contrário retorna nil"
  (cond 
   ((null (reserva no)) T)
   ((no-solucao no) T); caso seja nó solução retorna T pois é folha.
   (T nil)))
```

#### **Funções auxiliares: get-valor**

A função "get-valor" é uma função muito simples que só nos retorna o quarto parâmetro encontrado dentro da estrutura que constitui um nó, sendo este o valor que o nó contém.

```lisp
(defun get-valor (no)
  "Retorna o valor do nó"
  (fourth no))
```

#### **Funções auxiliares: list-length**

A função "list-length" é um função que já está implementada na linguagem lisp. O nosso objetivo era com esta função obter o tamanho de uma lista e uma vez que já existiam funções implementadas, reutilizámos o código disponível.

#### **Funções auxiliares: max**

À semelhança da função "list-length", é uma função também já implementada em lisp em que apenas aproveitámos para utilizar código já disponível pelo lisp. Com esta função queríamos obter o máximo valor entre dois números.


<div style="page-break-after: always"></div>

## **Constituição de um nó**

Para representar um nó optámos por criar uma estrutura com a seguinte constituição: tabuleiro completo, a profundidade do nó, nó pai e o valor do nó.

Com "tabuleiro completo" queremos referir que fazem parte o tabuleiro de jogo juntamento com as peças de reserva.

Quando dizemos "profundidade" referimo-nos ao nível em que o nó está situado.

Com "nó pai", tal como o nome sugere referimo-nos ao nó que lhe deu origem.

E por último com "valor do nó" queremos referir que é o resultado de uma série de critérios que em conjunto irão originar um valor que irá corresponder ao valor que o nó representa.

Para a criação desta mesma estrutura que acabámos de referir utilizamos a função "criar-no" que é a grande responsável pela criação de um nó.

```lisp
(defun criar-no(allTab &optional (profundidade 0) (noPai nil))
  "Criar estrutura de um no"
  (list allTab profundidade noPai (avaliar-no (criar-no-aux allTab profundidade noPai))))

(defun criar-no-aux (allTab &optional (profundidade 0) (noPai nil))
  "Criar estrutura de um no sem valor, função auxiliar para a função criar-no"
  (list allTab profundidade noPai))
```


<div style="page-break-after: always"></div>

## **Análise estatística**




<div style="page-break-after: always"></div>

## **Limitações técnicas e ideias para desenvolvimento**  

