#  Data Area - allocate and initialize variables
.data

#Text Area (i.e. instructions)
.text
main:
    # TODO: Write your code here
    li $t0, 72 
    li $t1, 54 
    li $t2, 26 

    sub $t3, $t2, $t1

    add $t4, $t3, $t0

    add $t5, $t1, $t2

    xor $t3, $t4, $t5

    li $v0, 1
    move $a0, $t3
    syscall

    j exit

exit:
    # Exit SPIM: Write your code here!
    li $v0, 10
    syscall 
