;;;; algoritmo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto n�2 - Problema do Quatro
;;;; Autor: Jo�o Azevedo  n�180221119
;;;; Autor: Sara Carvalho  n�180221048

;;; no(estado, profundidade, nopai, avaliacao)

;; avaliar-no
;; + 1 para cada linha com 3 c�lulas v�zias para MAX
;; + 10 para cada 2 pacas com a mesma caracteristica na linha (2 c�lulas vazias) para MAX
;; + 50 para cada linha com 3 pecas com a mesma caracteristica na linha (�ltima linha vazia) para MAX
;; + 100 se existir 4 em linha com a mesma caracteristica para o MAX (MAX vence) -> POSSO USAR O VERIFICA-SOLUCAO-LISTA - SE FOR T, +100
;;
;; - 1 para cada linha com 3 c�lulas v�zias para MIN
;; - 10 para cada 2 pacas com a mesma caracteristica na linha (2 c�lulas vazias) para MIN
;; - 50 para cada linha com 3 pecas com a mesma caracteristica na linha (�ltima linha vazia) para MIN
;; - 100 se existir 4 em linha com a mesma caracteristica para o MIN (MIN vence) -> POSSO USAR O VERIFICA-SOLUCAO-LISTA - SE FOR T, -100

;(defun avaliar-no (no)
;  "Recebe um no e efetua os c�lculos de avaliacao"
;  (apply '+ (mapcar #' (lambda (linha)
;		(cond (()))))))

(defun teste()
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


(defun contar (tabuleiro)
  "Conta o numero de caracteristicas iguais num tabuleiro"
  ())


(defun orderna-filhos()); vai ordenar os nos pelo campo valor (ex heuristica)


;; Negamax com cortes alfabeta -> (negamax noRoot profundidade most-negative-fixnum most-positive-fixnum)
(defun negamax(no profundidade alfa beta)
  ""
  (let ((nos-filhos (ordena-nos (gerar-sucessores no profundidade)))
        (value most-negative-fixnum))
    (cond ((or (= profundidade 0) (equal (no-folha no profundidade) T)) (avaliar-no no))
          (t (loop for i from 0 to (- (list-length nos-filhos) 1) do
                (setq value (max value -(negamax i (- profundidade 1) -beta -alfa)))
                (setq alfa (max alfa value))
                (when (>= alfa beta) (return))))))) ; cut-off
        



;no-folha -> funcao booleana que verifica se o no � no terminal, ou seja se n�o tiver mais sucessores ou se for solu��o
(defun no-folha (no profundidade)
  "Retorna T se n� for um n� folha caso contr�rio retorna nil"
  (cond 
   ((null (reserva no)) (format t "aqui 3"))
   ((null (gerar-sucessores no profundidade)) (format t "aqui"))
   ((no-solucao no) (format t "aqui 2")); caso seja n� solu��o retorna T pois � folha.
   (T nil)))



(defun gerar-nos-posicao(x y no reserv)
  "Retorna numa lista todos os n�s filhos poss�veis numa dada posi��o (x,y)"
   (cond
    ((null reserv) nil)
    ((not(casa-vaziap x y (tabuleiro no))) nil)
    (t (cons (criar-no (operador x y (car reserv) (get-allTab no)) (+ (get-nivel no) 1) no nil) (gerar-nos-filhos x y no (cdr reserv))))));Faz lista com todos os filhos poss�veis do n� recebido numa dada posi��o, j� na forma de n�.



(defun gerar-sucessores(no profundidade &optional (x 1) (y 1))
  "Retorna lista dos filhos do no. Caso a reserva esteja vazia retorna nil"
  (cond
   ((null (reserva no)) nil)
   ((= profundidade 0) nil);Se profundidade � 0 ent�o chegou � profundidade m�xima pedida pelo user por isso n�o ir� expandir n�s e retorna nil.
   ((> x 4) (gerar-sucessores no profundidade 1 (+ y 1)));se coluna for maior que 4 passa para a linha a seguir.
   ((> y 4) nil);se a linha for inv�lida � porque j� n�o h� posi��es por avaliar. Retorna nil.
   ((not (casa-vaziap x y (tabuleiro no))) (gerar-sucessores no profundidade (+ x 1) y));se posi��o n�o estiver vazia, vai para a pr�xima coluna.
   (t (append (gerar-nos-posicao x y no (reserva no)) (gerar-sucessores no profundidade (+ x 1) y)))));faz lista de todos os filhos do n� recebido.





