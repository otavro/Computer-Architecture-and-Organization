.data
entradaN: .asciiz "Insira o numero de posicoes do vetor: "
entradaVet: .asciiz "Insira vet["
entradaAux: .asciiz "]: "
br: .asciiz " "
msgMaiorSoma: .asciiz " elemento(os) são maiores do que a soma dos elementos lidos.\n"
msgImp:   .asciiz " elementos ímpares no vetor.\n"
msgNaoHaPar: .asciiz "Não há elemento par\n"
msgNaoHaImpar: .asciiz "Nao há elemento impar\n"
msgProdutoNum: .asciiz " é o produto do maior elemento par do vetor com o menor elemento ímpar do vetor.\n"
msgMatrixOrd: .asciiz "Matrix em ordem crescente: "
.text

#variáveis
#	$s0 = tamanho do vetor
#	$s1 = endereço base do vetor
#	$s7 = null

li $s7, 0xFFFFFFF

main:
	jal n
	move $s0, $v0		#Salva em $s0 o valor lido
	
	move $a0, $s0		#Passa o tamanho do vetor para o argumento $a0
	jal alloc
	move $s1, $v0 		#Salva o endereço base do vetor retornado da função alloc em $s1
	
	move $a0, $s1		#Passa o endereço base do vetor para o argumento $a0
	move $a1, $s0		#Passa o tamanho do vetor para o argumento $a1
	jal scanVet
	
	move $a0, $s1		#Passa o endereco base do vetor para o parametro
	move $a1, $s0		#Passa o tamanho do vetor para o parametro
	jal proc_maior_soma
	
	move $a0, $s1		#Passa o endereco base do vetor para o parametro
	move $a1, $s0		#Passa o tamanho do vetor para o parametro
	jal proc_num_ímpar
	
	move $a0, $s1		#Passa o endereco base do vetor para o parametro
	move $a1, $s0		#Passa o tamanho do vetor para o parametro
	jal proc_prod_pos
	
	move $a0, $s1		#Passa o endereco base do vetor para o parametro
	move $a1, $s0		#Passa o tamanho do vetor para o parametro
	jal proc_ord
	
	j exit

# BLOCO DE LEITURA DO VETOR
n:
	la $a0, entradaN
	li $v0, 4		#Código de impressão de string
	syscall
	
	li $v0, 5		#Código de leitura de inteiro
	syscall
	
	jr $ra
	
alloc:
	mul $a0, $a0, 4		#Multiplica o tamanho do vetor por 4 bits
	li $v0, 9		#Código de alocação dinâmica
	syscall
	
	jr $ra

scanVet:
	move $t0, $a0		#Salva o endereço base do vetor em $t0
	move $t1, $t0		#Salva o endereço base do vetor em $t1 ($t1 será incrementado)
	li $t2, 0		#$t2 recebe 0 (contador de verificação)
	move $t3, $a1		#Salva o tamanho do vetor em $t3
	
l:	la $a0, entradaVet	
	li $v0, 4		#Código de impressão de string
	syscall
	
	move $a0, $t2
	li $v0, 1		#Código de impressão de inteiro
	syscall
	
	la $a0, entradaAux
	li $v0 4		#Código de impressão de string
	syscall
	
	li $v0, 5		#Código de leitura de inteiro
	syscall
	
	sw $v0, ($t1)		#Salva o valor lido no endereço armazenado em $t1
	addi $t1, $t1, 4	#Incrementa o endereço do vetor
	addi $t2, $t2, 1	#Incrementa o contador
	
	blt $t2, $t3, l		#Pula para l se o contador for menor que o tamanho do vetor
	
	jr $ra

# BLOCO PARA VERIFICAR QUANTOS NUMEROS SÃO IMPARES
proc_num_ímpar:
	move $t0, $a0		#$t0 recebe o endereco base do vetor
	move $t1, $t0		# t1 recebe o endereco base do vetor (sera incrementado)
	li $t2, 0		#$t2 recebe 0 (contador de verificação)
	move $t3, $a1		#$t3 recebe o tamanho do vetor
	li $t5, 0 		#numeros impares

