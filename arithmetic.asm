# arithmetic.asm
# A simple calculator program in MIPS Assembly for CS64
#

.text
main:	
	# Recieve inputs
	li $v0, 5
	syscall

	move $t0, $v0

	li $v0, 5
	syscall

	move $t1, $v0

	# Perform aritmetic operations
	sra $t1, $t1, 1

	sub $t0, $t0, $t1

	sll $t0, $t0, 5

	addi $t0, 4

	# Print result and exit
	li $v0, 1
	move $a0, $t0
	syscall

	j exit

exit:
	li $v0 10
	syscall
