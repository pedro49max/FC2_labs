/*---------------------------------------------------------------------
**
**  File:
**    pr2_a.asm  19/10/2022
**
**    (c) Daniel Báscones García
**    Introduction to Computers II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Purpose:
**    Code file for project 2a
**
**  Design notes:
**
** 	# define N 8
** 	# define INT_MAX 65536
**	int V [ N ] = { -7 ,3 , -9 ,8 ,15 , -16 ,0 ,3};
**	int min = INT_MAX ;
**	for ( i = 0; i < N ; i ++) {
**		if ( V [ i ] < min )
**			min = V [ i ];
**	}
**
**-------------------------------------------------------------------*/

.global main
.equ N, 8
.equ INT_MAX, 65536
.data
V:   .word -7,3,-9,8,15,-16,0,3

.bss
min: .space 4

.text
main:
    la s1, min        //in s1 address of min
    li t0, INT_MAX    //t0=INT_MAX
    sw t0, 0(s1)      //guardamos en memoria(min) INT_MAX
    li t1,N            //t1=N=8
    li t2,-1          // i=t2=0
for:
addi t2,t2,1
beq t1,t2,exit        //N=i exit
la t3,V               // base of v  in t3
slli t4,t2,2          //i*4
add t5,t3,t4           //dm de v[i]
lw s3,0(t5)            //
bge s3,t0,for
mv t0,s3             // min=v[i]
j for

exit:
sw t0,0(s1)
j exit
