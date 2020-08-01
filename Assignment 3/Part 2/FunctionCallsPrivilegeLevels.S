/***************************************************************************

* Project           			: Assignment 3
* Name of the file	     		: COA_A3_P2
* Brief Description of file     : Assembly code to handle different function calls
* Name of Author    	        : M Harini Saraswathy
* Roll No 						: CS18B025 

# a0 value refers to which of bite, cite, kite is called
# incase arguments > no of argument registers available, we pass starting address of data section in a1
# incase arguments <= no of argument registers available, we pass them in a1-a7
# each function is namesake here where the arguments are pushed and popped without implementing any real functionality

***************************************************************************/

_start:

#loading stack pointer
lui sp, 0x10011

#setting base address for mtvec
la t0, mtrap_entry
csrw mtvec, t0

#setting base address for stvec
la t0, strap_entry
csrw stvec, t0

#enabling delegation of ecall from s & u to s mode 
li t3, 0x100
csrrs x0, medeleg, t3

#in machine mode to transition to user mode to 
.p2align 0x2
machine_mode:
li t0, 0x1800
csrrc x0, mstatus, t0
la t0, user_mode
csrw mepc, t0
mret

.p2align 0x2
user_mode:

	#enabling and pushing arguments for bite
	li a1, 10
	li a2, 95
	li a3, 66
	jal x1, _bite

	#enabling and pushing arguments for cite
	li a1, 23
	li a2, 67
	jal x1, _cite

	#enabling and pushing arguments for kite
	#here, we go to data section as there are more arguments than argument registers
	addi sp, sp, -14*4
	la t0, _kite_arg
	lw t1, 0*4(t0)
	sw t1, 1*4(sp)
	lw t1, 1*4(t0)
	sw t1, 2*4(sp)
	lw t1, 2*4(t0)
	sw t1, 3*4(sp)
	lw t1, 3*4(t0)
	sw t1, 4*4(sp)
	lw t1, 4*4(t0)
	sw t1, 5*4(sp)
	lw t1, 5*4(t0)
	sw t1, 6*4(sp)
	lw t1, 6*4(t0)
	sw t1, 7*4(sp)
	lw t1, 7*4(t0)
	sw t1, 8*4(sp)
	lw t1, 8*4(t0)
	sw t1, 9*4(sp)
	lw t1, 9*4(t0)
	sw t1, 10*4(sp)
	lw t1, 10*4(t0)
	sw t1, 11*4(sp)
	lw t1, 11*4(t0)
	sw t1, 12*4(sp)
	lw t1, 12*4(t0)
	sw t1, 13*4(sp)
	lw t1, 13*4(t0)
	sw t1, 14*4(sp)
	jal x1, _kite

.p2align 0x2
_bite:
	#a0 = 1 for bite
	li a0, 1
	ecall
ret

.p2align 0x2
_cite:
	#a0 = 2 for cite
	li a0, 2
	ecall
ret

.p2align 0x2
_kite:
	#a0 = 3 for kite
	li a0, 3
	ecall
ret

loop:
j loop

.p2align 0x2
mtrap_entry:
	csrr t2, mepc
	addi t2, t2 , 0x4
	csrw mepc, t2
mret

.p2align 0x2
strap_entry:
	li t0, 0x1
	bne a0, t0, _bite_done
		addi sp, sp, 3*4

	_bite_done:
	li t0, 0x2
	bne a0, t0, _cite_done
		addi sp, sp, 2*4

	_cite_done:
	li t0, 0x3
	bne a0, t0, _kite_done
		addi sp, sp, 14*4

	_kite_done:
	csrr t2, sepc
	addi t2, t2 , 0x4
	csrw sepc, t2
sret

#arguments for kite are taken from assignment question
.p2align 0x2
_kite_arg:
	.word 35
	.word 99
	.word 12
	.word 13
	.word 0
	.word 4
	.word 5
	.word 9
	.word 12
	.word 1
	.word 2
	.word 2
	.word 3
	.word 9