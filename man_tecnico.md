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

No ficheiro **algoritmo.lisp** implementamos todas as funções relativas ao algoritmo e as suas funções auxiliares. No nosso caso optámos por escolher o algoritmo negamax para implementar. Qualquer função relativa a este algoritmo está implementada neste ficheiro.

No ficheiro **interact.lisp** implementamos funções responsáveis por ler e escrever em ficheiros e implementamos também funções responsáveis pela interação com o utilizador. Temos funções que leem em que modo o utilizador deseja que o jogo ocorra, se humano vs computador ou computador vs computador, temos funções de leitura de tempos limite, tanto para o computador jogar como para o jogo decorrer, temos uma função que pede a profundidade máxima que o utilizador deseja, temos uma função para lermos a jogada de um jogador, entre outras. É aqui que estão também funções responsáveis pelo arranque do jogo, e pelo controlo do jogo, isto é, é a partir destas funções que internamente decidimos a maneira como chamamos as funções para iniciar o jogo com as configurações pedidas pelo jogador.

No ficheiro **jogo.lisp** implementamos funções auxiliares para ajudar no funcionamento do jogo responsáveis pela manipulação de nós. Isto é, desde funções simples como funções que nos dão posições das peças, que nos dizem se uma peça é repetida ou não, até funções mais complexas como funções que imprimem o estado do jogo, que avaliam os nós para estes terem um valor atribuído, é aqui que estão também as funções responsáveis pela geração de nós. Temos também um operador e as suas funções auxliares. As funções auxiliares são o "remover-peca" e "substituir", tal como os nomes sugerem uma remove uma peça do tabuleiro, e a outra substitui uma peça no tabuleiro. Já o operador retorna um tabuleiro já com uma nova peça inserida.  

Estes 3 ficheiros estão interligados uma vez que o ficheiro **interact.lisp** vai usar funções implementadas no ficheiro **algoritmo.lisp** e o ficheiro **algoritmo.lisp** vai usar funções implementadas no ficheiro **jogo.lisp** e é por esta razão, que antes de usar o comando _(iniciar)_, temos de abrir e compilar os ficheiros pela seguinte ordem:

1. jogo.lisp
2. algoritmo.lisp
3. interact.lisp

<div style="page-break-after: always"></div>

## **Algoritmo e a sua implementação**

O algoritmo Negamax implementado por nós começa por testas se a profundidade chegou ao seu limite (limite desejado inserido pelo humano), se o nó em que estamos é um nó folha, ou seja, um nó terminal em que já não é possível expandir mais aquele ramo e se o tempo de execução do negamax já atingiu o limite desejado, também ele inserido pelo utilizador. Caso se verifique uma destas condições, o algoritmo chama uma função auxiliar responsável por nos dar o resultado do jogo que é a função "resultado".
No caso de nenhuma das condições se verificar, o algoritmo criar uma variável com o nome "nos-filhos" que será uma lista de nós filhos originados através do nó recebido como argumento, na primeira iteração do algoritmo será o nó root. Esta variável (nos-filhos) irá receber os nós filhos já ordenados pelo seu valor, graças à função auxiliar "ordena-nos". É também criada uma variável com o nome "value" com o maior número possível negativo, uma vez que o objetivo é que esta variável represente inicialmente o infinito negativo. Após isto o algoritmo chama uma função auxiliar "negamax-aux" que começa por verificar se o tamanho da lista recebido como parâmetro "nos-filhos" tem tamanho igual a 1. Caso se verifique esta condição a função retorna o resultado do jogo, caso não se verifique a função cria uma nova variável com nome "no-nega" que terá como valor a chamada da função "negamax" explicada anteriormente. Após isso compara dois valores que serão os valores que estão dentro da variável "value" e do inverso do valor da variável "no-nega" respetivamente e escolhe o valor máximo entre as duas variáveis e guarda na variável "value". Depois disso cria uma nova variável "alfa" que será o máximo entre a variável "alfa" recebida como parâmetro e a variável "value", anteriormente referida. 
Após isto a função verifica se a variável "alfa" é maior ou igual à variável "beta" que foi recebido nos argumentos da função e caso seja verdade esta condição estamos em condição de corte e retorna o resultado do jogo. Senão vai chamar recursivamente a função "negamax-aux" com os parâmetros ajustados, que neste caso serão o resto da lista de nós filhos "(cdr nos-filhos)".


```lisp
(defun negamax(no profundidade jogador tempo &optional (alfa most-negative-fixnum) (beta most-negative-fixnum) (tempoInicial (get-universal-time)) (cortes 0))
  "Função do algoritmo negamax" 
  (cond ((or (= profundidade 0) (no-folha no) (>= (tempo-usado tempoInicial) tempo)) (resultado no jogador cortes))
        (t (let ((nos-filhos (ordenar-nos (gerar-sucessores no profundidade)))
                 (value most-negative-fixnum))
             (negamax-aux no profundidade jogador alfa beta nos-filhos value tempoInicial cortes)))))


(defun negamax-aux (no profundidade jogador alfa beta nos-filhos value tempoInicial cortes)
  "Função recursiva auxiliar do algoritmo negamax"
  (cond ((= (list-length nos-filhos) 1) (resultado nos-filhos jogador tempoInicial cortes))
        (t (let ((no-nega (negamax (car nos-filhos) (- profundidade 1) (- jogador) tempoInicial (- beta) (- alfa))))
             (setq value (max value (- (get-valor no-nega))))
             (setq alfa (max alfa value))
             (cond ((>= alfa beta) (resultado no-nega jogador tempoInicial (+ cortes 1))) ;cut-off
                   (t (negamax-aux no profundidade jogador alfa beta (cdr nos-filhos) value tempoInicial cortes)))))))
```

