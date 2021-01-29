;;;; algoritmo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto n�2 - Problema do Quatro
;;;; Autor: Jo�o Azevedo  n�180221119
;;;; Autor: Sara Carvalho  n�180221048

;(setf *print-level* 10)
;jogador1 -> 1
;jogador2 -> -1 

;; Negamax com cortes alfabeta - Chamada inicial -> (negamax noRoot profundidade most-negative-fixnum most-positive-fixnum)
(defun negamax(no profundidade jogador tempo &optional (alfa most-negative-fixnum) (beta most-negative-fixnum) (tempoInicial (get-universal-time)) (cortes 0))
  "Fun��o do algoritmo negamax" 
  (cond ((or (= profundidade 0) (no-folha no) (>= (tempo-usado tempoInicial) tempo)) (resultado no jogador cortes))
        (t (let ((nos-filhos (ordenar-nos (gerar-sucessores no profundidade)))
                 (value most-negative-fixnum))
             (negamax-aux no profundidade jogador alfa beta nos-filhos value tempoInicial cortes)))))


(defun negamax-aux (no profundidade jogador alfa beta nos-filhos value tempoInicial cortes)
  "Fun��o recursiva auxiliar do algoritmo negamax"
  (cond ((= (list-length nos-filhos) 1) (resultado nos-filhos jogador tempoInicial cortes))
        (t (let ((no-nega (negamax (car nos-filhos) (- profundidade 1) (- jogador) tempoInicial (- beta) (- alfa))))
             (setq value (max value (- (get-valor no-nega))))
             (setq alfa (max alfa value))
             (cond ((>= alfa beta) (resultado no-nega jogador tempoInicial (+ cortes 1))) ;cut-off
                   (t (negamax-aux no profundidade jogador alfa beta (cdr nos-filhos) value tempoInicial cortes)))))))


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

(defun tempo-usado (tempoInicial)
  "Fun��o que retorna o tempo usado na jogada"
  (- (get-universal-time) tempoInicial))


(defun no-resultado (no jogador)
  "Fun��o que retorna o n� resultado com o valor"
  (list (first no) (second no) (third no) (* (fourth no) jogador)))


(defun resultado (no jogador tempo cortes)
  "Fun��o que retorna o n� resultado com as estat�sticas do valor, profundidade e cortes efetuados"
  (list (no-resultado no jogador) (list (get-valor (no-resultado no jogador)) (get-profundidade no) cortes)))