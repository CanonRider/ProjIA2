;;;; algoritmo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto n�2 - Problema do Quatro
;;;; Autor: Jo�o Azevedo  n�180221119
;;;; Autor: Sara Carvalho  n�180221048

;(setf *print-level* 100)
;jogador1 -> 1
;jogador2 -> -1 

;; Negamax com cortes alfabeta - Chamada inicial -> (negamax noRoot profundidade most-negative-fixnum most-positive-fixnum)
(defun negamax(no profundidade jogador &optional (alfa most-negative-fixnum) (beta most-negative-fixnum))
  "Fun��o do algoritmo negamax" 
  (cond ((or (= profundidade 0) (no-folha no)) (no-resultado no jogador))
        (t (let ((nos-filhos (ordenar-nos (gerar-sucessores no profundidade)))
                 (value most-negative-fixnum))
             (negamax-aux no profundidade jogador alfa beta nos-filhos value)))))


(defun negamax-aux (no profundidade jogador alfa beta nos-filhos value)
  "Fun��o recursiva auxiliar do algoritmo negamax"
  (cond ((= (list-length nos-filhos) 1) (no-resultado nos-filhos jogador))
        (t (let ((no-nega (negamax (car nos-filhos) (- profundidade 1) (- jogador) (- beta) (- alfa))))
             (setq value (max value (- (get-valor no-nega))))
             (setq alfa (max alfa value))
             (cond ((>= alfa beta) no-nega) ;cut-off
                   (t (negamax-aux no profundidade jogador alfa beta (cdr nos-filhos) value)))))))


;;; ---FUN��ES AUXILIARES---

(defun no-folha (no)
  "Retorna T se n� for um n� folha caso contr�rio retorna nil"
  (cond 
   ((null (reserva no)) T)
   ((no-solucao no) T); caso seja n� solu��o retorna T pois � folha.
   (t nil)))


(defun ordenar-nos (lista)
  "Ordena os n�s da lista pelo seu valor"
  (if (> (list-length lista) 1)
      (sort lista #'> :key 'avaliar-no) 
    nil)
)



(defun no-resultado (no jogador)
  "Fun��o que retorna o n� resultado com o valor"
  (list (first no) (second no) (third no) (* (fourth no) jogador)))


