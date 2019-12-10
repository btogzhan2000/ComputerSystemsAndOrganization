.data
	arr: .space 1024
.text
#Number of blocks: 1
#Cache block size: 32
#YOUR METRIC SCORE: 5128
#The reasons for my optimization 
#In Assembly code: 
#memory access count should be less, so constants were used. Actually, word instead of byte should be used to reduce
#memory access count, but I think that adding 1 should also be okay.
#In the configurations of cache parameters: 
#by making different combinations of number of blocks and block size to have cache size 128,
#this configuration was the best for achieving the best metric score. Actually, number of blocks should be 1,
#since minimal number of blocks is required. 

	li $t0, 0
	la $s0, arr
	li $t1, 1024
	li $t2, 1
for:
	beq $t0, $t1, end
	sb $t2, 0($s0)
	addi $s0, $s0, 1
	addi $t0, $t0, 1
	j for	
end:
	li $v0, 10
	syscall
		
