.data 
	caractere: .byte 'A' #Caractere a ser impresso
.text
	li $v0, 4 #Imprimir char ou string
	la $a0, caractere
	syscall
	
	li $v0, 10 #encerrar o programa
	syscall