;;;; jogo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto n∫2 - Problema do Quatro
;;;; Autor: Jo„o Azevedo  n∫180221119
;;;; Autor: Sara Carvalho  n∫180221048


;;; Tabuleiro teste e tabuleiro solucao
(defun tabuleiro-teste-A ()
  '(
    (
     ((branca quadrada alta oca) (preta quadrada baixa cheia) 0 (preta quadrada alta oca))
     ((branca redonda alta oca) (preta redonda alta oca) (branca redonda alta cheia) 0)
     (0 (preta redonda alta cheia) (preta redonda baixa cheia) 0)
     ((branca redonda baixa oca) (branca quadrada alta cheia) (preta redonda baixa oca) (branca quadrada baixa cheia))
     )
    (
     (preta quadrada alta cheia)
     (preta quadrada baixa oca)
     (branca redonda baixa cheia)
     (branca quadrada baixa oca)
     )
    )
)

(defun tabuleiro-teste-SOLUCAO ()
  '(
    (
     ((branca quadrada alta oca) (preta quadrada baixa cheia) 0 (preta quadrada alta oca))
     ((branca redonda alta oca) (preta redonda alta oca) (branca redonda alta cheia) (preta quadrada alta cheia))
     (0 (preta redonda alta cheia) (preta redonda baixa cheia) 0)
     ((branca redonda baixa oca) (branca quadrada alta cheia) (preta redonda baixa oca) (branca quadrada baixa cheia))
     )
    (
     (preta quadrada baixa oca)
     (branca redonda baixa cheia)
     (branca quadrada baixa oca)
     )
    )
)

(defun tabuleiro-testes()
'(
    (
     (1 1 1 1)
     (1 0 1 0)
     (0 1 1 1)
     (1 1 1 1)
     )
    (
     (preta quadrada alta cheia)
     (branca quadrada baixa oca)
     )
    )
)

(defun get-tabuleiro_init()
"Retorna um tabuleiro novo"
'(
    (
     (0 0 0 0)
     (0 0 0 0)
     (0 0 0 0)
     (0 0 0 0)
     )
    (
     (branca quadrada alta oca)
     (preta quadrada baixa cheia)
     (preta quadrada alta oca)
     (branca redonda alta oca)
     (preta redonda alta oca)
     (branca redonda alta cheia)
     (preta redonda alta cheia)
     (preta redonda baixa cheia)
     (branca redonda baixa oca)
     (branca quadrada alta cheia)
     (preta redonda baixa oca)
     (branca quadrada baixa cheia)
     (preta quadrada alta cheia)
     (preta quadrada baixa oca)
     (branca redonda baixa cheia)
     (branca quadrada baixa oca))))


;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                                SELETORES
;;; _______________________________________________________________________________________________________________________________________________

(defun criar-no(allTab &optional (profundidade 0) (noPai nil) (valor nil))
  "Criar estrutura de um no"
  (list allTab profundidade noPai valor))


(defun get-allTab(no)
  "Funcao que devolve o tabuleiro todo do no incluindo as pecs de reserva"
  (car no)) ;estado

(defun tabuleiro(no)
  "Funcao que devolve o tabuleiro do no sem pecas reserva"
 (car (get-allTab no)))

(defun reserva(no)
  "Funcao que devolve as pecas em reserva"
 (car(cdr (get-allTab no))))
	


(defun get-profundidade(no)
  "Retorna profundidade de um no"
  (second no))

(defun get-pai(no)
  "Retorna o no pai de um no"
  (fourth no))


(defun linha(index tab)
  "Retorna linha do tabuleiro"
  (cond
   ((= index 1) (first tab))
   ((= index 2) (second tab))
   ((= index 3) (third tab))
   ((= index 4) (fourth tab))
   ((format t "O indice nao esta correto, tente novamente!"))))


