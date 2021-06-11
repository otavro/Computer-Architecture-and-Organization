  .data
 	msgVetA: .asciiz "Vetor A\n"
 	msgVetB: .asciiz "Vetor B\n"
 	msg1: .asciiz "Array["
 	msg2: .asciiz "]: "
 	espaco: .asciiz " "
	vetA:
	    .align 2
	    .space 60 # aloca 15 espacos no array
	vetB:
	    .align 2
	    .space 28 # aloca 7 espacos no array
	vetInter:
	    .align 2
	    .space 28 # aloca 7 espacos no array
 .text
     move $t0, $zero # indice
     li $t2, 60 # tamanho do array
     li $t4, 0 # indice $t4 = 0
     la $a0 , msgVetA # carrega string
     jal printMsg # printa string
     LerArrayA: 
         beq $t0, 60 saiDoLoopA # verifica se ja leu todo array
         
         la $a0, msg1 # carrega mensagem da string 
         jal printMsg # printa a string
         move $a0, $t4 # move o valor do index para $a0
         jal printInt # printa o index
         la $a0, msg2 # carrega a mensagem da string
         jal printMsg # printa astring
         jal lerNumero # le o numero e retorna em $v0
        
         sw $v0, vetA($t0) # salva o valor em V[i]
         addi $t0, $t0, 4 # atualiza o indice do array
         addi $t4, $t4, 1 # adiciona i no index
         j LerArrayA
     saiDoLoopA:
         move $t0, $zero # indice = 0 
         move $t4, $zero # indice = 0 
         la $a0 , msgVetB
         jal printMsg
     LerArrayB:
         beq $t0, 28 saiDoLoopB
         
         la $a0, msg1
         jal printMsg
         move $a0, $t4
         jal printInt
         la $a0, msg2
         jal printMsg
         jal lerNumero
         
         sw $v0, vetB($t0)	
         addi $t0, $t0, 4 # atualiza o indice do array
         addi $t4, $t4, 1 # atualiza o index do loop
         j LerArrayB
     saiDoLoopB:
          move $t0, $zero # indice = i
          move $t2, $zero # tamanho novo array
          interseccao:
              bgt $t0, 28 printVetIntec
              move $t4, $zero # indice = j
              lw $a0, vetA($t0)
  	      interc:
  	          bgt $t4, 60, saiInterc
                  lw $a1, vetB($t4)
                  bne $a0, $a1, contInter
                      sw $a0, vetInter($t2)
                      addi $t2, $t2, 4
                      j saiInterc
                  contInter:
     	          addi $t4, $t4, 4 # atualiza o indice do array
                  j interc
              saiInterc:
              addi $t0, $t0, 4
              j interseccao
        printVetIntec:
         #############################
	  move $t0, $zero # indice
         imprime:
             beq $t0, $t2, fim
             li $v0, 1
             lw $a0, vetInter($t0)
             syscall
             la $a0, espaco
             jal printMsg
             addi $t0, $t0 4
             j imprime
         fim:
            li $v0, 10 # finaliza o programa
            syscall
         
     # Funções auxiliares
     printMsg:
        li $v0, 4
        syscall
        jr $ra
     printInt:
        li $v0, 1
        syscall
        jr $ra
     lerNumero:
        li $v0, 5
        syscall
        jr $ra
    
     
  
            
