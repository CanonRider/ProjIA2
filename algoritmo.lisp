;;;; algoritmo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto n�2 - Problema do Quatro
;;;; Autor: Jo�o Azevedo  n�180221119
;;;; Autor: Sara Carvalho  n�180221048



;; Negamax com cortes alfabeta - Chamada inicial -> (negamax noRoot profundidade most-negative-fixnum most-positive-fixnum)
(defun negamax(no profundidade alfa beta)
  ""
  (let ((nos-filhos (ordena-nos (gerar-sucessores no profundidade)))
        (value most-negative-fixnum))
    (cond ((or (= profundidade 0) (equal (no-folha no profundidade) T)) (avaliar-no no))
          (t (loop for i from 0 to (- (list-length nos-filhos) 1) do
                (setq value (max value -(negamax i (- profundidade 1) -beta -alfa)))
                (setq alfa (max alfa value))
                (when (>= alfa beta) (return))))))) ; cut-off
        