(defun coluna(index tab)
 "Retorna uma coluna do tabuleiro"
 (cond
  ((= index 1) (list (first(first tab)) (first(second tab)) (first(third tab)) (first(fourth tab))))
  ((= index 2) (list (second(first tab)) (second(second tab)) (second(third tab)) (second(fourth tab))))
  ((= index 3) (list (third(first tab)) (third(second tab)) (third(third tab)) (third(fourth tab))))
  ((= index 4) (list (fourth(first tab)) (fourth(second tab)) (fourth(third tab)) (fourth(fourth tab))))
  (t (format t "O indice nao esta correto, tente novamente!"))))


(defun celula(coluna linha tab)
  "Retorna elemento na posicao fornecida, no tabuleiro"
  (cond((or (< coluna 1) (> coluna 4) (< linha 1) (> linha 4)) (format t "A coluna ou a linha nao estao corretos, tente novamente!")))
  (linha linha (coluna coluna tab)))


(defun diagonal-1(tab)
  "Retorna diagonal do canto superior esquerdo ao canto inferior direito"
  (list (celula 1 1 tab) (celula 2 2 tab) (celula 3 3 tab) (celula 4 4 tab)))

(defun diagonal-2(tab)
  "Retorna diagonal do canto inferior esquerdo ao o canto superior direito"
  (list (celula 1 4 tab) (celula 2 3 tab) (celula 3 2 tab) (celula 4 1 tab))
)

(defun casa-vaziap(coluna linha tab)
  "Retorna t se a casa estiver vazia e nil caso contrario"
  (cond
   ((equal (celula coluna linha tab) 0) T)
   (t nil)))


(defun lista-completa (l)
  "Funcao que retorna T se a linha/coluna/diagonal n√£o tiver espacos vazios e NIL caso tenha"
  (cond
   ((or (equal (first l) 0) (equal (second l) 0) (equal (third l) 0) (equal (fourth l) 0)) nil)
   (t)))

(defun repetidop(listaDest no)
  "Retorna T se no ja° existir na lista de destino"
  (cond
   ((null listaDest) nil)
   ((equal (car listaDest) no) t)
   (t (repetidop (cdr listaDest) no))));T caso car da lista seja igual ao no; nil caso nao encontre no igual na lista


;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                                OPERADORES
;;; _______________________________________________________________________________________________________________________________________________

(defun remover-peca(peca reserv)
  "Remove uma peca da lista de reserva e retorna toda a lista sem a peca"
 (cond
   ((null reserv) nil)
   ((equal peca (car reserv)) (remover-peca peca (cdr reserv)))
   (t (cons (car reserv) (remover-peca peca (cdr reserv))))))


(defun substituir-posicao(index peca line)
  "Substitui uma posicao pela peca indicada e retorna a linha alterada"
  (cond 
   ((null line) nil)
   ((or (< index 1) (> index 4)) (format t "Indice invalido"))
   ((= index 1)(cons peca (cdr line)));verifica se index corresponde a 1 e caso seja salta uma posicao e adiciona o resto da linha

   ;adiciona ao primeiro elemento da linha o resultado da funcao com o index decrementado. Assim quando index for 1, entao era o index alvo do utilizador.
   (t (cons (car line) (substituir-posicao (- index 1) peca (cdr line))))))


(defun substituir(coluna linha peca tab)
  "Substitui peca por valor recebido e retorna tabuleiro alterado"
  (cond 
   ((or (< linha 1)(> linha 4)) (format t "Linha invalida"))
   ((or (< coluna 1)(> coluna 4)) (format t "Coluna invalida"))
   ((= linha 1) (cons (substituir-posicao coluna peca (car tab)) (cdr tab)))
   (t (cons (car tab) (substituir coluna (- linha 1) peca (cdr tab)))))) 


;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                             FUNCOES DE SOLUCAO
;;; _______________________________________________________________________________________________________________________________________________


