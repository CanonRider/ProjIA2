;;;; jogo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto n�2 - Problema do Quatro
;;;; Autor: Jo�o Azevedo  n�180221119
;;;; Autor: Sara Carvalho  n�180221048


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


;;; 
;;; Seletores
;;; __________________________________________________________________________________________________

(defun criar-no(allTab &optional (profundidade 0) (noPai nil))
  "Criar estrutura de um no"
  (list allTab profundidade noPai))


(defun get-allTab(no)
  "Funcao que devolve o tabuleiro todo do no incluindo as pecs de reserva"
  (car no)) ;estado

(defun tabuleiro(no)
  "Funcao que devolve o tabuleiro do no sem pecs reserva"
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
  "Funcao que retorna T se a linha/coluna/diagonal não tiver espacos vazios e NIL caso tenha"
  (cond
   ((or (equal (first l) 0) (equal (second l) 0) (equal (third l) 0) (equal (fourth l) 0)) nil)
   (t)))

(defun repetidop(listaDest no)
  "Retorna T se no ja� existir na lista de destino"
  (cond
   ((null listaDest) nil)
   ((equal (car listaDest) no) t)
   (t (repetidop (cdr listaDest) no))));T caso car da lista seja igual ao no; nil caso nao encontre no igual na lista



;;; 
;;; Funcoes Auxiliares
;;; __________________________________________________________________________________________________

(defun juntar-listas(listaDest listaOrig)
  "Junta duas listas numa so e retorna essa mesma lista"
  (append listaDest listaOrig))


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


(defun conversor-coluna (letra)
  "Recebe uma letra equivalente a coluna e retorna um numero"
  (cond ((eq letra 'A) 1)
        ((eq letra 'B) 2)
        ((eq letra 'C) 3)
        ((eq letra 'D) 4)
        (t (format t "Coluna invalida"))))


;;; 
;;; Funcoes para Imprimir um Tabuleiro
;;; __________________________________________________________________________________________________

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
  (format t  "  4  |  ~A  ~A  ~A  ~A ~%~%~%~%Peças de Reserva:" (celula 1 4 (tabuleiro no)) (celula 2 4 (tabuleiro no)) (celula 3 4 (tabuleiro no)) (celula 4 4 (tabuleiro no)))
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


;;; 
;;; Funcoes para o Jogo
;;; __________________________________________________________________________________________________

; Teste: (operador 'C 1 '(PRETA QUADRADA ALTA CHEIA) (criar-no (tabuleiro-teste-A)))
;;allTab -> todo o tabuleiro, de jogo e reserva
(defun operador(coluna linha peca no)
  "Retorna todo o tabuleiro com peca alterada caso a posicao em que se va meter a peca esteja vazia"
  (cond
   ((or (< linha 1)(> linha 4)) (format t "Linha invalida"))
   ((not(casa-vaziap (conversor-coluna coluna) linha (tabuleiro no))) nil) 
   (t (imprime-tabuleiro (criar-no (list (substituir (conversor-coluna coluna) linha peca (tabuleiro no)) (remover-peca peca (reserva no))))))))

