/*---------------------------------------------------------------------
**
**  File:
**    pr3_a.asm  19/10/2022
**
**    (c) Daniel Báscones García
**    Introduction to Computers II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Purpose:
**    Code file for project 3a
**
**  Design notes:
**
**	int mul(int a, int b) {
**	    int res = 0;
**	    while (b > 0) {
**	        res += a;
**	        b--;
**	    }
**	    return res;
**	}
**
**	int dotprod(int V[], int W[], int n) {
**	    int acc = 0;
**	    for (int i = 0; i < n; i++) {
**	        acc += mul(V[i], W[i]);
**	    }
**	    return acc;
**	}
**
**	#define N 4
**	int A[] = {3, 5, 1, 9}
**	int B[] = {1, 6, 2, 3}
**
**	int res;
**
**	void main() {
**	    int normA = dotprod(A, A, N);
**	    int normB = dotprod(B, B, N);
**	    if (normA > normB)
**	        res = 0xa;
**	    else
**	        res = 0xb;
**	}
**
**-------------------------------------------------------------------*/

 .global main
 .extern _stack
 .equ N, 3
 .data
  A:   .word 3, 2, 1
  B:   .word 1,2,2

 .bss
  res: .space 4
  normA: .space 4
  normB: .space 4

 .text
 main:
    la sp,_stack
	la a0, A            //loading address of A in a0
	la a1, A            //loading address of A in a1
	li a2, N            //loading N into a2
	call DOTPROD        //dotprod(A[],A[],N)
	la t1,normA         //loading address of mormA in t1
 	sw a0,0(t1)         //normA = dotprod(A[],A[],N)
	la a0, B            //loading address of B in a0
	la a1, B            //loading address of B in a1
	call DOTPROD        //dotprod(B[],B[],N)
	la t2,normB         //loading address of mormB in t2
 	sw a0,0(t2)         //normB = dotprod(B[],B[],N)
 	lw s1, 0(t1)
 	lw s2, 0(t2)
	bge s2, s1, else    //if normB >= normA go to else
	la s3, res          //loading address of res
	li s1, 0xa          //loading the inmidiate 0xa
	sw s1, 0(s3)        //saving 0xa in res
	j END

else:
	la s3, res          //loading address of res
	li s2, 0xb          //loading the inmidiate 0xb
	sw s2, 0(s3)        //saving 0xb in res
	j END

END:
   j END





MUL:
	 #prologue
 	addi sp,sp,-16
	sw s1,0(sp)
 	sw s2,4(sp)
 	sw s3,8(sp)
 	sw s4,12(sp)


 	# body
 	mv s1,zero //res in s1
	mv s2,a0   //a in s2
	mv s3,a1   //b in s3
	mv s4,zero //0 in s4

MULFOR:
	beq s3, s4, ENDFORMUL // if b== 0, then go to end loop
	add s1, s1, s2        // res+= a
	addi s3, s3, -1       //b--
	j MULFOR

ENDFORMUL:
	 mv a0,s1      //return res;
	 #epilogue
 	lw s1,0(sp)
 	lw s2,4(sp)
 	lw s3,8(sp)
 	lw s4,12(sp)
 	addi sp,sp,16
 	ret

 DOTPROD:

 #prologue
 	addi sp,sp,-32
	sw s1,0(sp)
 	sw s2,4(sp)
 	sw s3,8(sp)
 	sw s4,12(sp)
 	sw s5,16(sp)
 	sw s6,20(sp)
 	sw s7,24(sp)
 	sw ra,28(sp)


 #body
 mv s5,a0     //v base in s5
 mv s1,a1     //w base in s1
 mv s2,a2     //n in s2
 mv s3,zero   //acc in s3
 mv s4,zero    //i in s4

 DOTFOR:
 bge s4,s2,FIN_DOTFOR
 lw s7,0(s1)    //W[i] in s7
 lw s6,0(s5)   //V[i] in s6
 mv a0,s6
 mv a1,s7
 call MUL
 add s3,s3,a0
 addi s4,s4,1
 addi s1,s1,4
 addi s5,s5,4
 j DOTFOR

 FIN_DOTFOR:
 mv a0,s3

 #epilogue
	lw s1,0(sp)
 	lw s2,4(sp)
 	lw s3,8(sp)
 	lw s4,12(sp)
 	lw s5,16(sp)
 	lw s6,20(sp)
 	lw s7,24(sp)
 	lw ra,28(sp)
 	addi sp,sp,32
 	ret
