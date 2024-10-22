/*---------------------------------------------------------------------
**
**  File:
**    pr5.c  19/10/2022
**
**    (c) Daniel Báscones García
**    Introduction to Computers II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Purpose:
**    Code file for project 5
**
**-------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>

#define TRUE 1
#define FALSE 0
extern void cocktailSort(int arr[], int size);
extern void sortRecursive(int arr[], int start, int size);

#define N 5
int main()
{
    //int i;

    //printf("Enter the size of the array: ");
    //scanf("%d", &n);
    int arr[N] = {5, 2, -3, 7, 6};

    /*for (i = 0; i < n; i++)
    {
        printf("Number #%d: ", i + 1);
        scanf("%d", &arr[i]);
    }

    printf("You entered:  ");
    for (i = 0; i < n; i++)
    {
        printf("%d ", arr[i]);
    }*/
    sortRecursive(arr, 0, N);
    int arra[N] = {7, 6, 5, 2, -1};
    cocktailSort(arra, N);
    //square_array(arr, N);
    //cocktailSort(arr, N);
    /*printf("\nSorted array: ");
    for (i = 0; i < n; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");

    free(arr);*/
    return 0;
}
