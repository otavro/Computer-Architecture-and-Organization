.data 
    message: .asciiz "Enter the value of PI: "
    zeroAsFloat: .float 0.0
.text
    lwc1 $f4, zeroAsFloat
    
    #Display the message
    li $v0, 4
    la $a0, message
    syscall
    
    #Read user's input
    li $v0, 6 # code to read a float
    syscall
    
    #Display value
    li    $v0, 2
    add.s $f12, $f0, $f4
    syscall