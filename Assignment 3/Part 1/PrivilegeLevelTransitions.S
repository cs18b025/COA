/***************************************************************************

* Project           			: Assignment 3
* Name of the file	     		: COA_A3_P1
* Brief Description of file     : Assembly code for transitioning between privilege levels, here, m to s to u to s to m
* Name of Author    	        : M Harini Saraswathy
* Roll No 						: CS18B025 

# m to s : changing mpp and mepc values
# s to u : changing spp and sepc values
# u to s : user ecall to supervisor mode
# s to m : ecall from supervisor mode

***************************************************************************/

_start:

#loading stack pointer
lui sp, 0x10011

#machine trap entry adsress
la t0, mtrap_entry
csrw mtvec, t0

#supervisor trap entry address
la t0, strap_entry
csrw stvec, t0

#mcause for ecall from user is 8
#8th lsb of medeleg is set to 1
li t3, 0x100
csrrs x0, medeleg, t3

#program defaults to machine mode
.p2align 0x2
machine_mode:
mv x1, x0
addi t1, t1, 0x1

#clearing mpp before transition to supervisor mode
li t0, 0x1800
csrrc x0, mstatus, t0

#storing 01 in mpp
li t0, 0x0800
csrrs x0, mstatus, t0

#loading address for transition in mepc
la t0, mach_to_sup
csrw mepc, t0

#returning to previous privilege level
mret

#transition from machine to supervisor mode
.p2align 0x2
mach_to_sup:
mv x1, x0
addi t1, t1, 0x1

#clearing spp before transition to user mode
li t0, 0x100
csrrc x0, sstatus, t0

#loading address for transition in sepc
la t0, sup_to_user
csrw sepc, t0

#returning to previous privilege level
sret

#supervisor to user transition
.p2align 0x2
sup_to_user:
mv x1, x0
addi t1, t1, 0x1
ecall

#user to supervisor transition
.p2align 0x2
user_to_sup:
mv x1, x0
addi t1, t1, 0x1
ecall

#supervisor to machine transition
.p2align 0x2
sup_to_mach:
addi t2, x0, 0x1
addi t2, x0, 0x2

#infinite loop
loop:
j loop

#supervisor trap entry, for return from user to supervisor mode
.p2align 0x2
strap_entry:

#loading address to return to supervisor from user mode
la t0, user_to_sup
csrw sepc, t0

#setting spp for return
li t0, 0x100
csrrs x0, sstatus, t0
sret

#machine trap entry, for return from supervisor to machine mode
.p2align 0x2
mtrap_entry:

#loading adress to return to machine from supervisor mode
la t0, sup_to_mach
csrw mepc, t0

#setting mpp for return
li t0, 0x1800
csrrs x0, mstatus, t0
mret