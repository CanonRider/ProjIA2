;;;; algoritmo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto nº2 - Problema do Quatro
;;;; Autor: João Azevedo  nº180221119
;;;; Autor: Sara Carvalho  nº180221048



;; Negamax com cortes alfabeta - Chamada inicial -> (negamax noRoot profundidade most-negative-fixnum most-positive-fixnum)
(defun negamax(no profundidade alfa beta)
  ""
  (let ((nos-filhos (ordena-nos (gerar-sucessores no profundidade)))
        (value most-negative-fixnum))
    (cond ((or (= profundidade 0) (equal (no-folha no) T)) (get-valor no))
          (t (loop for i from 0 to (- (list-length nos-filhos) 1) do
                (setq value (max value -(negamax i (- profundidade 1) (- beta) (- alfa))))
                (setq alfa (max alfa value))
                (when (>= alfa beta) (return))))))) ; cut-off




;;; ---FUNÇÕES AUXILIARES---

(defun no-folha (no)
  "Retorna T se nó for um nó folha caso contrário retorna nil"
  (cond 
   ((null (reserva no)) T)
   ((no-solucao no) T); caso seja nó solução retorna T pois é folha.
   (T nil)))


(defun orderna-nos (lista)
  "Ordena os nós da lista pelo seu valor"
  (let ((valor (get-valor (car lista))))
    (cond ((null lista) "lista ordenada")
          (t (sort lista #'> :key valor))))
)



