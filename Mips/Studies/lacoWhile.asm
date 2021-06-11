.data
	msg: .asciiz "Forneça um numero: "
.text
	
	# printa a mensagem
	li $v0, 4
	la $a0, msg
	syscall
	# pega a mensagem
	li $v0, 5
	syscall
	
	move $t0, $v0 # move o valor de $v0 para $t0
	li $t1, 0 # carrega o index $t1 com 0
	while:
	   #printa o valor de $t1
	   li $v0, 1
	   move $a0, $t1
	   syscall
	   # verifica se o valor é igual a $t0
	   beq $t1, $t0, saida
	   addi $t1, $t1, 1
	   j while
	
	saida:
	  li $v0, 10
	  syscall