l1:	
	mul $t1, $t2, 4
	add $t1, $t1, $t0	#Endereco da posicao I do vetor
	lw $t4, ($t1)		#Armazena em $t4 o valor armazenado na posicao $t1
	
	li $t6, 2 		# carrega valor 2 no t6
	div  $t4, $t6		# divide t4/t6
	mfhi $t4		# move o valor do resto para t4
	beqz $t4, l1cont	# if t4 == 0 pule para l1cont
	add $t5, $t5, 1 	# impar++
l1cont:
	addi $t1, $t1, 4	#Incrementa o endereço do vetor
	addi $t2, $t2, 1	#Incrementa o contador
	
	blt $t2, $t3, l1	#Pula para l1 se o contador for menor que o tamanho do vetor
	
	move $a0, $t5		# imprime a quantidade de numeros impares
	li $v0, 1		#Código de impressão de int
	syscall
	
	la $a0, msgImp
	li $v0, 4		#Código de impressão de string
	syscall
	
	jr $ra
#  FIM DO BLOCO

proc_maior_soma:
	move $t0, $a0		#$t0 recebe o endereco base do vetor
	move $t1, $t0		# t1 recebe o endereco base do vetor (sera incrementado)
	li $t2, 0		#$t2 recebe 0 (contador de verificação)
	move $t3, $a1		#$t3 recebe o tamanho do vetor
	li $t5, 0 		#soma dos numeros

l2:	
	mul $t1, $t2, 4
	add $t1, $t1, $t0	#Endereco da posicao I do vetor
	lw $t4, ($t1)		#Armazena em $t4 o valor armazenado na posicao $t1
	
	add $t5, $t5, $t4 	# soma = soma + valor armazenado
	
	addi $t1, $t1, 4	#Incrementa o endereço do vetor
	addi $t2, $t2, 1	#Incrementa o contador
	
	blt $t2, $t3, l2	#Pula para l1 se o contador for menor que o tamanho do vetor
	
	# loopa para ver quantos elementos são maiores que a soma
	move $t0, $a0		#$t0 recebe o endereco base do vetor
	move $t1, $t0		# t1 recebe o endereco base do vetor (sera incrementado)
	li $t2, 0		#$t2 recebe 0 (contador de verificação)
	move $t3, $a1		#$t3 recebe o tamanho do vetor
	li $t6, 0 		#soma dos numeros
l3:
	mul $t1, $t2, 4
	add $t1, $t1, $t0	#Endereco da posicao I do vetor
	lw $t4, ($t1)		#Armazena em $t4 o valor armazenado na posicao $t1
	
	blt $t4, $t5, l3cont
	add $t6, $t6, 1 	# numero de elem > soma elem
l3cont:
	
	addi $t1, $t1, 4	#Incrementa o endereço do vetor
	addi $t2, $t2, 1	#Incrementa o contador
	
	blt $t2, $t3, l3	#Pula para l3 se o contador for menor que o tamanho do vetor
	
	move $a0, $t6		# imprime a soma dos numeros
	li $v0, 1		#Código de impressão de int
	syscall
	
	la $a0, msgMaiorSoma
	li $v0, 4		#Código de impressão de string
	syscall
	jr $ra
#  FIM DO BLOCO
# lembrar quais são os registradores usado nesse procedimento
# $s2 = primeiro par
# $s3 = primeiroImpar
# $s4 = salvaPar
# $s5 = salva Impar
proc_prod_pos:
	move $t0, $a0		#$t0 recebe o endereco base do vetor
	move $t1, $t0		# t1 recebe o endereco base do vetor (sera incrementado)
	li $t2, 0		#$t2 recebe 0 (contador de verificação)
	move $t3, $a1		#$t3 recebe o tamanho do vetor
	li $s2, 0               # primeiroPar
	li $s3, 0		# primeiroImp

l4:	
	mul $t1, $t2, 4
	add $t1, $t1, $t0	#Endereco da posicao I do vetor
	lw $t4, ($t1)		#Armazena em $t4 o valor armazenado na posicao $t1
	
	li $t6, 2 		# carrega valor 2 no t6
	div  $t4, $t6		# divide t4/t6
	mfhi $t6		# move o valor do resto para t4
	beqz $t6, confPar	# if t6 == 0 pule para l1cont
	beqz $s3, primeiroImp   # verifica se é o primeiro impar a ser lido
	bgt $t4, $s5, saidConf  # se num < imparGuardado
	move $s5, $t4           # salva impar
	j saidConf
