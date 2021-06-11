.data 
	msg: .asciiz "Forneça um número decimal: "
	zero: .float 0.0
.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 6
	syscall # valor lido estará em #f0
	
	lwc1 $f1, zero
	add.s $f12, $f1, $f0 # $f12 é o registrador para impressão
	
	li $v0, 2 # carrega a instrução de imprimir o $f12
	syscall