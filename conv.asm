# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
# Data Area.  
# Note that while this is typically only for global immutable data, 
# for SPIM, this also includes mutable data.
input: 
	.word -72 13 -68 27 94 -49 8 37
filter: 
	.word -63 27 44
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


main:
    la $a0 input
    la $a1 filter
    la $a2 output
    #Result length
    lw $a3 output_length
    jal conv

    #Loop for printing result
    la $t0 output
    lw $t3 output_length
    sll $t3 $t3 2
    li $t1 0
    print_loop:
        add $t2 $t0 $t1
        lw $a0 0($t2)
        li $v0 1
        syscall
        la $a0 space
        li $v0 4
        syscall
        add $t1 4
        bne $t1 $t3 print_loop
    j exit

exit:
    la $a0 ack
    li $v0 4
    syscall
	li $v0 10 
	syscall

