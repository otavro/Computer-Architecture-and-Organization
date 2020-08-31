.data
    myDouble:   .double 7.202
    zeroDouble: .double 0.0
.text
    ldc1 $f2, myDouble #get f2 and f3
    ldc1 $f0, zeroDouble #f0 and f1
    
    li     $v0, 3
    add.d  $f12, $f2, $f0
    
    syscall