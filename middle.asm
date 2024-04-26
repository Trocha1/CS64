# S24 CS 64 
# Lab 04
# middle.asm 

.data

    # TODO: Complete these declarations/initializations

    prompt1: .asciiz "Enter the first number:\n"
    prompt2: .asciiz "Enter the second number:\n"
    prompt3: .asciiz "Enter the third number:\n"
    result: .asciiz "Middle:\n"
    end: .asciiz "\n"


.text

main:
    # TODO: Write your code here
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall

    move $t0, $v0

    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall

    move $t1, $v0

    li $v0, 4
    la $a0, prompt3
    syscall

    li $v0, 5
    syscall

    move $t2, $v0

    bge $t0, $t1, t1

    move $t3, $t0

    bge $t1, $t2 t2

    move $t4, $t1

    j end_if

    t1: 
        move $t3, $t1

        bge $t0, $t2 t2

        move $t4, $t0

        j end_if    

    
    t2:
        move $t4, $t2

        j end_if

    end_if:

    li $v0, 4
    la $a0, result
    syscall

    bge $t3, $t4, t3

    move $a0, $t4

    j print_result

    t3:
        move $a0, $t3

    print_result:

    li $v0, 1
    syscall

    li $v0, 4
    la $a0, end
    syscall

    j exit

exit:
    # TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
	syscall