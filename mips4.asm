# procedure reverse, given string s and its length, reverses s
#[OP2] was implemented
.data 
	nl: .asciiz "\n"
	s: .space 256
	stopchar: .word '-'
.text
	main:
		
		li $v0, 8
		la $a0, s
		li $a1, 256
		syscall 
		
		lw $s0, stopchar
		lb $s1, 0($a0)
		beq $s1, $s0, exitfinal
		
		jal findLength
		move $a1, $v0

		jal reverse
		
		la $a0, s
		li $v0, 4
		syscall 
		
		j main
		
	findLength:
		add $t0, $zero, $zero
		loop2:
			add $t1, $a0, $t0
			lb $t2, 0($t1)
			beq $t2, $zero, exitloop2
			addi $t0, $t0, 1
			j loop2
		exitloop2:
			subi $t0, $t0, 1
			addi $v0, $t0, 0
			addi $t0, $zero, 0
			jr $ra 
			
	reverse:
		var:
			move $t0, $a0
			move $t1, $a1
			
			srl $t2, $t1, 1
			add $t7, $zero, $zero
				
		loop: 
			slt $t6, $t7, $t2
			beq $t6, 0, exit
	
			add $t8, $t0, $t7
			lb $t3, 0($t8)
	
			sub $t5, $t1, $t7
			subi $t5, $t5, 1
			
			add $t9, $t0, $t5	
			lb $t4, 0($t9)
			sb $t3, 0($t9)
			sb $t4, 0($t8)
			addi $t7, $t7, 1
			
			j loop
		exit:
			jr $ra
	exitfinal:
		li $v0, 10
		syscall	
		
