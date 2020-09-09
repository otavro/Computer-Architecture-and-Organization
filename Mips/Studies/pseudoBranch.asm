.data
    message: .asciiz "Hi, how are you?"
.text
	main:
	    addi $s0, $zero, 10
	    #addi $s1, $zero, 14
	    
	    bgtz $s0, displayHi 
	    
	    #blt $s0, $s1, displayHi # Sudo instruction
	    


	# End of main
	li $v0, 10
	syscall
	
	displayHi:
	   li $v0, 4
	   la $a0, message
	   syscall