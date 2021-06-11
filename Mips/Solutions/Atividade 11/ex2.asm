  .data
 	msgVetA: .asciiz "Vetor A\n"
 	msgVetB: .asciiz "Vetor B\n"
 	somasVETA: .asciiz "\nSoma das posições pares do vetA: "
 	somasVETB: .asciiz "\nSoma das posições impares do vetB: "
 	msg1: .asciiz "Array["
 	msg2: .asciiz "]: "
	vetA:
	    .align 2
	    .space 40 # aloca 10 espacos no array
	vetB:
	    .align 2
	    .space 40 # aloca 10 espacos no array
 .text
     move $t0, $zero # indice
     li $t2, 40 # tamanho do array
     li $t4, 0
     la $a0 , msgVetA
     jal printMsg
     
     LerArrayA:
         beq $t0, 40 saiDoLoopA # verifica se i < 10
         
         la $a0, msg1 # carrega o endereço da string
         jal printMsg # printa ta mensagem
         move $a0, $t4 # move o valor de i para o endereço $a0
         jal printInt # printa o index i
         la $a0, msg2 # carrega o endereço da string
         jal printMsg # printa mensagem
         jal lerNumero # le o numero e salva em $v0
        
         sw $v0, vetA($t0) # V[i] = $t0
         addi $t0, $t0, 4 # atualiza o indice do array
         addi $t4, $t4, 1 # adiciona 1 no index
         j LerArrayA
     saiDoLoopA:
         move $t0, $zero # indice = 0 
         move $t4, $zero # indice = 0 
         la $a0 , msgVetB # carrega o endereço da string
         jal printMsg # printa a mensagem
     LerArrayB:
         beq $t0, 40 saiDoLoopB # verifica se i < 10
         
         la $a0, msg1 # carrega o endereço da string
         jal printMsg # printa a mensagem
         move $a0, $t4 # move o valor de i para o endereço $a0
         jal printInt # printa o index i
         la $a0, msg2  # carrega o endereço da string
         jal printMsg # printa a mensagem 
         jal lerNumero # le o numero e salva em $v0
         
         sw $v0, vetB($t0) # salva o VB[i] = $v0
         addi $t0, $t0, 4 # atualiza o indice do array
         addi $t4, $t4, 1 # atualiza o index do loop
         j LerArrayB
     saiDoLoopB:
          move $s0, $zero # soma dos pares do vetor 1
          move $t0, $zero # i = 0
         somaPar:
             bgt $t0, $t2, saidaImpVet # quando i < tamanho do vetor
             lw $a0, vetA($t0)  # carrega o $a0 = V[i]
             add $s0, $s0, $a0 # soma += soma + a0 
             
             addi $t0, $t0, 8 # i = i + 2  / só vai pegar as posições pares
             j somaPar 
     saidaImpVet:
     	  move $s1, $zero # soma dos imp do vetor b
     	  move $t0, $zero
          addi $t0, $zero, 4 # i = 1
         somaImp:
             bgt $t0, $t2, printFinal
             lw $a0, vetB($t0)
             add $s1, $s1, $a0
             
             addi $t0, $t0, 8 # i = i + 2 / só vai pegar as posições impares
             j somaImp
      printFinal: # procedimento final responsavel por printar tudo
         la $a0, somasVETA # printa a soma dos pares do vetor A
         jal printMsg
         move $a0, $s0
         jal printInt

         la $a0, somasVETB # printa a soma dos impares dos vetor B
         jal printMsg
         move $a0, $s1
         jal printInt
         
         li $v0, 10
         syscall
         
	          
     # funções auxiliares para facilitar
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
        
        
     
  
            
