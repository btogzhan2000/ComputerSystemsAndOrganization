# given a string s and its length, sort s using bubble sort
.data 
	nl: .asciiz "\n"
	s: .asciiz "HelloWorld"
	length: .word 10
.text
	main:
		la $a0, s
		lw $a1, length
		
		la $a0, s
		li $v0, 4
		syscall

		jal string_bubble_sort
	
		la $a0, nl
		li $v0, 4
		syscall
		
		la $a0, s
		li $v0, 4
		syscall
		
		jal exitfinal
		
	string_bubble_sort:
		subi $sp,$sp, 20    
         	sw $ra, 16($sp)        
         	sw $s3,12($sp)         
         	sw $s2, 8($sp)         
         	sw $s1, 4($sp)         
         	sw $s0, 0($sp)         

		add $s2, $a0, $zero           
         	add $s3, $a1, $zero          
         	add $s0, $zero, $zero         
		loop1: 
			slt  $t0, $s0, $s3      
         		beq  $t0, $zero, exit1  
         		subi $s1, $s0, 1      
		loop2: 
			slti $t0, $s1, 0       
         		bne  $t0, $zero, exit2  
    
         		add $t1, $s1, $zero
         		add  $t2, $s2, $t1     
         		lb   $t3, 0($t2)       
         		lb   $t4, 1($t2)        
         		
			slt  $t0, $t4, $t3      
         		beq  $t0, $zero, exit2  
         		add $a0, $s2, $zero           
         		add $a1, $s1, $zero          
         		jal  swap               
         		subi $s1, $s1, 1       
         		j    loop2           
		swap: 
      			add $t1, $a0, $t1 
      			lb $t0, 0($t1)  
      			lb $t2, 1($t1)    
      			sb $t2, 0($t1)      
      			sb $t0, 1($t1)	
      			jr $ra           	
		exit2:   
			addi $s0, $s0, 1        
         		j    loop1           	
		exit1: 
			lw $s0, 0($sp)  # restore $s0 from stack
			lw $s1, 4($sp)         # restore $s1 from stack
			lw $s2, 8($sp)         # restore $s2 from stack
			lw $s3,12($sp)         # restore $s3 from stack
			lw $ra,16($sp)         # restore $ra from stack
			addi $sp,$sp, 20       # restore stack pointer
			jr $ra
         exitfinal:
		li $v0, 10
		syscall
