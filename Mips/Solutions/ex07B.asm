.data
	vetor: .space 40
	resto: .space 40
	lenght: .word 0
	newLine: .asciiz "\n"
	primoFrase: .asciiz "Numeros primos:\n"
	perfeitoFrase: .asciiz "Numeros perfeitos:\n"
	amigoFrase: .asciiz "Numeros amigos \n"
	espaco: .asciiz " "
.text
	main:
	   	 li $v0, 5
	   	 syscall 

		move $s0, $v0  
		sw $s0, lenght   # salva o tamanho do vetor
		mulu $s0, $s0, 4 # lenght * 4 bytes
	
		addi $t0, $zero, 0 # Index = $t0
	
	###################### LE OS NUMEROS ##########################################
	readingNumbers: # while loop que serve para ler os argumentos
	    beq $t0, $s0, exitR # quando index = tamanho; ira fazer o pulo
	    li $v0, 5  # le um int
	    syscall
	    sw $v0, vetor($t0) # salva o resultado no vetor
	    addi $t0, $t0, 4 # $t0 vai para proxima posição
	    j readingNumbers	
	    
	exitR:
	    addi $t0, $zero, 0 # index = 0
	    
	    
	#################### SALVA OS RESTOS EM UM OUTRO VETOR ################################
	remainders: # for i < n
	    beq  $t0, $s0, primo
	    addi $t1, $zero, 0 # soma dos restos;
	    addi $t2, $zero, 1 # resto  j;
 	    lw   $t3, vetor($t0)
	    restos: # for j < n
	    	bgt $t2, $t3, saidaR
	    	div $t4, $t3, $t2 # t4 = index2 / num
	    	mfhi $t4 # t4 = (num % index)
	    	beqz $t4, is_divisor
	    	teste:
	    	   addi $t2, $t2, 4
	    	   j restos
	    saidaR:
	       sw $t1, resto($t0) # salva o resto num vetor
	       addi $t0, $t0, 4
	       j remainders
	is_divisor: 
	      add $t1, $t1, $t2
	      j teste
	      
	################# VERIFICIA QUAIS NUMEROS SÃO PRIMOS ##########################
	primo:
	    la $a0, primoFrase
	    li $v0, 4   
	    syscall
	    
	    addi $t0, $zero, 0 # index = 0
	    is_prime:
	    	bgt $t0, $s0, perfeito
	    	lw   $t1, vetor($t0) #pega o vetor
	    	add  $t1, $t1, 1 # numero + 1
	    	lw   $t2, resto($t0) # carrega o resto
	    	beq  $t1, $t2, primoImp # se num == resto; é primo
	    	saidPrimo:
		    addi $t0, $t0, 4
	            j is_prime
 	#################### VERIFICA SE OS NUMEROS SÃO PERFEITOS
	perfeito:
	    li $v0, 4
	    la $a0, perfeitoFrase #imprime a frase
	    syscall
	    li $v0, 4
	    la $a0, newLine
	    syscall
	    addi $t0, $zero, 0 # index = 0
	    is_perfect:
	        bgt $t0, $s0, amigo
	        lw  $t1, vetor($t0) # pega o vetor[i]
	        mul $t2, $t1, 2
	        
	        lw   $t3, resto($t0) # carrega o resto
	        beq $t2, $t3, printaPerf
	        saidPerf:
	            addi $t0, $t0, 4
	            j is_perfect
	################### VERIFICA SE OS NUMEROS SÃO AMIGOS
	amigo:
	    li $v0, 4
	    la $a0, amigoFrase #imprime a frase
	    syscall
	    li $v0, 4
	    la $a0, newLine
	    syscall
 	    addi $t0, $zero, -4 # index = -1
	    is_amigo: # for j < n
	    	addi $t0, $t0, 4 # index = 1
	    	beq $t0, $s0, exit
	    	addi $t1, $zero, 4
	    	add  $t1, $t1, $t0
	    	loop_amigo:
	    	    bge $t1, $s0, is_amigo
	    	    
	    	    lw  $t2, resto($t0)
	    	    lw  $t3, resto($t1)
	    	    beq $t2, $t3, printaAmg
	    	    saidAmg:
	    	       addi $t1, $t1, 4
	    	       j loop_amigo
	
	################ Finaliza o programa ############################
	exit: 
	    li $v0, 10
	    syscall
	  ############### Area reservada para os Prints #######################  	    
	printaAmg:
	    li $v0, 1
	    lw $a0, vetor($t0)
	    syscall
	    li $v0, 4
	    la $a0, espaco
	    syscall
	    li $v0, 1
	    lw $a0, vetor($t1)
	    syscall
	    li $v0, 4
	    la $a0, newLine
	    syscall
	    j saidAmg

	printaPerf:
	    li $v0, 1
	    move $a0, $t1
	    syscall
	    li $v0, 4
	    la $a0, newLine
	    syscall
	    j saidPerf
	primoImp: #printa se o numero é primo
	    #sub $t1, $t1, 1
	    li $v0, 1
	    lw $a0, vetor($t0)
	    syscall
	    la $a0, newLine
	    li $v0, 4
	    syscall
	    j saidPrimo
	    
	    
	novaLinha:
	    #Print uma nova linha
	    li $v0, 4
	    la $a0, newLine
	    syscall
	    jr $ra
	    

	    
