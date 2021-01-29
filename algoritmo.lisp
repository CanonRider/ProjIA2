;;;; algoritmo.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto nº2 - Problema do Quatro
;;;; Autor: João Azevedo  nº180221119
;;;; Autor: Sara Carvalho  nº180221048

;(setf *print-level* 10)
;jogador1 -> 1
;jogador2 -> -1 

;; Negamax com cortes alfabeta - Chamada inicial -> (negamax noRoot profundidade most-negative-fixnum most-positive-fixnum)
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


;;; ---FUNÇÕES AUXILIARES---

(defun no-folha (no)
  "Retorna T se nó for um nó folha caso contrário retorna nil"
  (cond 
   ((null (reserva no)) T)
   ((no-solucao no) T); caso seja nó solução retorna T pois é folha.
   (t nil)))


(defun ordenar-nos (lista)
  "Ordena os nós da lista pelo seu valor"
  (if (> (list-length lista) 1)
      (sort lista #'> :key 'avaliar-no) 
    nil)
)

(defun tempo-usado (tempoInicial)
  "Função que retorna o tempo usado na jogada"
  (- (get-universal-time) tempoInicial))


(defun no-resultado (no jogador)
  "Função que retorna o nó resultado com o valor"
  (list (first no) (second no) (third no) (* (fourth no) jogador)))


(defun resultado (no jogador tempo cortes)
  "Função que retorna o nó resultado com as estatísticas do valor, profundidade e cortes efetuados"
  (list (no-resultado no jogador) (list (tempo-usado tempo) (get-valor (no-resultado no jogador)) (get-profundidade no) cortes)))