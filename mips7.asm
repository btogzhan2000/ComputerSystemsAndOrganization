# recursive procedure for computing power, takes base and exponent, returns power
.data 
	str1ask: .asciiz "Enter base: "
	str2ask: .asciiz "Enter exponent: "
	powtext: .asciiz "The pow is: "	
.text
	main:
		la $a0, str1ask
		li $v0, 4
		syscall
	
		li $v0, 5
		syscall 
		move $t0, $v0 #t0 base
	
		la $a0, str2ask
		li $v0, 4
		syscall
	
		li $v0, 5
		syscall 
		move $t1, $v0 #t1 exp
		
		move $a0, $t0
		move $a1, $t1
		
		jal pow 
		move $t6, $v0
		
		la $a0, powtext
		li $v0, 4
		syscall
		
		li $v0, 1
		move $a0, $t6
		syscall
		
		li $v0, 10
		syscall	
	
	pow: 
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		move $t2, $a0
		move $t3, $a1
		
		beq $t3, $zero, return1
		subi $t3, $t3, 1
			
		#move $a0, $t2
		move $a1, $t3
		
		jal pow
			
		add $t4, $zero, $v0
		mul $v0, $t2, $t4
		
		exit:
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			jr $ra
		
		return1:
			li $v0,1
        		j exit
