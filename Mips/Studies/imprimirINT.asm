.data 
	idade: .word 56 # valor inteiro na memória RAM
.text
	li $v0, 1 #imprimir INT
	lw $a0, idade
	syscall
	
	li $v0, 10
	syscall