primeiroImp:
	move $s5, $t4 		#salva o primeiro par
	li $s3, 1
	j saidConf
confPar:
	beqz $s2, primeiroPar
	blt $t4, $s4, saidConf
	move $s4, $t4
	j saidConf
primeiroPar:
	move $s4, $t4 		#salva o primeiro par
	li $s2, 1
	j saidConf
saidConf:
	addi $t1, $t1, 4	#Incrementa o endereço do vetor
	addi $t2, $t2, 1	#Incrementa o contador
	
	blt $t2, $t3, l4	#Pula para l1 se o contador for menor que o tamanho do vetor
	
	bnez $s2, testeExisteImp # se não há par
	la $a0, msgNaoHaPar
	li $v0, 4 #Código de impressão de string
	syscall
	jr $ra
testeExisteImp:
	bnez $s3, saidConfImpPar # se não há imp
	la $a0, msgNaoHaImpar
	li $v0, 4#Código de impressão de string
	syscall
	jr $ra
saidConfImpPar:
	mul $t6, $s4, $s5
	
	move $a0, $t6		# imprime o produto do maior par e menor impar
	li $v0, 1		#Código de impressão de int
	syscall
	
	la $a0, msgProdutoNum
	li $v0, 4#Código de impressão de string
	syscall
	jr $ra
#  FIM DO BLOCO

proc_ord:
	move $t0, $a0		#$t0 recebe o endereco base do vetor
	move $t1, $t0		# t1 recebe o endereco base do vetor (sera incrementado)
	li $t2, 1		#$t2 recebe 1 (contador de verificação)
	move $t3, $a1		#$t3 recebe o tamanho do vetor
	sub $t9, $t3, 1

l5:    # i = 0  i < size 
	move $t5, $t0		# t1 recebe o endereco base do vetor (sera incrementado)
	li   $t7, 0             # t7 recebo 0 (contaodor j)
l6:
	mul $t5, $t7, 4
	add $t5, $t5, $t0	#Endereco da posicao j do vetor
	lw $s3, ($t5)		#Armazena em $s3 o valor armazenado na posicao $t1
	
	move $t1, $t5
	add $t8, $t7, 1
	mul $t1, $t8, 4
	add $t1, $t1, $t0	#Endereco da posicao I do vetor
	lw $t4, ($t1)		#Armazena em $t4 o valor armazenado na posicao $t1
	

	blt $s3, $t4, l6Cont 	# vec[j+1] < vec[j]
	move $s4, $s3  		# aux = vec[j]
 	sw $t4 ($t5)   		# vec[j] = vec[j+1]
	sw $s4 ($t1)		# vec[j+1] = aux
l6Cont:
	addi $t5, $t5, 4
	addi $t7, $t7, 1
	blt $t7, $t9, l6	
	
	addi $t1, $t1, 4	#Incrementa o endereço do vetor
	addi $t2, $t2, 1	#Incrementa o contador
	blt $t2, $t3, l5	#Pula para l1 se o contador for menor que o tamanho do vetor
	
printaMatrixOrdenado:
	move $t0, $a0		#$t0 recebe o endereco base do vetor
	move $t1, $t0		# t1 recebe o endereco base do vetor (sera incrementado)
	li $t2, 0		#$t2 recebe 0 (contador de verificação)
	move $t3, $a1		#$t3 recebe o tamanho do vetor
	li $t5, 0 		#numeros impares
	
	la $a0, msgMatrixOrd
	li $v0, 4		#Código de impressão de string
	syscall
	
lord:	
	mul $t1, $t2, 4
	add $t1, $t1, $t0	#Endereco da posicao I do vetor
	lw $t4, ($t1)		#Armazena em $t4 o valor armazenado na posicao $t1

	move $a0, $t4		# imprime a quantidade de numeros impares
	li $v0, 1		#Código de impressão de int
	syscall
	
	la $a0, br
	li $v0, 4		#Código de impressão de string
	syscall

	addi $t1, $t1, 4	#Incrementa o endereço do vetor
	addi $t2, $t2, 1	#Incrementa o contador
	
	blt $t2, $t3, lord	#Pula para l1 se o contador for menor que o tamanho do vetor
	
	jr $ra
#  FIM DO BLOCO


exit:
	li $v0, 10
	syscall
