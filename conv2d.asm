# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
# Data Area.  
# Note that while this is typically only for global immutable data, 
# for SPIM, this also includes mutable data.
#Do not modify this section
#Also, the autograder has hooks for filter:
#so try to have that string anywhere else in the doc
input: 
	.space 2500
    # 1 2 3 4 1 2 3 4 1 2 3 4 becomes a 3x4 matrix:
    # 1 2 3 4
    # 1 2 3 4
    # 1 2 3 4
filter: 
	.word 1 1 1 2 2 2 3 3 3
    # 1 1 1 2 2 2 3 3 3 becomes:
    # 1 1 1
    # 2 2 2
    # 3 3 3
output: 
	.word 0 0 0 0 0 0
output_length:
	.word 6
ack: .asciiz "\n"
space: .asciiz " "


.text

conv:
    # load addresses into t0, t1, t2
    # input, filter and output respectively
	move $t0 $a0
    move $t1 $a1
    move $t2 $a2

    li $t3 12
    sll $a3 $a3 2

    li $t4 0

    j loop

    loop:
        beq $t4 $a3 return

        li $t5 0

        nested_loop:
            beq $t5 $t3 end_nested_loop
            
            add $t6 $t0 $t4
            add $t6 $t6 $t5
            add $t7 $t1 $t5

            lw $t8 0($t6)
            lw $t9 0($t7)

            mult $t8 $t9
            mflo $t8
            
            add $t6 $t2 $t4

            lw $t9 0($t6)
            add $t9 $t9 $t8
            sw $t9 0($t6)

            addi $t5 $t5 4
            j nested_loop

        end_nested_loop:

        addi $t4 $t4 4
        j loop

    return:
        jr $ra


conv2d:
    move $s0 $a0
    move $s1 $a1
    move $s2 $a2
    move $s3 $a3

    li $t0 3
    addi $t1 $s0 -2
    addi $t2 $s1 -2

    li $t3 0
    ble $t1 $t3 return
    ble $t2 $t3 return

    mult $t1 $t2
    mflo $t3
    sll $s4 $t3 2

    sub $sp $sp $t4

    li $s5 0
    loop_2d:
        beq $s5 $t1 return_2d

        li $t3 0
        intialize_loop:
            beq $t3 $t2 initialized

            mult $s5 $t2
            mflo $t4
            add $t4 $t4 $t3 
            sll $t4 $t4 2
            add $t4 $sp $t4
            li $t5 0

            sw $t5 0($t4)

            addi $t3 1
        
        initialized:

        li $s6 0

        filter_loop:
            beq $s6 $t0 end_loop_2d

            add $t3 $s5 $s6
            mult $t3 $s1
            mflo $t3
            add $a0 $s2 $t3

            mult $s6 $t0
            mflo $t3
            add $a1 $s3 $t3

            mult $s5 $t2
            mflo $t3
            add $a2 $sp $t3

            move $a3 $t2

            sub $sp $sp 36

            sw $ra 0($sp)
            sw $s0 4($sp)
            sw $s1 8($sp)
            sw $s2 12($sp)
            sw $s3 16($sp)
            sw $s4 20($sp)
            sw $s5 24($sp)
            sw $s6 28($sp)

            jal conv

            lw $ra 0($sp)
            lw $s0 4($sp)
            lw $s1 8($sp)
            lw $s2 12($sp)
            lw $s3 16($sp)
            lw $s4 20($sp)
            lw $s5 24($sp)
            lw $s6 28($sp)

            li $t0 3
            addi $t1 $s0 -2
            addi $t2 $s1 -2

            add $sp $sp 36

            addi $s6 $s6 1

        end_loop_2d:

        li $t3 0
        mult $t1 $t2
        mflo $t4
        print_loop:
            beq $t3 $t4 loop_2d

            add $t5 $sp $t3
            lw $a0 0($t5)
            li $v0 1
            syscall 
            
            la $a0 ack
            li $v0 4
            syscall

            addi $t3 1

    return_2d:
        jr $ra

main:
    #Do not modify anything past here!
    #The autograder will fail if anything is modified
    autograder_hook1:
    li $s0 5

    li $v0 5
    syscall
    move $a0 $v0
    li $v0 5
    syscall
    move $a1 $v0
    la $a2 input
    mult $a0 $a1
    mflo $t0
    sll $t0 $t0 2
    li $t1 0
    read_loop:
        beq $t1 $t0 end_read_loop
        li $v0 5
        syscall
        add $t2 $t1 $a2
        sw $v0 0($t2)
        addi $t1 $t1 4
        j read_loop
    end_read_loop:    
    la $a3 filter
    jal conv2d

    la $a0 ack
    li $v0 4
    syscall
    autograder_hook2:
    move $a0 $s0
    li $v0 1
    syscall

    j exit

exit:
    la $a0 ack
    li $v0 4
    syscall
	li $v0 10 
	syscall

