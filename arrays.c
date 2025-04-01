#include <stdio.h>
#include <stdbool.h>
void inputArray(int array[], int *n);
void printArray(int array[], int n);
void arrayDescending(int array[], int n );
bool isAllOdd(int array[], int n);
int search(int array[], int n, int x);
void displayPrimeNum(int array[], int n);
int main(){
    int array[100];
    int n = 0;
    bool running = true;
    int choice;
    while(running) {
        printf("MENU\n");
        printf("1 - Input the array\n");
        printf("2 - Output the array\n");
        printf("3 - Print out the array in descending order\n");
        printf("4 - Check if all elements of the array are odd\n");
        printf("5 - Search a value\n");
        printf("6 - Display elements that are prime numbers in the array\n");
        printf("7 - Quit\n");
        printf("Enter your option: ");
        scanf("%d",&choice);

        switch(choice) {
            case 1:
                inputArray(array,&n);
                break;
            case 2:
                printArray(array,n);
                break;
            case 3:
                arrayDescending(array, n);
                printf("Array in descending order: ");
                printArray(array,n);
                break;
            case 4:
                if(isAllOdd(array,n)){
                    printf("All elements are odd.\n");
                }else{
                    printf("Not all elements are off numbers.\n");
                }
                break;
            case 5:{
                int x;
                printf("Enter a value to search: ");
                scanf("%d", &x);
                int count = search(array,n,x);
                printf("Value %d appears %d times.\n",x,count);
                break;
            }
            case 6: 
                displayPrimeNum(array, n);
                break;
                
            case 7:{
                int confirm;
                printf("Are you sure? Enter 1 to exit.");
                scanf("%d", &confirm);
                if(confirm == 1){
                    running = false;
                    printf("Exiting the program.");
                } 
                break;
            }
            default:
                printf("Invalid input. Please check the menu again.\n");
        }

    }
    return 0;
}
void inputArray(int array[], int *n){
    printf("Enter number of elements: ");
    scanf("%d",n);
    printf("Enter %d elements (1-100): \n", *n);
    for(int i = 0; i < *n; i++){
        do {
            printf("Element %d: ", i+1);
            scanf("%d", &array[i]);
            if(array[i]<1|| array[i] > 100){
                printf("invalid element! Please numbers from1 to 100.\n");
        
            }
        }while (array[i] < 1 || array[i] > 100);
        
    }
}
void printArray(int array[], int n){
    printf("Array elements: ");
    for(int i = 0; i < n; i++){
        if( i == n - 1) {
        printf("%d", array[i]);
        } else{
            printf("%d, ", array[i]);
        }
    }
    printf("\n");
}
void arrayDescending(int array[], int n){
    for(int i = 0; i < n - 1;i++){
        for(int j = i +1; j < n;j++){
            if(array[i]<array[j]){
                int tmp = array[i];
                array[i] = array[j];
                array[j] = tmp;
            }
        }
    }
}
bool isAllOdd(int array[], int n){
    for(int i =0; i < n;i++){
        if (array[i] %2 == 0){
            return false;
        } 
    }
    return true;
}
int search(int array[], int n, int x){
    int count = 0;
    for(int i = 0; i <  n; i++){
        if(array[i] == x)
        count++;
    }
    return count;
}
bool isPrime(int n){
    if (n < 2)
        return false;
    for(int i = 2; i* i <= n; i++){
        if(n %i == 0)
        return false;
    }
    return true;
}
void displayPrimeNum(int array[], int n){
    printf("Prime numbers in the array: ");
    bool prime = false;
    for(int i = 0; i < n; i++) {
        if(isPrime(array[i])) {
            printf("%d ", array[i]);
            prime = true;
        }
    }
    if(!prime) {
        printf("None of the element in the array is prime\n");
    }
    printf("\n");
}