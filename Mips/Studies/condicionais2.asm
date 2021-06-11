.data
	msg: .asciiz "Forneça um numero: "
	msgMaior: .asciiz "O numero é maior do que 0"
	msgMenor: .asciiz "O numero é menor do que 0"
	msgIgual: .asciiz "O numero é igual a 0"
.text
	# imprime a MSG
	li $v0, 4
	la $a0, msg
	syscall
	
	# faz a leitura do numero
	li $v0, 5
	syscall
	
	
	# se $t0 for igual a zero pule para a label igualZero
	beqz $v0, igualZero
	bgtz $v0, maiorZero
	
	#imprime caso seja menor que zero
	li $v0, 4
	la $a0, msgMenor
	syscall
	j fim
	
	# imprime se é igual a zero
	igualZero:
	    li $v0, 4
	    la $a0, msgIgual
	    syscall
	    j fim
	# imprime se é maior que zero
	maiorZero:
	    li $v0, 4
	    la $a0, msgMaior
	    syscall
	    j fim
	        
	# finaliza o programa
	fim:
	   li $v0, 10
	   syscall