.data
	Fib: .word 0 1

.text
	la $s0, Fib
	
	lw $s1, 0($s0)
	lw $s2, 4($s0)
	add $s3, $s1, $s2
	sw $s3, 8($s0)
	
	lw $s3, 8($s0)
	add $s4, $s2, $s3
	sw $s4, 12($s0)
	
	lw $s4, 12($s0)
	add $s5, $s3, $s4
	sw $s5, 16($s0)
	
	lw $s5, 16($s0)
	add $s6, $s4, $s5
	sw $s6, 20($s0)
	
	lw $s6, 20($s0)
	add $s7, $s5, $s6
	sw $s7, 24($s0)
	
	