<div style="page-break-after: always"></div>

## **Funções auxiliares**

As funções auxiliares utilizadas no algoritmo negamax implementado por nós foram:

- ordena-nos;
- gerar-sucessores;
- resultado;
- no-folha;
- get-valor;
- tempo-usado;
- list-length;
- max;
- get-universal-time;

### **Funções auxiliares: ordenar-nos**

```lisp
(defun ordenar-nos (lista)
  "Ordena os nós da lista pelo seu valor"
  (if (> (list-length lista) 1)
      (sort lista #'> :key 'avaliar-no)
    nil)
)
```

### **Funções auxiliares: gerar-sucessores**

Esta função gera todos os sucessores de um dado nó. Caso este nó não tenha peças de reserva então a função retorna nul, caso contrário a função é responsável por retornar uma lista com todos os nós filhos do nó recebido como argumento.

```lisp
(defun gerar-nos-posicao(x y no reserv &optional (lista '()))
  "Retorna numa lista todos os nós filhos possíveis numa dada posição (x,y)"
  (cond
    ((null reserv) lista )
    ((not(casa-vaziap x y (tabuleiro no))) (gerar-nos-posicao x y no (cdr reserv) lista))
    (t (gerar-nos-posicao x y no (cdr reserv) (cons (criar-no (get-allTab (operador (conversor-coluna-nl x) y (car reserv) no)) (+ (get-profundidade no) 1) no) (gerar-nos-posicao x y no (cdr reserv)))))));Faz lista com todos os filhos possíveis do nó recebido numa dada posição, já na forma de nó.


; Teste: (gerar-sucessores (criar-no (get-tabuleiro_init)) 1)
(defun gerar-sucessores(no profundidade)
  "Retorna lista dos filhos do no. Caso a reserva esteja vazia retorna nil"
    (cond
     ((null (reserva no)) nil)
     ((= profundidade 0) no)
     (t (gerar-colunas no))))


(defun gerar-colunas (no &optional (col 4) (lista '()))
   "Recebe um no vai gerar nós para todas as posições de todas as colunas"
  (cond ((< col 1) lista)
        (t (gerar-colunas no (- col 1) (gerar-linhas no col lista)))))

(defun gerar-linhas (no col lista &optional (lin 4))
  "Recebe um no, uma coluna e uma lista e vai gerar nós para todas as posições com a coluna indicada e todas as linhas"
  (cond ((< lin 1) lista)
        ((casa-vaziap col lin (tabuleiro no)) (gerar-linhas no col (juntar-listas lista (gerar-nos-posicao col lin no (reserva no))) (- lin 1)))
        (t (gerar-linhas no col lista (- lin 1)))))
```

### **Funções auxiliares: resultado**

A função "resultado" é responsável por nos dar algumas estatísticas sobre um dado momento de jogo. Recebe como argumentos um nó um jogador o tempo e a quantidade de cortes. E retorna uma lista com uma série de informação como por exemplo o nó resultado (que nos dá a constituição de um nó com o seu valor), o tempo que foi usado na jogada, o valor do nó, a profundidade do nó e os cortes efetuados.

```lisp
(defun resultado (no jogador tempo cortes)
  "Função que retorna o nó resultado com as estatísticas do valor, profundidade e cortes efetuados"
  (list (no-resultado no jogador) (list (tempo-usado tempo) (get-valor (no-resultado no jogador)) (get-profundidade no) cortes)))
```

#### **Funções auxiliares: no-folha**

A função "no-folha" diz-nos se um nó que recebe como argumento é um nó folha ou não, testando se este nó não tem peças de reserva e se é um nó solução do problema. Caso estas duas condições se verifiquem retorna verdadeiro caso contrário retorna falso.

```lisp
(defun no-folha (no)
  "Retorna T se nó for um nó folha caso contrário retorna nil"
  (cond
   ((null (reserva no)) T)
   ((no-solucao no) T); caso seja nó solução retorna T pois é folha.
   (t nil)))
```

#### **Funções auxiliares: get-valor**

A função "get-valor" é uma função muito simples que só nos retorna o quarto parâmetro encontrado dentro da estrutura que constitui um nó, sendo este o valor que o nó contém.

```lisp
(defun get-valor (no)
  "Retorna o valor do nó"
  (fourth no))
```

#### **Funções auxiliares: tempo-usado**

"tempo-usado" é uma função muito simples que apenas nos calcula o tempo que uma jogada demorou a ser feita. Recebe um tempo inicial e retorna o tempo da jogada.

```lisp
(defun tempo-usado (tempoInicial)
  "Função que retorna o tempo usado na jogada"
  (- (get-universal-time) tempoInicial))
```


#### **Funções auxiliares: list-length**

A função "list-length" é um função que já está implementada na linguagem lisp. O nosso objetivo era com esta função obter o tamanho de uma lista e uma vez que já existiam funções implementadas, reutilizámos o código disponível.

#### **Funções auxiliares: max**

À semelhança da função "list-length", é uma função também já implementada em lisp em que apenas aproveitámos para utilizar código já disponível pelo lisp. Com esta função queríamos obter o máximo valor entre dois números.

#### **Funções auxiliares: *get-universal-time*

À semelhança das duas funçõe santeriores, também esta é uma função implementada em lisp disponível que aproveitámos para poder obter o tempo exato na altura em que se invoca esta função.

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
