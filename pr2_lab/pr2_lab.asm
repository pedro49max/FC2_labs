/*---------------------------------------------------------------------
**
**  File:
**    pr2_lab.asm  19/10/2022
**
**    (c) Daniel Báscones García
**    Introduction to Computers II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Purpose:
**    Code file for project 2_lab
**
**  Design notes:
**
**-------------------------------------------------------------------*/

.global main
.equ N , 8
.equ INT_MAX , 65536

.data
V: 	 .word -7 ,3 , -9 ,8 ,15 , -16 ,0 ,3
.bss
W: 	 .space N *4
Y:   .space N *4
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
mv s1,t0              //min=s1=INT_MAX (min=s1)
li s2,-1              //i=s2=-1 (i=s2)

for2:
addi s2,s2,1           //i++
beq s2,t1,cacho        //i=N salta al cacho
la t3,V               // base of v  in t3
slli t4,s2,2          //i*4
add t5,t3,t4           //dm de v[i] en t5
lw s3,0(t5)            //valor de v[i] en s3
bge s3,s1,for2        // si v[i]>=min
mv s1,s3             // min=v[i]
mv  s4,s2            //s4=index=i (s4=index)
j for2

cacho:
slli t4,s4,2          //index*4
add t5,t3,t4           //dm de v[index] en t5
lw s3,0(t5)            // valor de v[index] en s3
la t6,W               // base of W  in t6
la s6,Y                //base of Y in s6
slli t4,s0,2          //j*4
addi s7,t1,-1           //N-1
sub s7,s7,s0            //(N-1)-j
slli s7,s7,2            //N-1-j *4
add s7,s6,s7            //dm Y[N-1-j] en s7
add s5,t6,t4           //dm de w[j] in s5
sw s3,0(s5)            // w[j] = v[index]
sw  s3,0(s7)           // Y[N-1-j]=V[index]
sw t0,0(t5)            //v[index] = int_max
j for

exit:
j exit
