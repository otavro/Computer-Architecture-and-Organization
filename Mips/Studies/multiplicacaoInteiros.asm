.text
	li $t0, 12
	addi $t1, $zero, 10
	
	#$s0 terá o resultado da multiplicação
	mul $s0, $t0, $t1
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	#multiplicar potencia de 2
	sll $s1, $t1, 10 # mutiplicar por 2^10 = 1024
	