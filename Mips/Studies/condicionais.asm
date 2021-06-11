.data
	msg1: .asciiz "Forneça um numero: "
	msgPar: .asciiz "O numero é par "
	msgImp: .asciiz "O numero é Impar "
.text
	#imprime a mensagem
	li $v0, 4
	la $a0, msg1
	syscall 
	
	# faz a leitura do numero
	li $v0 5 
	syscall
	
	li $t0, 2
	div $v0, $t0
		
	mfhi $t1 #possui o resto da divisão por 2
	
	beq $t1, $zero, imprimePar # verifica se o resto $t0 é igual a zero
	
	# imprime se é impar
	li $v0, 4 
	la $a0, msgImp
	syscall 

	li $v0, 10
	syscall

	# imprime se é par
	imprimePar: 
	   li $v0, 4
	   la $a0, msgPar
	   syscall 
		
	