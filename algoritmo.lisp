;;;; algoritmo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto n�2 - Problema do Quatro
;;;; Autor: Jo�o Azevedo  n�180221119
;;;; Autor: Sara Carvalho  n�180221048

;; no(estado, profundidade, nopai, avaliacao)

;; avaliar-no
;; + 1 para cada linha com 3 c�lulas v�zias para MAX
;; + 10 para cada 2 na linha com a mesma caracteristica (2 c�lulas vazias) para MAX
;; + 50 para cada linha com 3 em linha com a mesma caracteristica (�ltima linha vazia) para MAX
;; + 100 se existir 4 em linha com a mesma caracteristica para o MAX (MAX vence)
;;
;; - 1 para cada linha com 3 c�lulas v�zias para MIN
;; - 10 para cada 2 na linha com a mesma caracteristica (2 c�lulas vazias) para MIN
;; - 50 para cada linha com 3 em linha com a mesma caracteristica (�ltima linha vazia) para MIN
;; - 100 se existir 4 em linha com a mesma caracteristica para o MIN (MIN vence)

(defun avaliar-no (no jogador)
  "Recebe um n� e o tipo de jogador e efetua os c�lculos de avalia��o"
  (apply '+ (mapcar #' (lambda (linha)
							(cond (())))))
  
)

;; Negamax com cortes alfabeta
(defun negamax-cortesAlfaBeta(no profundidade alfa beta)
  ""
  (