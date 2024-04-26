# S24 CS 64 
# Lab 04
# gcd.asm 

##### C++ (NON-RECURSIVE) code snippet of gcd(a,b):
    # int main()
    # {
    #     int a, b, n;
    #     int gcd = 1;

    #     cout << "Enter the first number:\n"; 
    #     cin >> a;
    #     cout << "Enter the second number:\n"; 
    #     cin >> b;
        
    #     if(a<b)
    #     {    n = a; }
    #     else
    #     {    n = b; }

    #     for(int i = 1; i <= n; i++)
    #     {
    #         if(a%i==0 && b%i==0)
    #             gcd = i;
    #     }

    #     cout << "GCD: " << gcd <<  "\n"; 

    #     return 0;
    # }


##### Assembly (NON-RECURSIVE) code version of gcd(a,b):

.data

	# TODO: Complete these declarations/initializations
    prompt1: .asciiz "Enter the first number:\n"
    prompt2: .asciiz "Enter the second number:\n"
    result: .asciiz "GCD:\n"
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

    li $t3, 1
    li $t6, 1
    li $t9, 0
    li $t2, 1

    ble $t0, $t1, true

    add $t2, $t2, $t1

    j loop

    true:
        add $t2, $t2, $t0

    loop:
        beq $t3, $t2, end_loop

        div $t0, $t3
        mfhi $t4
        div $t1, $t3
        mfhi $t5

        beq $t4, $t9, and_if
        j if_false

        and_if:
            beq $t5, $t9, if_true
            j if_false

            if_true:
                move $t6, $t3

        if_false:


        addi $t3, $t3, 1
        j loop



    end_loop:

    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 4
    la $a0, end
    syscall

    j exit

exit:
	# TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
    syscall
