/*---------------------------------------------------------------------
**
**  File:
**    pr1_a.asm  19/10/2022
**
**    (c) Daniel Báscones García
**    Introduction to Computers II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Purpose:
**    Code file for project 1a
**
**  Design notes:
**
**	# define N 10
**	int res = 0;
**	for (int i = 0; i < N ; i ++) {
**		res += i ;
**	}
**
**-------------------------------------------------------------------*/

//constant N is defined
.equ N, 10
//space reserved for the result
.bss
	res: 	.space 4
//program
.text
.global main
main:

    li t0, 0    //we use the address to load the value of i
    li t1, N    	//we use the address to load the value of N
    li t4, 0	//we use the address to load the value of res
for:
    beq t0, t1, end //if i == N fin
    add t4, t4, t0//res+=i
    addi t0, t0, 1
    j for

end:                //end of program
    la t5, res        //the address of res is loaded into t5
	sw t4, 0(t5)    //we store t4 (res) into res
    j end           //the program stays here forever
//Complete the code
