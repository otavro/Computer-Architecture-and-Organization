# Aluno: Otávio Bispo dos Reis
.data 
	vetor: .space 40 # 10 posições
	newLine: .asciiz "\n"
.text
 	main:
 	  li $v0, 5 # Recebe o primeiro valor do vetor
 	  syscall
 	  
 	  addi $t0, $zero, 0 # index = 0;
 	  addi $t2, $zero, 0 #qtd de num pares
 	  addi $t3, $zero, 0 # maior elem par
 	  addi $t4, $zero, 0 #menor ele imp
 	  sw $v0, vetor($zero) # vetor[0] = $v0
 	  move $t6, $v0 # maior = vetor[0] 
 	  move $t7, $v0 # menor = vetor[0]
 	  
 	  addi $t8, $zero, 0 # soma dos imp
 	  addi $t9, $zero, 0 # pro pares
 	  addi $t0, $t0, 0
 	  
 	while:
 	  beq $t0, 40, exit # Sai do loop
 	  
 	  li $s0, 5 # Recebe um numero do usuario
 	  syscall
 	   
 	  sw $s0, vetor($t0) # vetor[$t0] = $v0
 	  addi $t0, $zero, 4 # $t0 vai para proxima posição de memoria
 	  div $t1, $v0, 2
          mfhi $t1
          beq $t1 , $zero, ppar # se for par
          bne $t1 , $zero, simp # se for imp
 	  bgt $s0, $t6, maior   # se vetor[$t0] > $t6; $t6 = vetor[$t0]
          blt $s0,  $t7, menor  # se vetor[$t0] < $t7; $t7 = vetor[$t0]
          j while # volta para o começo do loop
          
	exit:
	   # Printa o maior numero
	   li $v0, 1 
    	   move $a0, $t6 #printa o numero
    	   syscall
    	   li $v0, 4
           la $a0, newLine #printa nova linha
           syscall
           # Printando o menor numero 
	   li $v0, 1 
    	   move $a0, $t7 #printa o menor num
    	   syscall
    	   li $v0, 4
           la $a0, newLine #printa nova linha
           syscall
           # Printando o numero de elem par do vet
	   li $v0, 1 
    	   move $a0, $t2 #printa o menor num
    	   syscall
    	   li $v0, 4
           la $a0, newLine #printa nova linha
           syscall
           # Printando o numero de elem par do vet
	   li $v0, 1 
    	   move $a0, $t3 #printa o menor num
    	   syscall
    	   li $v0, 4
           la $a0, newLine #printa nova linha
           syscall
           # Printando o menor de elem imp do vet
	   li $v0, 1 
    	   move $a0, $t4 #printa o menor num
    	   syscall
    	   li $v0, 4
           la $a0, newLine #printa nova linha
           syscall
           # Printando soma dos elem imp do vetor
	   li $v0, 1 
    	   move $a0, $t8 #printa o menor num
    	   syscall
    	   li $v0, 4
           la $a0, newLine #printa nova linha
           syscall
           # Printando prod dos elem imp do vetor
	   li $v0, 1 
    	   move $a0, $t9 #printa o menor num
    	   syscall
    	   li $v0, 4
           la $a0, newLine #printa nova linha
           syscall
           
        #soma dos impares
        simp:
           add $t8, $t8, $v0 #faz a soma
           jr $ra
           
        #prod dos pares
        ppar:
           addi $t2, $t2, 1 # qtd par + 1
           mul $t9, $t9, $v0 #faz o produto
           jr $ra 
           
        #maior elem do vet
	maior:
	    move $t6, $v0 # ira atualizar $t6 p/ o Maior elementor
	    jr $ra
	    
	#maior elem P
	maiorP:
	   move $t3, $v0
	   jr $ra
	#maior elem I
	menorI:
	   move $t4, $v0
	   jr $ra
	#menor elem do vet
	menor:
	    move $t7, $v0 # ira atualizar $t7 p/ o Menor elementor
	    jr $ra
