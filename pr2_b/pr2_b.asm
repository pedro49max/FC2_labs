/*---------------------------------------------------------------------
**
**  File:
**    pr2_b.asm  19/10/2022
**
**    (c) Daniel Báscones García
**    Introduction to Computers II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Purpose:
**    Code file for project 2b
**
**  Design notes:
**
**	# define N 8
**	# define INT_MAX 65536
**	int V [ N ] = { -7 ,3 , -9 ,8 ,15 , -16 ,0 ,3};
**	int W [ N ];
**	int min , index ;
**	for ( j = 0; j < N ; j ++) {
**		min = INT_MAX ;
**		for ( i = 0; i < N ; i ++) {
**			if ( V [ i ] < min ) {
**				min = V [ i ];
**				index = i ;
**			}
**		}
**		W [ j ] = V [ index ];
**		V [ index ] = INT_MAX ;
**	}
**
**-------------------------------------------------------------------*/

.global main
.equ N , 8
.equ INT_MAX , 65536

.data
V: 	 .word -7 ,3 , -9 ,8 ,15 , -16 ,0 ,3
.bss
W: 	 .space N *4
min: .space 4
ind: .space 4

.text
main:
li s0,-1           //j=s0=-1
li t0, INT_MAX    //INT_MAX=t0
li t1,N            //N=t1=8

for:
addi s0,s0,1          //j++
beq t1,s0,exit        //N=j exit
mv s1,t0              //min=s1=INT_MAX
li s2,-1              //i=s2=-1

for2:
addi s2,s2,1           //i++
beq s2,t1,cacho        //i=N salta al cacho
la t3,V               // base of v  in t3
slli t4,s2,2          //i*4
add t5,t3,t4           //dm de v[i]
lw s3,0(t5)            //
bge s3,s1,for2
mv s1,s3             // min=v[i]
mv  s4,s2            //s4=index=i
j for2

cacho:
slli t4,s4,2          //index*4
add t5,t3,t4           //dm de v[index]
lw s3,0(t5)            // valor de v[index]
la t6,W               // base of W  in t6
slli t4,s0,2          //j*4
add s5,t6,t4           //dm de w[j]
sw s3,0(s5)            // w[j] = v[index]
sw t0,0(t5)            //v[index] = int_max
j for

exit:
j exit

