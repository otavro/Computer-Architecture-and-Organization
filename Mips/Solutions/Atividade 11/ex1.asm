 .data
        espaco: .asciiz " "
	meuArrayX:
	    .align 2
	    .space 60 # aloca 4 espacos no array
	meuArrayY:
	    .align 2
	    .space 60 # aloca 4 espacos no array
 .text
     move $t0, $zero # indice
     move $t1, $zero # valor a ser colocado no array
     li $t2, 60 # tamanho do array
     
     # loopa o array e le os numeros
     # colocando cada numero lido em sua posição
     loopLerArray:
         beq $t0, 60 saiDoLoop
         jal lerNumero
         sw $v0, meuArrayX($t0)
         addi $t0, $t0, 4 # atualiza o indice do array
         addi $t1, $t1, 1 # atualiza o index do loop
         j loopLerArray
     # Função para ler um numero inteiro
     # retorna em $v0 o numero lido
     lerNumero:
         li $v0, 5
         syscall
         jr $ra
     saiDoLoop:
     	 move $t5, $zero # tam do segundo array
         move $t0, $zero # indice
         loopVefPrimo:
             beq $t0, $t2, saiDaImpressao # verifica se $t0 é igual ao tamanho do array
             lw $a0, meuArrayX($t0) #  carrega o valor do array[i] em $a0
             jal ehPrimo # verifica se $a0 é primo retorna em $v0 0 ou 1
             beqz $v0, loopVefContinua # se $v0 = 0 o numero é primo 
             lw $a0, meuArrayX($t0) #  carrega o valor do array[i] em $t4
             sw $a0, meuArrayY($t5)
             addi $t5, $t5 4
             loopVefContinua:
             addi $t0, $t0 4
             j loopVefPrimo
             
     saiDaImpressao:
         move $t0, $zero # indice
         loop:
             beq $t0, $t5, encerrarPrograma # se $t5 = $t0 acaba o loop
             li $v0, 1 # carrega comando de impressao INT
             lw $a0, meuArrayY($t0) # carrega o valor da impressao
             syscall 
             
             li $v0, 4 # imprime o espaco
             la $a0, espaco
             syscall 
             
             addi $t0, $t0 4
             j loop
             
             
     encerrarPrograma:
         li $v0, 10
         syscall

	ehPrimo:
	addi	$t7, $zero, 2 # int x = 2
	
	ehPrimoTeste:
	slt	$t6, $t7, $a0 # if (x > num)
	bne	$t6, $zero, ehPrimoLoop		
	addi	$v0, $zero, 1 # é  primo!
	jr	$ra  # returna em $v0 1

	ehPrimoLoop # senao
	div	$a0, $t7					
	mfhi	$t3 # c = (num % x)
	slti	$t4, $t3, 1				
	beq	$t4, $zero, ehPrimoLoopContinua	# if (c == 0)
	add	$v0, $zero, $zero # nao é primo
	jr	$ra #return 0

	ehPrimoLoopContinua:		
	addi $t7, $t7, 1				# x++
	j	ehPrimoTeste				# continua o loop
            