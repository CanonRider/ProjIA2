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

(defun avaliar-no (no)
  "Recebe um no e efetua os c�lculos de avaliacao"
  (apply '+ (mapcar #' (lambda (linha)
		(cond (())))))
)

(defun contar (tabuleiro)
  "Conta o numero de caracteristicas iguais num tabuleiro"
  (
)

;no-folha -> funcao booleana que verifica se o no � no terminal, ou seja se n�o tiver mais sucessores ou se for solu��o
(defun no-folha (no))

;ordena-nos -> ordena os nos filhos pelo valor do avaliar-no
;sucessores



;; Negamax com cortes alfabeta -> (negamax noRoot profundidade most-negative-fixnum most-positive-fixnum)
(defun negamax(no profundidade alfa beta)
  ""
  (let ((nos-filhos (ordena-nos (gerar-sucessores no profundidade)))
        (value most-negative-fixnum))
    (cond ((or (= profundidade 0) (equal (no-folha no) T)) (avaliar-no no))
          (t (loop for i from 0 to (- (list-length nos-filhos) 1) do
                (setq value (max value -(negamax i (- profundidade 1) -beta -alfa)))
                (setq alfa (max alfa value))
                (when (>= alfa beta) (return))))))) ; cut-off
        




;;***********************************************************************************************************************************
;; TEM QUE SER ALTERADO, N�O EXISTE LISTAS DE ABERTOS NEM DE FECHADOS
(defun gerar-nos-filhos(x y no reserv profundidadePai listaAbertos listaFechados)
  "Retorna numa lista todas as possibilidades j� como n�s criados a partir da posi��o dada como argumento (x,y) "
   (cond
    ((null reserv) nil)
    ((not(casa-vaziap x y (tabuleiro no))) nil)
    ((or (repetidop listaAbertos (criar-no (operador x y (car reserv) (get-allTab no)) (+ profundidadePai 1) no)) (repetidop listaFechados (criar-no (operador x y (car reserv) (get-allTab no)) (+ profundidadePai 1) 0 no))) (gerar-nos-filhos x y no (cdr reserv) profundidadePai listaAbertos listaFechados));V� se o n� que vai ser criado j� est� na lista de abertos ou fechados.Caso esteja passa para a pe�a seguinte.
    (t (cons (criar-no (operador x y (car reserv) (get-allTab no)) (+ profundidadePai 1) 0 no) (gerar-nos-filhos x y no (cdr reserv) profundidadePai listaAbertos listaFechados)))));Faz lista com todos os filhos poss�veis do n� recebido numa dada posi��o, j� na forma de n�s.

;;x -> coluna de inicio- default 1
;;y -> linha de inicio - default 1
;;no -> no para expandir
(defun gerar-sucessores(no profundidade &optional (x 1) (y 1))
  "Retorna lista dos filhos do no. Caso a reserva esteja vazia retorna nil"
  (cond
   ((null (reserva no)) nil)
   ((> x 4) (gerar-sucessores no profundidade listaAbertos listaFechados 1 (+ y 1) ));se coluna for maior que 4 passa para a linha a seguir.
   ((> y 4) nil);se a linha for inv�lida � porque j� n�o h� posi��es por avaliar.Retorna nil.
   ((not (casa-vaziap x y (tabuleiro no))) (gerar-sucessores no profundidade listaAbertos listaFechados (+ x 1) y));se posi��o n�o estiver vazia, vai para a pr�xima coluna.
   (t (append (gerar-nos-filhos x y no (reserva no) profundidade listaAbertos listaFechados) (gerar-sucessores no profundidade listaAbertos listaFechados (+ x 1) y)))));faz lista de todos os filhos do n� recebido.
