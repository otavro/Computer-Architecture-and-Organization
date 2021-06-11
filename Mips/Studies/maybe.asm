.data
	vetor: .word 0:10
	resto: .word 0:10
	lenght: .word 0
	newLine: .asciiz "\n"
.text
	li $v0, 5
	syscall 
	move $s0, $v0
	sw $v0, lenght
	#addi $s0, $zero, 
	#addi $s0, $zero, 4
	addi $s1, $zero, 10
	addi $s2, $zero, 12
	
	# Index = $t0
	addi $t0, $zero, 0
	
	sw $s0, vetor($t0) #store $s0 in $t0
	  addi $t0, $t0, 4
	sw $s1, vetor($t0)
	  addi $t0, $t0, 4
	sw $s2, vetor($t0)
	
	# Clear $t0 to 0
	addi $t0, $zero, 0
	
	while:
	    beq $t0, 12, exit
	    
	    lw $t6, vetor($t0)
	    
	    addi $t0, $t0, 4 # $t0 goes to next position
	    
	    #Print current number
	    li $v0, 1
	    move $a0, $t6
	    syscall
	    
	    #Print a new line
	    li $v0, 4
	    la $a0, newLine
	    syscall
	    
	    j while	
	
	exit:
	    li $v0, 1
	    lw $a0, lenght 
	    syscall
	    # Tell system this is end of program
	    li $v0, 10
	    syscall