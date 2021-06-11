.data
	msg: .asciiz "Forneça sua idade: "
	msg2: .asciiz "Sua idade é: "
.text
	li $v0, 4 # imprimir uma string
	la $a0, msg
	syscall
	
	li $v0 5
	syscall
	
	move $t0, $v0 # valor fornecido está em t0
	
	li $v0, 4 # imprimir uma string
	la $a0, msg2
	syscall
	
	li $v0, 1 # imprimir um inteiro
	move $a0, $t0
	syscall

	