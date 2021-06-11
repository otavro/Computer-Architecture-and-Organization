 # argumentos $a0 a $a3
 # retornos: $v0 e $v1
 
 .data
 	msgUser: .asciiz "Forneça o número positivo: "
 	msgPar: .asciiz "O número é par. "
 	msgImp: .asciiz "O número é impar. "
 .text
 	.main:
 	   la $a0, msgUser
 	   jal imprimeString
 	   jal lerInteiro
 	   
 	   move $a0, $v0
 	   jal isImpar
  
  	   beq $v0, $zero imprimePar
  	   la $a0, msgImp
  	   jal imprimeString
  	   jal encerraPrograma
  	
  	#encerra o programa
  	encerraPrograma:
  	   li $v0, 10
  	   syscall
  	
  	imprimePar:
  	    la $a0, msgPar
  	    jal imprimeString
  	    jal encerraPrograma
  
 	#função que verifica se o argumento $a0 é impar
 	#retorna 1 se for impar
 	#retorna 0 se for par
 	isImpar:
 	   li $t0, 2
 	   div $a0, $t0 # divide $a0 por 2
 	   
 	   mfhi $v0 # move o resto para $v0
 	   jr $ra # retorna 
 	   
 	#função que reccebe uma String em $a0 e a imprime
 	imprimeString:
 	   li $v0, 4
 	   syscall
 	   jr $ra
 	#função que le um inteiro em $v0 e retorna
 	lerInteiro:
 	   li $v0, 5
 	   syscall
 	   jr $ra