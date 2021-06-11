.data 
	msg: .asciiz "Forneça um número decimal: "
	zero: .double 0.0
.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 7
	syscall # valor lido estará em #f0
	
	ldc1 $f2, zero
	add.d $f12, $f2, $f0 # $f12 é o registrador para impressão
	
	li $v0, 3 # carrega a instrução de imprimir o $f12
	syscall