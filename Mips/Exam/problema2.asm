.data
	entrada: .asciiz "Digite um numero:  "
	saida: .asciiz "\nVetor de numeros primos: \n"
	br: .asciiz " "
	naoPrimos: .asciiz "Não há elementos primos no vetor."
.align 2
	X: .space 80
	Y: .space 80

.text

main: 
	la $a0, X 			# carrega o endereco base de X em $a0
	jal rL 				# rL() (funcao para ler o vetor X)
	la $a0, Y
	la $s1, 0			# carrega o endereco base de Y em $a0
	jal pL				# pL () (funcao que verifica se o numero e primo)
	
rL: 
	move $t0, $a0 			# $t0 = $a0
	move $t1, $t0 			# $t1 = $t0 (sera incrementado)
	li $t2, 0 			# $t2 = 0

readLoop: 
	li $v0, 4			# print da string
	la $a0, entrada			# carrega endereco do argumento de entrada 
	syscall				# chamada de sistema
	
	li $v0, 5			# codigo para ler inteiro
	syscall				# chamada de sistema
	
	sw $v0, ($t1)			# guarda o inteiro na posicao X[i]	
	addi $t1, $t1, 4		# incrementa i em 4 bits
	addi $t2, $t2, 1
	
	blt $t2, 15, readLoop   	# if $t2 != 15 o loop continua
	jr $ra				# else retorna pra main
	
pL: 
	move $t3, $a0			# $t3 = $a0
	move $t6, $t3			# $t6 = $a3 (sera incrementado)
	move $t1, $t0			# $t1 = t0
	
	li $t5, 0 			# t5 = 0 (verificará se existe algum primo)
	li $t2, 0			# t2 = 0
	li $t7, 0			# $t7 = 0
	
primeLoop: 
	lw $s0, ($t1)			# le o inteiro da posicao X[i] e guarda em $s0
	move $a0, $s0			# $a0 = $s0
	
	addi $t1, $t1, 4		# incrementa i em 4 bits
	addi $t2, $t2, 1		# contador++
	
	jal tP				# testPrime ()

	blt $t2, 15, primeLoop  	# if $t2 != 15 o loop continua
	jal pA				# else vai para pA()
	
tP:
	li $t4, 2			# $t4 = 2
	
	beq $a0, 1, notPrime		# if $a0 == 1 then notPrime()
	beq $a0, 2, prime		# if $a0 == 2 then prime ()

testPrime:
	div  $a0, $t4			# num / i
	mfhi $t7			# move o resto para $t7
	
	beq, $t7, $zero, notPrime	# if num % i == 0 then notPrime ()
	
	addi $t4, $t4, 1 		# i++
	blt $t4, $a0, testPrime		# if i < num vai para prime ()

	b prime				# vai para prime ()
	
prime:
	sw $a0, ($t6)			# guarda o inteiro em Y[i]
	addi $t6, $t6, 4		# incrementa i em 4 bits
	addi $s1, $s1, 1		# contador do tamanho do vetor é incrementado
	jr $ra				# retorna
	
notPrime:
	jr $ra				# retorna
	
pA: 
	li $t2, 0			# $t2 = 0
	move $t1, $t3			# t1 = $t3
	move $t4, $s1			# $t4 = $s1
	
	bnez $t4, paCont 		# if $t4 != 0 vai para paCont
	li, $v0, 4			# codigo para printar string
	la $a0, naoPrimos		# carrega o enderco do argumento de entrada
	syscall				# chamada de sistema
	j exit				# pule paraexit
paCont:	
	li $v0, 4			# codigo para printar string
	la $a0, saida			# carrega o endereco do argumento de entrada 
	syscall				# chamada de sistema
	
printArray: 	
	lw $s0, ($t1)			# $s0 = Y[i]
	addi $t1, $t1, 4		# incrementa i em 4 bits
	addi $t2, $t2, 1		# contador++
	
	li $v0, 1			# codigo para printar um inteiro
	move $a0, $s0			# $a0 = $s0
	syscall				# chamada de sistema
	
	li $v0, 4			# print da string
	la $a0, br			# carrega endereco do argumento de entrada 
	syscall				# chamada de sistema
	
	blt $t2, $t4, printArray	# if $t2 != $t4 o loop continua
	jal exit			# vai para exit

exit: 
	li $v0, 10			# codigo para finalizar o programa
	syscall				# chamada de sistema
