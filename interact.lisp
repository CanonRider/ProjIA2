;;;; projeto.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto nº1 - Problema do Quatro
;;;; Autor: João Azevedo  nº180221119
;;;; Autor: Sara Carvalho  nº180221048


;;; Inicialização do programa
;; iniciar
(defun iniciar ()
"Permite iniciar o programa, fazendo a leitura do teclado do estado inicial e do algoritmo a utilizar para procurar a solução (neste caso a procura na profundidade ou na largura)"
  (let*(
		(modo_jogo (ler-modo-jogo))
		(jogador_init (ler-jogador)) ; só se o modo for 1
        (profundidade (ler-profundidade))
		(tempo_jogada (ler-tempo-jogada));;Caso seja o modo 1 | Falta acrescentar no negamax
		(tempo_jogo (ler-tempo-jogo)); Caso seja modo 2
		(no_init (criar-no (get-tabuleiro_init)))
		(alfa -9999999999)
		(beta 9999999999))
	(funcall negamax no profundidade alfa beta)))

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


(defun ler-jogador ()
  "Permite fazer a leitura do jogador que começa a jogar"
  (progn
    (format t "Que jogador começa? ~%")
    (format t "1- Humano ~%")
    (format t "2- Computador ~%")
    (let ((resposta (read)))
      (cond ((= resposta 1) 1)
            (t 2)))))

(defun ler-modo-jogo()
  "Permite fazer a leitura do modo de jogo"
  (progn
    (format t "Qual o modo de jogo? ~%")
    (format t "1- Humano vs computador ~%")
    (format t "2- Computador vs Computador ~%")
    (let ((resposta (read)))
      (cond ((= resposta 1) 1)
            (t 2)))))
			
			
(defun ler-tempo-jogada()
	"Permite fazer a leitura do tempo que o computador tem para jogar"
      (progn
    (format t "Quanto tempo limite para o computador jogar? (entre 1000 e 5000) ~%")
    (read)
    ))

(defun ler-tempo-jogo()
	"Permite fazer leitura do tempo limite de jogo"
		(progn
    (format t "Tempo limite para o jogo? ~%")
    (read)
    ))
		

;; ler-profundidade
(defun ler-profundidade()
"Permite fazer a leitura da profundidade limite para o algoritmo negamax."
    (progn
    (format t "Qual a profundidade limite? ~%")
    (read)
    ))

