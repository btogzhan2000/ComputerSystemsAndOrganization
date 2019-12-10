.data
	Arr: .word 21 20 51 83 20 20
	length: .word 6
	x: .word 20
	y: .word 5
	index: .word 0
	space: .asciiz " "
	newline: .asciiz "\n"

.text		
	main:
		la $s0, Arr
		lw $s1, length
		lw $s2, x
		lw $s3, y
		
		move $a0, $s0
		move $a1, $s1
		move $a2, $s2
		move $a3, $s3	
										
		jal printArrInt
		
		li $v0, 4
    		la $a0, newline
    		syscall
    		
		la $a0, Arr		
		jal replace
		
		la $a0, Arr	
		jal printArrInt 
		jal exit	
		
	printArrInt:	
		var:
			move $t1, $a1
			move $t3, $a0		
		loop: 	
			beq $t1, 0, ex
			
			lw $t0, 0($t3)
			addi $t3, $t3, 4
		
			j print
		print: 
			li $v0, 1
			move $a0, $t0
			syscall
		
			li $v0, 4
			la $a0, space
			syscall
			
			subi $t1, $t1, 1	
			j loop		
		ex: 
			jr $ra
	replace:
		var2: 
			move $t4, $a2
			move $t5, $a3
			move $t1, $a1
			move $t3, $a0			
		loop2: 
			beq $t1, 0, ex2	
			
			lw $t0, 0($t3)
			subi $t1, $t1, 1
						
			beq $t0, $t4, change	
			addi $t3, $t3, 4
			j loop2
		change:	
			sw $t5, 0($t3)
			addi $t3, $t3, 4	
			j loop2		
		ex2:
			jr $ra

	exit:
		li $v0, 10
		syscall	
	
		
		
		
		
		
		
		
		
		
