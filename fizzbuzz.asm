# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
# Data Area.  
# Note that while this is typically only for global immutable data, 
# for SPIM, this also includes mutable data.
# DO NOT MODIFY THIS SECTION
input: 
    .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
length:
    .word 15
fizz:   .asciiz "Fizz "
buzz:   .asciiz "Buzz "
fizzbuzz:   .asciiz "FizzBuzz "
space:  .asciiz " "
ack:    .asciiz "\n"


.text
FizzBuzz:
    move $t0 $a0
    move $t1 $a1

    sll $t1 $t1 2
    li $t2 0
    li $t9 0

    loop:
        beq $t2 $t1 return
        li $t3 5
        li $t4 3

        add $t8 $t0 $t2
        lw $t5 0($t8)

        div $t5 $t3
        mfhi $t6
        div $t5 $t4
        mfhi $t7

        beq $t7 $t9 fizzy
        beq $t6 $t9 buzzy
        j else

        fizzy:
            beq $t6 $t9 fizzbuzzy

            la $a0 fizz
            li $v0 4
            syscall
            j finished_conditions

        fizzbuzzy:
            la $a0 fizzbuzz
            li $v0 4
            syscall
            j finished_conditions

        buzzy:
            la $a0 buzz
            li $v0 4
            syscall
            j finished_conditions

        else:
            move $a0 $t5
            li $v0 1
            syscall
            la $a0 space
            li $v0 4
            syscall
            j finished_conditions
        
        finished_conditions:

            addi $t2 $t2 4
            j loop
    return:
        jr $ra


main:
    #DO NOT MODIFY THIS
    la $a0 input
    lw $a1 length
    jal FizzBuzz
    j exit

exit:
    la $a0 ack
    li $v0 4
    syscall
	li $v0 10 
	syscall

