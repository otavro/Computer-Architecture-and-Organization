.data
    PI: .float 3.14

.text
    li   $v0, 2 #the code to print a float is 2
    lwc1 $f12, PI #uses Coproc1
    syscall