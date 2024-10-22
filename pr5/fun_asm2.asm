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
**    Code file for project 5
		void sortRecursive(int arr[], int start, int size){
			int min = arr[start], index = start;
			for(int i = start + 1; i < size;i++){
				if(arr[i] < min){
					min = arr[i]
					index = i;
				}
			}
			if (index > start){
                temp = arr[start];
                arr[start] = arr[index];
                arr[index] = temp;
            }
            start++;
            if(size - start > 1)
            	sortRecursive(arr[], start, size);
		}
**
**-------------------------------------------------------------------*/



.global sortRecursive
.extern _stack

sortRecursive:
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

 	mv s1, a0                 //arr[] in s1
 	mv s2, a1                 //start in s2
 	mv s3, a2                 //size in s3
 	addi s4, s2, 1             //start + 1 = i in s4
 	slli t1, s2, 2            //start*4
 	add s5, s1, t1            // address of arr[start] in s5
 	lw s6,0(s5)               //value of arr[start] = min in s6
 	mv s7, s2                 // index in s7
 for:
 	bge s4, s3, end_for       //if i>= to size, goes to end_for
 	slli t1, s4, 2            //i*4 in t1
 	add s8, s1, t1            //s8 has the address of arr[i]
 	lw t3,0(s8)               //value of arr[i] in t3
 	blt t3, s6, for_if        //if arr[i] < min then go to for_if
 	addi s4, s4, 1            //i++
 	j for

 for_if:
 	mv s6, t3                 //min = arr[i]
 	mv s7, s4                 //index = i
 	addi s4, s4, 1            //i++
 	j for

 end_for:
 	ble s7, s2, if            //if index <= start, then if
 	lw t6,0(s5)               //value of tmp = arr[start]  in t6
 	sw s6, 0(s5)              //arr[start] = min = arr[index]
 	slli t1, s7, 2            //index * 4
 	add t2, s1, t1            //adress of arr[index] in t2
 	sw t6, 0(t2)              // arr[index] = tmp
if:
	addi s2, s2, 1           //start++
	sub t2, s3, s2           //in t2 = size - start
	li t3, 1                 // t3 = 1
	ble t2, t3, end
	mv a2, s2
	call sortRecursive

 end:
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

 square_array://void square_array(arr[], size)
 #prologue
 	addi sp,sp,-20
	sw s1,0(sp)
 	sw s2,4(sp)
 	sw s3,8(sp)
 	sw s4,12(sp)
 	lw ra,16(sp)
 	mv s1, a0      //arr[] in s1
 	mv s2, a1      //size in s2
 	li s3, 0       //int i= 0, s3

 square_array_for:
 	beq s2, s3, end_square_array //if i == size, for loop ends
 	slli t1, s3, 2               //i*4
 	add s4, s1, t1               //address of arr[i] in s4
 	lw a0,0(s4)                  //value of arr[i] in a0
 	lw a1,0(s4)                  //value of arr[i] in a1
 	call mul                     //mul(arr[i], arr[i])
 	sw a0, 0(s4)                 //saving the squared value in the array
 	addi s3, s3, 1               //i++
 	j square_array_for

 end_square_array:
	#epilogue
	lw s1,0(sp)
 	lw s2,4(sp)
 	lw s3,8(sp)
 	lw s4,12(sp)
 	lw ra,16(sp)
 	addi sp,sp,20
 	ret

 mul:
 	mul a0, a0, a1
 	ret
