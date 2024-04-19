# conditional.asm
# A conditionally branching program in MIPS Assembly for CS64
#
#  Data Area - allocate and initialize variables
.data
	prompt: .asciiz "Enter an integer: "

#Text Area (i.e. instructions)
.text
main:
	# Get user input
	li $v0, 4
	la $a0, prompt
	syscall

	li $v0, 5
	syscall

	move $t0, $v0

	# Check if input is divisible by 4
	li $t2, 2
	beq $t0, $t2, not_div_4

	andi $t1, $t0, 1
	li $t2, 1
	beq $t1, $t2, not_div_4

	# Continues to here if divisible by 4
	li $t2, 4
	mult $t0, $t2

	li $v0, 1
	mflo $a0
	syscall

	j exit

	# Jumps to this branch if not divisible by 4
	not_div_4: 

	li $t2, 7
	mult $t0, $t2

	li $v0, 1
	mflo $a0
	syscall

	j exit
	
exit:
	li $v0, 10
	syscall