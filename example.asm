# example.asm
# An "Example" program in MIPS Assembly for CS64

#  Data Area - allocate and initialize variables
.data

#Text Area (i.e. instructions)
.text
main:
    # TODO: Write your code here
    li $t0, 10
    li $t1, 20 
    li $t2, 30

    addu $t4, $t0,$t2

    sub $t5, $t4,$t1

    li $v0, 1
    move $a0, $t5
    syscall

    j exit

exit:
    # Exit SPIM: Write your code here!
    li $v0, 10
    syscall 
