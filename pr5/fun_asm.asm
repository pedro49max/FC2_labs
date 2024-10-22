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
**
/*
void cocktailSort(int arr[], int size)
{
    int i, changed = TRUE, temp, start = 0, end = size - 1;

    while (changed)
    {
        changed = FALSE;
        for (i = start; i < end; i++)
        {
            if (arr[i] > arr[i + 1])
            {
                temp = arr[i];
                arr[i] = arr[i + 1];
                arr[i + 1] = temp;
                changed = TRUE;
            }
        }
        end--;

        if (changed == FALSE)
        {
            break;
        }
        changed = FALSE;

        for (i = end - 1; i >= start; i--)
        {
            if (arr[i + 1] < arr[i])
            {
                temp = arr[i + 1];
                arr[i + 1] = arr[i];
                arr[i] = temp;
                changed = TRUE;
            }
        }
        start++;
    }
}*/
//-------------------------------------------------------------------



.global cocktailSort
.extern _stack

cocktailSort:
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

 	mv s1, a0      //arr[] in s1
 	mv s2, a1      //size in s2
 	li s3, 1       //changed = true
 	li s4, 0       //start = 0
 	addi s5, s2, -1//s5 = end = size-1
 while:
 	beqz s3, end_while //if changed = false, end_while
 	addi s3, s3, -1   //goes from true to false
 	mv s6, s4         //i = start
 inner_for:
 	bge s6, s5, end_inner_for //if i>= to end, goes to end_inner_for
 	slli t1, s6, 2            //i*4
 	addi t2, s6, 1            //i + 1
 	slli t2, t2, 2            //(i+ 1)*4
 	add s7, s1, t1            //s7 has the address of arr[i]
 	add s8, s1, t2            //s8 has the address of arr[i+1]
 	lw t3,0(s7)               //value of arr[i] in t3
 	lw t4,0(s8)               //value if arr[i+1] in t4
 	blt t4, t3, inner_for_if  //if arr[i+1] < arr[i] then go to inner_for_if
 	addi s6, s6, 1            //i++
 	j inner_for

 inner_for_if:
 	mv t5, t3                 //t5=tmp=arr[i]
 	sw t4, 0(s7)              //save value of arr[i+1] on address of arr[1]
 	sw t5, 0(s8)              //save value tmp on adrees of arr[i+1]
 	addi s3, s3, 1            //changed = true
 	addi s6, s6, 1            //i++
 	j inner_for

 end_inner_for:
 	addi s5, s5, -1           //end--
 	beqz s3, end_while         //if changed== false, then break
 	addi s3, s3, -1           //changed = false
 	mv s6, s5                 //i = end
 	addi s6, s6, -1           //i = end -1

 inner_for2:
	blt s6, s4, end_inner_for2 //if i < start, the go to end_inner_for2
	slli t1, s6, 2            //i*4
 	addi t2, s6, 1            //i + 1
 	slli t2, t2, 2            //(i+ 1)*4
 	add s7, s1, t1            //s7 has the address of arr[i]
 	add s8, s1, t2            //s8 has the address of arr[i+1]
 	lw t3,0(s7)               //value of arr[i] in t3
 	lw t4,0(s8)               //value if arr[i+1] in t4
 	blt t4, t3, inner_for2_if  //if arr[i+1] < arr[i] then go to inner_for_if
 	addi s6, s6, -1            //i--
 	j inner_for2

inner_for2_if:
	mv t5, t4                 //t5=tmp=arr[i+1]
 	sw t3, 0(s8)              //save value of arr[i] on address of arr[1+1]
 	sw t5, 0(s7)              //save value tmp on adrees of arr[i]
 	addi s3, s3, 1            //changed = true
 	addi s6, s6, -1           //i--
 	j inner_for2

end_inner_for2:
	addi s4, s4, 1            //start++
	j while

 end_while:
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
