/*---------------------------------------------------------------------
**
**  File:
**    pr1_lab.asm  19/10/2022
**
**    (c) Daniel Báscones García
**    Introduction to Computers II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Purpose:
**    Code file for project 1_lab
**
**  Design notes:
**
**-------------------------------------------------------------------*/
//constant N is defined
.equ N, 10
//space reserved for the result
.data                   //data with initial value section
    num:      .word 25 //data 'num', with value 127
.bss
	square_root: 	.space 4
//program
.text
.global main
main:
 la t3, num         //the address of num is loaded into t3
 lw t0, 0(t3)       //we use the address to load the value of num
li t1,1             //t1 is for index
li t2,0             //t2 is the square_root

for:
bgt t1,t0,exit      // if i>num exit
sub t0,t0,t1        //num=num-i
addi t2,t2,1        // square_root+=1
addi t1,t1,2        //i+=2
j for

exit:
la t4, square_root   //we get the address of square_root
sw t2, 0(t4)         //in the address of square_root we load t2(value of square_root)

end:
j end
