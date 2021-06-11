#Implementação da atividade 04 em Codigo MIPS
#Somatorio(4k+2); sendo k =1 até k = 20;
.data
.text
    main:
        addi $t0, $zero, 1 # $t0 = 1; Que equivale há k = 1
    	addi $s0, $zero, 0 #soma = 0
    while:
       bgt  $t0, 20, exit   # Se $t0 > 20 sai do loop
       mul  $t1, $t0, 4     # $t1   = $t0 * 4
       add  $t1, $t1, 2     # $t1   = $t1 + 2
       add  $s0, $s0, $t1   # $soma = $soma + $t1
       addi $t0, $t0, 1     # $t0   = $t0 + 1;
       
       j while # Faz um jump incondicional para While
       
    exit:
    	# Printa o resultado da saida
        li $v0, 1 # carrega o codigo de print inteiro
        add $a0, $zero, $s0  # carrega o valor da somatario em a0
        syscall 
    # Finaliza o programa
    li $v0, 10 # Carrega o codigo que indica o fim do programa
    syscall

    
    
    
    
