 .data
	meuArray:
	    .align 2
	    .space 16 # aloca 4 espacos no array
 .text
     move $t0, $zero # indice
     move $t1, $zero # valor a ser colocado no array
     li $t2, 16 # tamanho do array
     
     # loopa o array e le os numeros
     # colocando cada numero lido em sua posição
     loopLerArray:
         beq $t0, 16 saiDoLoop
         jal lerNumero
         sw $v0, meuArray($t0)
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
         move $t0, $zero # indice
         imprime:
             beq $t0, $t2, saiDaImpressao
             li $v0, 1
             lw $a0, meuArray($t0)
             syscall
             
             addi $t0, $t0 4
             j imprime
     saiDaImpressao:
            