(defun verifica-solucao-lista (l)
  "Funcao que verifica se a linha/coluna/diagonal tem pelo menos 1 caracteristica em comum e retorna T se tiver"
  (cond
   ((equal (lista-completa l) 'T)
    (cond
     ((and (equal (first (first l)) 'branca) (equal (first (second l)) 'branca) (equal (first (third l)) 'branca) (equal (first (fourth l)) 'branca)) t)
     ((and (equal (first (first l)) 'preta) (equal (first (second l)) 'preta) (equal (first (third l)) 'preta) (equal (first (fourth l)) 'preta)) t)
     ((and (equal (second (first l)) 'redonda) (equal (second (second l)) 'redonda) (equal (second (third l)) 'redonda) (equal (second (fourth l)) 'redonda)) t)
     ((and (equal (second (first l)) 'quadrada) (equal (second (second l)) 'quadrada) (equal (second (third l)) 'quadrada) (equal (second (fourth l)) 'quadrada)) t)
     ((and (equal (third (first l)) 'baixa) (equal (third (second l)) 'baixa) (equal (third (third l)) 'baixa) (equal (third (fourth l)) 'baixa)) t)
     ((and (equal (third (first l)) 'alta) (equal (third (second l)) 'alta) (equal (third (third l)) 'alta) (equal (third (fourth l)) 'alta)) t)
     ((and (equal (fourth (first l)) 'oca) (equal (fourth (second l)) 'oca) (equal (fourth (third l)) 'oca) (equal (fourth (fourth l)) 'oca)) t)
     ((and (equal (fourth (first l)) 'cheia) (equal (fourth (second l)) 'cheia) (equal (fourth (third l)) 'cheia) (equal (fourth (fourth l)) 'cheia)) t)
     (nil)))))


;Teste: (no-solucao (criar-no (tabuleiro-teste-SOLUCAO)))
(defun no-solucao (no)
  "Verifica se o tabuleiro recebido corresponde ao tabuleiro da solucao"
  (let ((tab (tabuleiro no)))
  (cond
   ((or 
     (verifica-solucao-lista (linha 1 tab)); retorna T ou NIL
     (verifica-solucao-lista (linha 2 tab))
     (verifica-solucao-lista (linha 3 tab))
     (verifica-solucao-lista (linha 4 tab))
     (verifica-solucao-lista (coluna 1 tab))
     (verifica-solucao-lista (coluna 2 tab))
     (verifica-solucao-lista (coluna 3 tab))
     (verifica-solucao-lista (coluna 4 tab))
     (verifica-solucao-lista (diagonal-1 tab))
     (verifica-solucao-lista (diagonal-2 tab))) (imprime-tabuleiro no) (format t "~%GANHOU O JOGO!!!~%~%"))))
)


;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                              FUNCOES PARA IMPRIMIR
;;; _______________________________________________________________________________________________________________________________________________

;Teste: (imprime-jogo (criar-no (tabuleiro-teste-A)))
(defun imprime-jogo (no)
  "Apresenta o jogo de forma legivel no ecra com o tabuleiro e as pecas de reserva"
  (format t  "~%     |  A  |  B  |  C  |  D   ~%")
  (format t  " ----|----------------------- ~%")
  (format t  "  1  |  ~A  ~A  ~A  ~A ~%" (celula 1 1 (tabuleiro no)) (celula 2 1 (tabuleiro no)) (celula 3 1 (tabuleiro no)) (celula 4 1 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  2  |  ~A  ~A  ~A  ~A ~%" (celula 1 2 (tabuleiro no)) (celula 2 2 (tabuleiro no)) (celula 3 2 (tabuleiro no)) (celula 4 2 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  3  |  ~A  ~A  ~A  ~A ~%" (celula 1 3 (tabuleiro no)) (celula 2 3 (tabuleiro no)) (celula 3 3 (tabuleiro no)) (celula 4 3 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  4  |  ~A  ~A  ~A  ~A ~%~%~%~%Pe√ßas de Reserva:" (celula 1 4 (tabuleiro no)) (celula 2 4 (tabuleiro no)) (celula 3 4 (tabuleiro no)) (celula 4 4 (tabuleiro no)))
  (reserva no)
)

;Teste: (imprime-tabuleiro (criar-no (tabuleiro-teste-A)))
(defun imprime-tabuleiro (no)
  "Apresenta so o tabuleiro do jogo de forma legivel no ecra"
  (format t  "~%     |  A  |  B  |  C  |  D   ~%")
  (format t  " ----|----------------------- ~%")
  (format t  "  1  |  ~A  ~A  ~A  ~A ~%" (celula 1 1 (tabuleiro no)) (celula 2 1 (tabuleiro no)) (celula 3 1 (tabuleiro no)) (celula 4 1 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  2  |  ~A  ~A  ~A  ~A ~%" (celula 1 2 (tabuleiro no)) (celula 2 2 (tabuleiro no)) (celula 3 2 (tabuleiro no)) (celula 4 2 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  3  |  ~A  ~A  ~A  ~A ~%" (celula 1 3 (tabuleiro no)) (celula 2 3 (tabuleiro no)) (celula 3 3 (tabuleiro no)) (celula 4 3 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  4  |  ~A  ~A  ~A  ~A ~%~%" (celula 1 4 (tabuleiro no)) (celula 2 4 (tabuleiro no)) (celula 3 4 (tabuleiro no)) (celula 4 4 (tabuleiro no)))
)



;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                                FUNCOES AUXILIARES
;;; _______________________________________________________________________________________________________________________________________________

(defun juntar-listas(listaDest listaOrig)
  "Junta duas listas numa so e retorna essa mesma lista"
  (append listaDest listaOrig))

;no-folha -> funcao booleana que verifica se o no È no terminal, ou seja se n„o tiver mais sucessores ou se for soluÁ„o
(defun no-folha (no)
  "Retorna T se nÛ for um nÛ folha caso contr·rio retorna nil"
  (cond 
   ((null (reserva no)) T)
   ((no-solucao no) T); caso seja nÛ soluÁ„o retorna T pois È folha.
   (T nil)))


;respons·vel por transformar uma letra em n˙mero
(defun conversor-coluna-ln (letra)
  "Recebe uma letra equivalente a coluna e retorna um numero"
  (cond ((eq letra 'A) 1)
        ((eq letra 'B) 2)
        ((eq letra 'C) 3)
        ((eq letra 'D) 4)
        (t nil)))

;respons·vel por transformar um n˙mero em letra
(defun conversor-coluna-nl(numero)
"Recebe um numero equivalente a coluna e retorna uma letra"
  (cond ((= numero 1) 'A)
        ((= numero 2) 'B)
        ((= numero 3) 'C)
        ((= numero 4) 'D)
        (t nil)))



;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                             FUNCOES PARA AVALIAR
;;; _______________________________________________________________________________________________________________________________________________	


;; Atribuicao de pontos
;; + 1 para cada linha com 3 celulas vazias para MAX
;; + 10 para cada 2 pecas com a mesma caracteristica na linha (2 celulas vazias) para MAX
;; + 100 para cada linha com 3 pecas com a mesma caracteristica na linha (ultima linha vazia) para MAX
;; + 2000 se existir 4 em linha com a mesma caracteristica para o MAX (MAX vence) -> POSSO USAR O VERIFICA-SOLUCAO-LISTA - SE FOR T, +2000
;;
;; - 1 para cada linha com 3 celulas vazias para MIN
;; - 10 para cada 2 pacas com a mesma caracteristica na linha (2 celulas vazias) para MIN
;; - 100 para cada linha com 3 pecas com a mesma caracteristica na linha (ultima linha vazia) para MIN
;; - 2000 se existir 4 em linha com a mesma caracteristica para o MIN (MIN vence) -> POSSO USAR O VERIFICA-SOLUCAO-LISTA - SE FOR T, -2000

; Teste: (caracteristicas-lista '((branca quadrada alta oca) (preta quadrada baixa cheia) 0 (preta quadrada alta oca)))
; Resultado: (branca quadrada alta oca preta quadrada baixa cheia preta quadrada alta oca)
(defun caracteristicas-lista (lista &optional (caracteristicas '()))
  "Retorna uma lista com todas as caracteristicas de uma linha"
  (cond ((null lista) caracteristicas)
        ((numberp (car lista)) (caracteristicas-lista (cdr lista) caracteristicas))
        (t (caracteristicas-lista (cdr lista) (append caracteristicas (car lista))))))



; Teste: (conta-caracteristicas-lista '(branca quadrada alta oca preta quadrada baixa cheia preta quadrada alta oca))
; Resultado: 1 branca, 2 preta, 3 quadrada, 0 redonda, 2 alta, 1 baixa, 1 cheia, 2 oca
(defun conta-caracteristicas-lista(lista &optional (counterBranca 0) (counterPreta 0) (counterQuadrada 0) (counterRedonda 0) (counterAlta 0) (counterBaixa 0) (counterCheia 0) (counterOca 0))
  "FunÁ„o que recebe uma lista com as caracteristicas e retorna uma lista com o numero de brancas, pretas, quadradas, redondas, altas, baixas, cheias e ocas"
  (cond ((null lista) (list counterBranca counterPreta counterQuadrada counterRedonda counterAlta counterBaixa counterCheia counterOca))
        ((equal (car lista) 'branca) (conta-caracteristicas-lista (cdr lista) (+ counterBranca 1) counterPreta counterQuadrada counterRedonda counterAlta counterBaixa counterCheia counterOca))
        ((equal (car lista) 'preta) (conta-caracteristicas-lista (cdr lista) counterBranca (+ counterPreta 1) counterQuadrada counterRedonda counterAlta counterBaixa counterCheia counterOca))
        ((equal (car lista) 'quadrada) (conta-caracteristicas-lista (cdr lista) counterBranca counterPreta (+ counterQuadrada 1) counterRedonda counterAlta counterBaixa counterCheia counterOca))
        ((equal (car lista) 'redonda) (conta-caracteristicas-lista (cdr lista) counterBranca counterPreta counterQuadrada (+ counterRedonda 1) counterAlta counterBaixa counterCheia counterOca))
        ((equal (car lista) 'alta) (conta-caracteristicas-lista (cdr lista) counterBranca counterPreta counterQuadrada counterRedonda (+ counterAlta 1) counterBaixa counterCheia counterOca))
        ((equal (car lista) 'baixa) (conta-caracteristicas-lista (cdr lista) counterBranca counterPreta counterQuadrada counterRedonda counterAlta (+ counterBaixa 1) counterCheia counterOca))
        ((equal (car lista) 'cheia) (conta-caracteristicas-lista (cdr lista) counterBranca counterPreta counterQuadrada counterRedonda counterAlta counterBaixa (+ counterCheia 1) counterOca))
        ((equal (car lista) 'oca) (conta-caracteristicas-lista (cdr lista) counterBranca counterPreta counterQuadrada counterRedonda counterAlta counterBaixa counterCheia (+ counterOca 1)))
        (t (conta-caracteristicas-lista (cdr lista) counterBranca counterPreta counterQuadrada counterRedonda counterAlta counterBaixa counterCheia counterOca)))
)


; Teste: (conta-linhas (tabuleiro (criar-no (tabuleiro-teste-A))))
; resultado: ((1 2 3 0 2 1 1 2) (2 1 0 3 3 0 1 2) (0 2 0 2 1 1 2 0) (3 1 2 2 1 3 2 2))
(defun conta-linhas (tabuleiro)
  "Retorna uma lista com listas das contas das caracteristicas de cada linha"
  (list (conta-caracteristicas-lista (caracteristicas-lista (linha 1 tabuleiro))) 
        (conta-caracteristicas-lista (caracteristicas-lista (linha 2 tabuleiro))) 
        (conta-caracteristicas-lista (caracteristicas-lista (linha 3 tabuleiro))) 
        (conta-caracteristicas-lista (caracteristicas-lista (linha 4 tabuleiro)))))


; Teste: (conta-colunas (tabuleiro (criar-no (tabuleiro-teste-A))))
; resultado: ((3 0 1 2 2 1 0 3) (1 3 2 2 3 1 3 1) (1 2 0 3 1 2 2 1) (1 1 2 0 1 1 1 1))
(defun conta-colunas (tabuleiro)
  "Retorna uma lista com listas das contas das caracteristicas de cada coluna"
  (list (conta-caracteristicas-lista (caracteristicas-lista (coluna 1 tabuleiro))) 
        (conta-caracteristicas-lista (caracteristicas-lista (coluna 2 tabuleiro))) 
        (conta-caracteristicas-lista (caracteristicas-lista (coluna 3 tabuleiro))) 
        (conta-caracteristicas-lista (caracteristicas-lista (coluna 4 tabuleiro)))))


; Teste: (conta-diagonal-1 (tabuleiro (criar-no (tabuleiro-teste-A))))
; resultado: (2 2 2 2 2 2 2 2)
(defun conta-diagonal-1 (tabuleiro)
  "Retorna uma lista das contas das caracteristicas da diagonal 1"
  (conta-caracteristicas-lista (caracteristicas-lista (diagonal-1 tabuleiro)))) 
        

; Teste: (conta-diagonal-2 (tabuleiro (criar-no (tabuleiro-teste-A))))
; resultado: (2 2 1 3 3 1 2 2)
(defun conta-diagonal-2 (tabuleiro)
  "Retorna uma lista das contas das caracteristicas da diagonal 2"
  (conta-caracteristicas-lista (caracteristicas-lista (diagonal-2 tabuleiro))))
        

; Teste: (calcular-valor-linhas (criar-no (tabuleiro-teste-A)))
; resultado: 310
(defun calcular-valor-linhas (no &optional (index 1) (valor 0) (valorTotal 0))
  "Retorna os pontos totais das linha do tabuleiro"
  (let ((l (nth (- index 1) (conta-linhas (tabuleiro no)))))
    (cond ((= index 5) valorTotal)
          ((= (apply 'max l) 3) (calcular-valor-linhas no (+ index 1) (+ valor 100) (+ valorTotal 100)))
          ((= (apply 'max l) 2) (calcular-valor-linhas no (+ index 1) (+ valor 10) (+ valorTotal 10)))
          ((= (apply 'max l) 1) (calcular-valor-linhas no (+ index 1) (+ valor 1) (+ valorTotal 1)))
          (t nil))))



; Teste: (calcular-valor-colunas (criar-no (tabuleiro-teste-A)))
; resultado: 310
(defun calcular-valor-colunas (no &optional (index 1) (valor 0) (valorTotal 0))
  "Retorna os pontos totais das colunas do tabuleiro"
  (let ((l (nth (- index 1) (conta-colunas (tabuleiro no)))))
    (cond ((= index 5) valorTotal)
          ((= (apply 'max l) 3) (calcular-valor-colunas no (+ index 1) (+ valor 100) (+ valorTotal 100)))
          ((= (apply 'max l) 2) (calcular-valor-colunas no (+ index 1) (+ valor 10) (+ valorTotal 10)))
          ((= (apply 'max l) 1) (calcular-valor-colunas no (+ index 1) (+ valor 1) (+ valorTotal 1)))
          (t nil))))



; Teste: (calcular-valor-diagonal-1 (criar-no (tabuleiro-teste-A)))
; resultado: 10
(defun calcular-valor-diagonal-1 (no)
  "Retorna os pontos da diagonal 1 do tabuleiro"
  (let ((l (conta-diagonal-1 (tabuleiro no)))
        (valorTotal 0))
    (cond ((= (apply 'max l) 3) (+ valorTotal 100))
          ((= (apply 'max l) 2) (+ valorTotal 10))
          ((= (apply 'max l) 1) (+ valorTotal 1))
          (t nil))))


; Teste: (calcular-valor-diagonal-2 (criar-no (tabuleiro-teste-A)))
; resultado: 100
(defun calcular-valor-diagonal-2 (no)
  "Retorna os pontos da diagonal 2 do tabuleiro"
  (let ((l (conta-diagonal-2 (tabuleiro no)))
        (valorTotal 0))
    (cond ((= (apply 'max l) 3) (+ valorTotal 100))
          ((= (apply 'max l) 2) (+ valorTotal 10))
          ((= (apply 'max l) 1) (+ valorTotal 1))
          (t nil))))


; Teste: (avaliar-no (criar-no (tabuleiro-teste-A)))
; resultado: 
(defun avaliar-no (no)
  "Recebe um no e efetua os calculos de avaliacao"
  (cond ((null no) nil)
        ((no-solucao no) 2000)
        (t (+ (calcular-valor-linhas no) (calcular-valor-colunas no) (calcular-valor-diagonal-1 no) (calcular-valor-diagonal-2 no))))
)



;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                               SUCESSORES
;;; _______________________________________________________________________________________________________________________________________________

(defun gerar-nos-posicao(x y no reserv)
  "Retorna numa lista todos os nÛs filhos possÌveis numa dada posiÁ„o (x,y)"
  (cond
    ((null reserv) nil)
    ((not(casa-vaziap x y (tabuleiro no))) nil)
    (t (cons (criar-no (operador (conversor-coluna-nl x) y (car reserv) (get-allTab no)) (+ (get-profundidade no) 1) no nil) (gerar-nos-posicao x y no (cdr reserv))))));Faz lista com todos os filhos possÌveis do nÛ recebido numa dada posiÁ„o, j· na forma de nÛ.



(defun gerar-sucessores(no profundidade &optional (x 'A) (y 1))
  "Retorna lista dos filhos do no. Caso a reserva esteja vazia retorna nil"
  (let
      (col_num (conversor-coluna-ln x))

    (cond
     ((null (reserva no)) nil)
     ((= profundidade 0) nil);Se profundidade È 0 ent„o chegou ‡ profundidade m·xima pedida pelo user por isso n„o ir· expandir nÛs e retorna nil.
     ((> (col_num) 4) (gerar-sucessores no profundidade 'A (+ y 1)));se coluna for maior que 4 passa para a linha a seguir.
     ((> y 4) nil);se a linha for inv·lida È porque j· n„o h· posiÁıes por avaliar. Retorna nil.
     ((not (casa-vaziap col_num y (tabuleiro no))) (gerar-sucessores no profundidade (conversor-coluna-nl (+ (col_num) 1)) y));se posiÁ„o n„o estiver vazia, vai para a prÛxima coluna.
     (t (append (gerar-nos-posicao (col_num) y no (reserva no)) (gerar-sucessores no profundidade (conversor-coluna-nl (+ (col_num) 1)) y))))));faz lista de todos os filhos do nÛ recebido.





;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                             FUNCOES PARA O JOGO
;;; _______________________________________________________________________________________________________________________________________________

; Teste: (operador 'C 1 '(PRETA QUADRADA ALTA CHEIA) (criar-no (tabuleiro-teste-A)))
;;allTab -> todo o tabuleiro, de jogo e reserva
(defun operador(coluna linha peca no)
  "Retorna todo o tabuleiro com peca alterada caso a posicao em que se va meter a peca esteja vazia"
  (cond
   ((or (< linha 1)(> linha 4)) (format t "Linha invalida"))
   ((not(casa-vaziap (conversor-coluna-ln coluna) linha (tabuleiro no))) nil) 
   (t (imprime-tabuleiro (criar-no (list (substituir (conversor-coluna-ln coluna) linha peca (tabuleiro no)) (remover-peca peca (reserva no))))))))

