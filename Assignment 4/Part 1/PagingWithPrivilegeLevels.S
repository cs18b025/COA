/***************************************************************************

* Project           			: Assignment 4
* Name of the file	     		: COA_A4_P1
* Brief Description of file     : Assembly code to implement a double layered page table while illustrating privilege levels
* Name of Author    	        : M Harini Saraswathy
* Roll No 						: CS18B025 

This shows the implementation of two modes :
 	* Machine mode:
 		Here, both machine and supervisor modules are accessible
 	* Supervisor mode:
 		Here, only supervisor module is accessible

 	We implement 2 MB sized pages. We thus take the information imparted in the lab session and apply it on 2 MB pages.
 	
***************************************************************************/

_start:

#setting sp value
lui sp, 0x10011

#loading address for machine trap entry
la t0, mtrap_entry
csrw mtvec, t0

#double layer paging
li t0, 0x10020000
li t1, 0x4008401
sd t1, 0(t0)

#entry in page for next step of page walk
li t0, 0x10021400
li t1, 0x400004f
sd t1, 0(t0)

#setting pmp addresses
la t0, supervisor_mode
srli t0, t0, 2
csrw pmpaddr0, t0

li t0, 0x11110000
srli t0, t0, 2
csrw pmpaddr1, t0

#setting pmp config 
li t0, 0xffffff
csrrc x0, pmpcfg0, t0
li t0, 0xf08
csrrs x0, pmpcfg0, t0

li t0, 0x1800
csrrc x0, mstatus, t0
li t0, 0x0800
csrrs x0, mstatus, t0
la t0, supervisor_mode
csrw mepc, t0
mret

#machine level trap entry
.p2align 2
mtrap_entry:

	#loading address to return to supervisor mode
	la t1, supervisor_mode_return
	csrw mepc, t1

	#return to previous privilege level
	mret

#supervisor mode code
#satp is properly implemented as taught in lab class
.p2align 2
supervisor_mode:
li t1, 0x0
addi t1, t1, 8
slli t1, t1, 60
li t2, 0x10020000
srli t2, t2, 12
or t1, t2, t1
csrw satp, t1

.p2align 2
j _start

#supervisor mode code
#return to supervisor mode
.p2align 2
supervisor_mode_return:
addi a0, x0, 10

#infinite loop
_loop: j _loop