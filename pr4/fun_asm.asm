/*---------------------------------------------------------------------
**
**  File:
**    fun_asm.asm  19/10/2022
**
**    (c) Daniel Báscones García
**    Introduction to Computers II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Purpose:
**    Code file for project 4
**
**-------------------------------------------------------------------*/


//fill with the .extern and .global directives
//with the appropriate functions
//int eucl_dist(int * w, int size);

.extern mul
.extern i_sqrt
.global eucl_dist
.global save

eucl_dist:
#prologue
 	addi sp,sp,-36
	sw s1,0(sp)
 	sw s2,4(sp)
 	sw s3,8(sp)
 	sw s4,12(sp)
 	sw s5,16(sp)
 	sw s6,20(sp)
 	sw s7,24(sp)
 	sw s8,28(sp)
 	sw ra,32(sp)


 #body
 mv s8,a0     //v base in s8
 mv s1,a0     //w base in s1
 mv s2,a1     //n in s2
 mv s3,zero   //acc in s3
 mv s4,zero    //i in s4

 DOTFOR:
 bge s4,s2,FIN_DOTFOR
 slli s5,s4,2
 add s5,s5,s1
 lw s7,0(s5)    //W[i] in s8
 slli s5,s4,2
 add s5,s8,s5
 lw s6,0(s5)   //V[i] in s6
 mv a0,s6
 mv a1,s7
 call mul
 add s3,s3,a0
 addi s4,s4,1
 j DOTFOR

 FIN_DOTFOR:
 mv a0,s3
 call i_sqrt

 #epilogue
	lw s1,0(sp)
 	lw s2,4(sp)
 	lw s3,8(sp)
 	lw s4,12(sp)
 	lw s5,16(sp)
 	lw s6,20(sp)
 	lw s7,24(sp)
 	lw s8,28(sp)
 	lw ra,32(sp)
 	addi sp,sp,36
 	ret



//int save(char value, char * location);
save:
#prologue
    addi sp,sp,-8
	sb s1,0(sp)
 	sw s2,4(sp)
    //the value is received in a0, and the destination address in a1
    //make sure that only ONE BYTE is saved!!
    mv s1,a0
    mv s2,a1
    sb s1,0(s2)

#epilogue
	lb s1,0(sp)
 	lw s2,4(sp)
 	addi sp,sp,8
 	ret
    /*
void save(char value, char * location) {
	*location = value;
}
*/
