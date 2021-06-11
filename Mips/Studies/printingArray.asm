.data
	myArray: .space 12 # 4 bytes for interger; 12 <- 3 position
	newLine:  .asciiz "\n"
.text
        main:
	addi $s0, $zero, 4
	addi $s1, $zero, 10
	addi $s2, $zero, 12
	
	# Index = $t0
	addi $t0, $zero, 0
	
	sw $s0, myArray($t0) #store $s0 in $t0
	  addi $t0, $t0, 4
	sw $s1, myArray($t0)
	  addi $t0, $t0, 4
	sw $s2, myArray($t0)
	
	# Clear $t0 to 0
	addi $t0, $zero, 0
	
	while:
	    beq $t0, 12, exit
	    
	    lw $t6, myArray($t0)
	    
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
	    # Tell system this is end of program
	    li $v0, 10
	    syscall