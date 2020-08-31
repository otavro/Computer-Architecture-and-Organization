.data
     myMessage: .asciiz "Hello word\n"

.text
    li $v0, 4 #uses code 4
    la $a0, myMessage
    syscall