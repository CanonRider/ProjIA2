;;;; interact.lisp
;;;; Disciplina de IA - 2020 / 2021
;;;; Projeto n�2 - Problema do Quatro
;;;; Autor: Jo�o Azevedo  n�180221119
;;;; Autor: Sara Carvalho  n�180221048


;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                            INICIALIZA��O DO PROGRAMA
;;; _______________________________________________________________________________________________________________________________________________
(defun iniciar ()
  "Inicia o programa"
  (progn
    (format t "**************************************~%")
    (format t "*    BEM VINDO AO JOGO DO QUATRO!!   *~%")
    (format t "**************************************~%~%")
    (let* ((no-inicial (criar-no (get-tabuleiro_init)))
           (profundidade (ler-profundidade))
           ;(tempo-jogada (ler-tempo-jogada))
           (modo-jogo (ler-modo-jogo)))
      (if (= modo-jogo 1) ;se escolher humano vs computador
          (modo-humano-computador no-inicial profundidade)
        (modo-computador-computador no-inicial profundidade)))))



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



;;; ---FUN�OES DE LEITURA---

(defun ler-profundidade()
  "Permite fazer a leitura da profundidade limite para o algoritmo negamax."
  (progn
    (format t "Qual a profundidade limite? ")
    (read)))

(defun ler-tempo-jogada()
  "Permite fazer a leitura do tempo que o computador tem para jogar"
  (progn
    (format t "~%Quanto tempo limite para o computador jogar (entre 1000 e 5000)?  ")
    (read)))

(defun ler-modo-jogo()
  "Permite fazer a leitura do modo de jogo"
  (progn
    (format t "~%Qual o modo de jogo? ~%")
    (format t "1- Humano vs Computador ~%")
    (format t "2- Computador vs Computador ~%")
    (format t "Op��o: ")
    (let ((resposta (read)))
      (cond ((= resposta 1) 1)
            (t 2)))))


(defun ler-jogador ()
  "Permite fazer a leitura do jogador que come�a a jogar"
  (progn
    (format t "~%Que jogador come�a? ~%")
    (format t "1- Humano ~%")
    (format t "2- Computador ~%")
    (format t "Op��o: ")
    (let ((resposta (read)))
      (cond ((= resposta 1) 1)
            (t 2)))))


(defun ler-computador ()
  "Permite fazer a leitura do computador que come�a a jogar"
  (progn
    (format t "~%Que computador come�a? ~%")
    (format t "1- Computador 1 ~%")
    (format t "2- Computador 2 ~%")
    (format t "Op��o: ")
    (let ((resposta (read)))
      (cond ((= resposta 1) 1)
            (t 2)))))
			
		

(defun ler-tempo-jogo()
  "Permite fazer leitura do tempo limite de jogo"
  (progn
    (format t "Tempo limite para o jogo? ")
    (read)))
		

(defun ler-jogada()
  "Permite fazer a leitura da jogada do utilizador"
  (progn
    (format t "~%~%Qual a sua jogada? ~%")
    (format t "Insira a coluna e depois a linha (ex: (A 1) ): ")
    (let((coordenadas (read)))
      coordenadas)))

(defun ler-peca ()
  "Permite fazer a leitura da pe�a que o jogador quer jogar"
  (progn
    (format t "~%~% Escolha uma pe�a da lista de pe�as de reserva (ex: (PRETA QUADRADA ALTA CHEIA) ):  ")
    (let((peca (read)))
      peca)))

(defun mostra-tabuleiro (no)
  "Apresenta o jogo de forma legivel no ecra com o tabuleiro e as pecas de reserva"
  (progn
    (format t "~%~%_______________TABULEIRO_______________~%")
    (imprime-jogo no)
  ))


;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                              FUN�OES DAS JOGADAS
;;; _______________________________________________________________________________________________________________________________________________

(defvar *jogada*)

(defun jogada-humana (estado coordenadas peca)
  "Fun��o que representa a jogada humana"
  (setq *jogada* (operador (first coordenadas) (second coordenadas) peca estado))
  (mostra-tabuleiro *jogada*)
)


(defun jogada-computador (estado profundidade jogador tempo-jogada)
  "Fun��o que representa a jogada do computador"
  (format t "~%~% ******* Jogada do Computador *******")
  (cond ((= jogador 1) (setq *jogada* (negamax estado profundidade 1 tempo-jogada)))
         (t (setq *jogada* (negamax estado profundidade -1 tempo-jogada))))
  (mostra-tabuleiro (car *jogada*))
  (imprime-estatisticas *jogada*)
  (escrever-log))

(defun troca-jogador (jogador)
  "Fun��o auxiliar que troca o jogador"
  (cond ((= jogador 1) 2)
        (t 1)))



;;; ---HUMANO VS COMPUTADOR---

(defun modo-humano-computador (estado profundidade)
  "Fun��o que representa o modo de jogo Humano vs Computador"
  (let ((jogador1 (ler-jogador)))
    (cond ((= jogador1 1) ;se escolher o humano
           (mostra-tabuleiro estado)
           (let* ((peca (ler-peca))
                  (coordenadas (ler-jogada)))
             (jogada-humana estado coordenadas peca)
             (jogadas-modo1 *jogada* 2 tempo-jogada profundidade)))
           ((= jogador1 2) (jogada-computador estado profundidade 1) (jogadas-modo1 (car *jogada*) 1 profundidade))
          (t (format t "Jogador inv�lido") (modo-humano-computador estado profundidade)))))

