# S24 CS 64 
# Lab 04
# swapArray.asm 

# IMPORTANT: READ, BUT DO NOT CHANGE ANY OF THE CODE IN THIS PROGRAM
#           THAT IS ALREADY THERE! ONLY ADD YOUR NEW CODE WHERE 
#           IT SAYS TO DO SO, i.e. IN THE doSwap: AREA.


.data
# Data Area.  
# Note that while this is typically only for global immutable data, 
# for SPIM, this also includes mutable data.        

incorrect:  .asciiz "---TEST FAILED---\n"
before:     .asciiz "Before:\n"
after:      .asciiz "After:\n"
comma:      .asciiz ", "
newline:    .asciiz "\n"
        
expectedMyArray:
        .word 29 17  0  0 25  0 23  0  0  0 19  0  0 67 59

myArray:
        .word 29 17 27 20 25 22 23 24 21 26 19 28 99 67 59

.text

# Print everything in the array (without use of a loop)
# Used as a function/sub-routine

printArray:
        la $t0, myArray

        li $v0, 1
        lw $a0, 0($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
		
	    li $v0, 1
        lw $a0, 36($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 40($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 44($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 48($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 52($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 56($t0)
        syscall
        li $v0, 4
        la $a0, newline
        syscall

        jr $ra

# CHECKING THE ARRAY FOR CORRECTNESS AFTER SWAPPING         
# unsigned int* p1 = expectedMyArray;
# unsigned int* p2 = myArray;
# unsigned int* limit = expectedMyArray + 12;
#
# while (p1 < limit) 
#{   if (*p1 != *p2) 
#    {   return 0;                  
#    }
#    p1++;               
#    p2++;
# }
# return 1;                     

checkArrays:
        # $t0: p1
        # $t1: p2
        # $t2: limit
        
        la $t0, expectedMyArray
        la $t1, myArray
        addiu $t2, $t0, 56

    checkArrays_loop:
        slt $t3, $t0, $t2
        beq $t3, $zero, checkArrays_exit

        lw $t4, 0($t0)
        lw $t5, 0($t1)
        bne $t4, $t5, checkArrays_nonequal
        addiu $t0, $t0, 4
        addiu $t1, $t1, 4
        j checkArrays_loop
        
    checkArrays_nonequal:
        li $v0, 0
        jr $ra
        
    checkArrays_exit:
        li $v0, 1
        jr $ra
        
main:   
        # Print array "before"
        la $a0, before
        li $v0, 4
        syscall

        jal printArray
        
        # Do swap function 
        jal doSwap

        # Print array "after"
        la $a0, after
        li $v0, 4
        syscall
        
        jal printArray

        # Perform check on array
        jal checkArrays
        beq $v0, $zero, main_failed
        j main_exit
        
main_failed:
        la $a0, incorrect
        li $v0, 4
        syscall
        
main_exit:      
	# TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
    syscall

        
# COPYFROMHERE - DO NOT REMOVE THIS LINE

doSwap:
        # TODO: translate the following C code into MIPS assembly here.

        # Use only regs $v0-$v1, $t0-$t7, $a0-$a3.
        # You may assume nothing about their starting values.

        # unsigned int x = 0; 
        # while (x < 15) { 
        #     if (myArray[x]%2 == 0 || myArray[x]%3==0)
        #     {
        #         myArray[x] = 0; 
        #         x+=1;
        #     }
        # }

        la $t0, myArray

        li $t1, 15
        li $t2, 0
        li $a3, 0
        li $t6, 2
        li $t7, 3


        loop:
            beq $t2, $t1, end_loop
            addiu $t2, $t2, 1

            lw $t3, 0($t0)

            #li $v0, 1
            #lw $a0, 0($t0)
            #syscall

            div $t3, $t6
            mfhi $t4
            div $t3, $t7
            mfhi $t5

            beq $t4, $a3, if_true
            beq $t5, $a3, if_true
            addiu $t0, $t0, 4
            j loop

            if_true:
                li $t3, 0
                sw $t3, 0($t0)
            
            addiu $t0, $t0, 4
            j loop


        end_loop:

        # DO NOT REMOVE THIS LAST LINE
        jr $ra
