;;;; interact.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto nº2 - Problema do Quatro
;;;; Autor: João Azevedo  nº180221119
;;;; Autor: Sara Carvalho  nº180221048


;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                            INICALIZAÇÃO DO PROGRAMA
;;; _______________________________________________________________________________________________________________________________________________
(defun iniciar ()
  "Inicia o programa"
  (progn
    (format t "**************************************~%")
    (format t "*    BEM VINDO AO JOGO DO QUATRO!!   *~%")
    (format t "**************************************~%~%")
    (let* ((no-inicial (criar-no (get-tabuleiro_init)))
           (profundidade (ler-profundidade))
           (tempo-jogada (ler-tempo-jogada))
           (modo-jogo (ler-modo-jogo)))
      (if (= modo-jogo 1) ;se escolher humano vs computador
          (modo-humano-computador no-inicial profundidade)
        (format t "joga computador vs computador - ~A" modo-jogo)))))



;;; ---TABULEIRO INICIAL---

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



;;; ---FUNÇÕES DE LEITURA---

(defun ler-modo-jogo()
  "Permite fazer a leitura do modo de jogo"
  (progn
    (format t "Qual o modo de jogo? ~%")
    (format t "1- Humano vs computador ~%")
    (format t "2- Computador vs Computador ~%")
    (let ((resposta (read)))
      (cond ((= resposta 1) 1)
            (t 2)))))

(defun ler-jogador ()
  "Permite fazer a leitura do jogador que começa a jogar"
  (progn
    (format t "Que jogador começa? ~%")
    (format t "1- Humano ~%")
    (format t "2- Computador ~%")
    (let ((resposta (read)))
      (cond ((= resposta 1) 1)
            (t 2)))))
			
			
(defun ler-tempo-jogada()
  "Permite fazer a leitura do tempo que o computador tem para jogar"
  (progn
    (format t "Quanto tempo limite para o computador jogar (entre 1000 e 5000)?  ")
    (read)))

(defun ler-tempo-jogo()
  "Permite fazer leitura do tempo limite de jogo"
  (progn
    (format t "Tempo limite para o jogo? ")
    (read)))
		

(defun ler-profundidade()
  "Permite fazer a leitura da profundidade limite para o algoritmo negamax."
  (progn
    (format t "Qual a profundidade limite? ")
    (read)))


(defun ler-jogada()
  "Permite fazer a leitura da jogada do utilizador"
  (progn
    (format t "~%~%Qual a sua jogada? ~%")
    (format t "Insira a coluna e depois a linha (ex: (A 1) ): ")
    (let((coordenadas (read)))
      coordenadas)))

(defun ler-peca ()
  "Permite fazer a leitura da peça que o jogador quer jogar"
  (progn
    (format t "~%~% Escolha uma peça da lista de peças de reserva (ex: (PRETA QUADRADA ALTA CHEIA) ):  ")
    (let((peca (read)))
      peca)))

(defun mostra-tabuleiro (no)
  "Apresenta o jogo de forma legivel no ecra com o tabuleiro e as pecas de reserva"
  (format t  "~%~%     |  A  |  B  |  C  |  D   ~%")
  (format t  " ----|----------------------- ~%")
  (format t  "  1  |  ~A  ~A  ~A  ~A ~%" (celula 1 1 (tabuleiro no)) (celula 2 1 (tabuleiro no)) (celula 3 1 (tabuleiro no)) (celula 4 1 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  2  |  ~A  ~A  ~A  ~A ~%" (celula 1 2 (tabuleiro no)) (celula 2 2 (tabuleiro no)) (celula 3 2 (tabuleiro no)) (celula 4 2 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  3  |  ~A  ~A  ~A  ~A ~%" (celula 1 3 (tabuleiro no)) (celula 2 3 (tabuleiro no)) (celula 3 3 (tabuleiro no)) (celula 4 3 (tabuleiro no)))
  (format t  " ----| ~%")
  (format t  "  4  |  ~A  ~A  ~A  ~A ~%~%~%~%Peças de Reserva:~%" (celula 1 4 (tabuleiro no)) (celula 2 4 (tabuleiro no)) (celula 3 4 (tabuleiro no)) (celula 4 4 (tabuleiro no)))
  (format t "~{~A~^, ~}.~%" (reserva no)))



;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                              FUNÇÕES DAS JOGADAS
;;; _______________________________________________________________________________________________________________________________________________

(defvar *jogada*)

(defun jogada-humana (estado coordenadas peca)
  "Função que representa a jogada humana"
  (setq *jogada* (operador (first coordenadas) (second coordenadas) peca estado))
  (mostra-tabuleiro *jogada*)
)


;INICIAL: (negamax noRoot profundidade most-negative-fixnum most-positive-fixnum)
(defun jogada-computador (estado profundidade)
  "Função que representa a jogada do computador"
  ;(negamax no profundidade))
  (format t "~%_____________________________________________________________________________________________~%Jogada do Computador")
  (setq *jogada* (car (gerar-sucessores estado profundidade)))
  (mostra-tabuleiro *jogada*))



(defun modo-humano-computador (estado profundidade)
  ""
  (let ((jogador1 (ler-jogador)))
    (cond ((= jogador1 1) ;se escolher o humano
           (let* ((peca (ler-peca))
                  (coordenadas (ler-jogada)))
             ;(mostra-tabuleiro estado)
             (jogadas-modo1 (jogada-humana estado coordenadas peca) 2 profundidade)))
           ((= jogador1 2) (jogadas-modo1 (jogada-computador estado profundidade) 1 profundidade))
          (t (format t "Jogador inválido") (modo-humano-computador estado profundidade)))))

;jogador humano - 1
;jogador computador - 2
(defun jogadas-modo1 (estado jogador &optional (profundidade 0))
  ""
  (cond ((no-solucao estado) (imprime-tabuleiro estado) (format t "O JOGADOR %A GANHOUUUU!!!" jogador))
        (t (cond ((= jogador 1) 
                  (let* ((peca (ler-peca))
                         (coordenadas (ler-jogada)))
                    (jogadas-modo1 (jogada-humana estado coordenadas peca) 2 profundidade)))
                 (t (jogadas-modo1 (jogada-computador estado profundidade) 1))))))