;jogador humano - 1
;jogador computador - 2
(defun jogadas-modo1 (estado jogador &optional (profundidade 0))
  "Fun��o recursiva que representa as jogadas do modo Humano vs Computador"
  (cond ((no-solucao estado) (format t "~%~%O JOGADOR ~d GANHOUUUU!!!~%~%" (troca-jogador jogador)) (imprime-tabuleiro estado) )
        (t (cond ((= jogador 1) 
                  (let* ((peca (ler-peca))
                         (coordenadas (ler-jogada)))
                    (jogada-humana estado coordenadas peca)
                    (jogadas-modo1 *jogada* 2 profundidade)))
                 (t (jogada-computador estado profundidade 2) (jogadas-modo1 (car *jogada*) 1 profundidade))))))



;;; ---COMPUTADOR VS COMPUTADOR---

(defun modo-computador-computador (estado profundidade)
  "Fun��o que representa o modo de jogo Computador vs Computador"
  (let ((jogador1 (ler-computador)))
    (cond ((= jogador1 1) ;se escolher o computador 1
           (jogada-computador estado profundidade jogador1) 
           (jogadas-modo2 (car *jogada*) 2 profundidade))
          ((= jogador1 2) (jogada-computador estado profundidade 1) (jogadas-modo2 (car *jogada*) 1 profundidade))
          (t (format t "Jogador inv�lido") (modo-computador-computador estado profundidade)))))

;jogador computador1 - 1
;jogador computador2 - 2
(defun jogadas-modo2 (estado jogador profundidade)
  "Fun��o recursiva que representa as jogadas do modo Computador vs Computador"
  (cond ((no-solucao estado) (format t "~%~%O COMPUTADOR ~d GANHOUUUU!!!~%~%" (troca-jogador jogador)) (imprime-tabuleiro estado))
        (t (cond ((= jogador 1) 
                  (jogada-computador estado profundidade jogador) 
                  (jogadas-modo2 (car *jogada*) 2 profundidade))
                 (t (jogada-computador estado profundidade jogador) (jogadas-modo2 (car *jogada*) 1 profundidade))))))
     

            


;;; _______________________________________________________________________________________________________________________________________________
;;;
;;;                                                                  ESTAT�STICAS
;;; _______________________________________________________________________________________________________________________________________________

(defun imprime-estatisticas (no)
  "Apresenta as estat�sticas de cada jogada no ecr�"
  (progn
    (format t "~%~%______________ESTAT�STICAS_____________~%~%")
    (format t "Valor do n�: ~d" (first (second no)))
    (format t "~%Profundidade do n�: ~d" (second (second no)))
    (format t "~%Cortes efetuados: ~d" (third (second no)))
    (format t "~%~%_______________________________________")))



(defun escreve-tabuleiro (no &optional (stream t))
  "Escreve o tabuleiro no ficheiro"
  (format stream  "~%     |  A  |  B  |  C  |  D   ~%")
  (format stream  " ----|----------------------- ~%")
  (format stream  "  1  |  ~A  ~A  ~A  ~A ~%" (celula 1 1 (tabuleiro no)) (celula 2 1 (tabuleiro no)) (celula 3 1 (tabuleiro no)) (celula 4 1 (tabuleiro no)))
  (format stream  " ----| ~%")
  (format stream  "  2  |  ~A  ~A  ~A  ~A ~%" (celula 1 2 (tabuleiro no)) (celula 2 2 (tabuleiro no)) (celula 3 2 (tabuleiro no)) (celula 4 2 (tabuleiro no)))
  (format stream  " ----| ~%")
  (format stream  "  3  |  ~A  ~A  ~A  ~A ~%" (celula 1 3 (tabuleiro no)) (celula 2 3 (tabuleiro no)) (celula 3 3 (tabuleiro no)) (celula 4 3 (tabuleiro no)))
  (format stream  " ----| ~%")
  (format stream  "  4  |  ~A  ~A  ~A  ~A ~%~%" (celula 1 4 (tabuleiro no)) (celula 2 4 (tabuleiro no)) (celula 3 4 (tabuleiro no)) (celula 4 4 (tabuleiro no)))
)


;C:\Users\HTC\Desktop\IPS\3� ANO\1� SEMESTRE\Intelig�ncia Artificial\Projeto
(defun log-path()
  "Cria um caminho para o ficheiro log.dat"
  (make-pathname :host "C" :directory '(:absolute "Users" "HTC" "Desktop" "IPS" "3� ANO" "1� SEMESTRE" "Intelig�ncia Artificial" "Projeto" "P2") :name "log" :type "dat")
)


(defun log-add-info-computador(&optional (stream t))
  "Permite escrever dentro do ficheiro"
  (format stream "~%*** JOGADA COMPUTADOR ***")
  (format stream "~%--> Valor do n�: ~a" (first (second *jogada*)))
  (format stream "~%--> Profundidade do n�: ~a" (second (second *jogada*)))
  (format stream "~%--> Cortes efetuados: ~a" (third (second *jogada*)))
  (format stream "~%--> Tabuleiro Atual: ~%")
  (escreve-tabuleiro (car *jogada*) stream)
  (format stream "~%______________________________________________________________~%")
)

(defun log-add-info-humana(&optional (stream t))
  "Permite escrever dentro do ficheiro"
  (format stream "~%*** JOGADA HUMANA ***")
  (format stream "~%--> Tabuleiro Atual: ~%")
  (escreve-tabuleiro *jogada* stream)
  (format stream "~%______________________________________________________________~%")
)


(defun escrever-log ()
  "Fun��o principal para escrever no ficheiro"
  (with-open-file (file (log-path) :direction :output :if-exists :append :if-does-not-exist :create)
    ;(if (eq modo 'Humano)(log-add-info-humana file)
      (log-add-info-computador file))
)
