/* Reverse digits of an integer.
 * 
 * Example1: x = 123, return 321
 * Example2: x = -123, return -321
 * 
 * click to show spoilers.
 * 
 * Have you thought about this?
 * Here are some good questions to ask before coding. Bonus points for you if you have already thought through this!
 * 
 * If the integer's last digit is 0, what should the output be? ie, cases such as 10, 100.
 * 
 * Did you notice that the reversed integer might overflow? Assume the input is a 32-bit integer, then the reverse of 1000000003 overflows. How should you handle such cases?
 * 
 * For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows. */

#include<stdio.h>
#include<limits.h>
#include<stdlib.h>

int reverse(int x){
	int y = 0;
	while(x!=0){
		if(INT_MAX/10<y || INT_MIN/10>y){
			return 0;
		}
		y = y*10+x%10;
		x /= 10;
	}
	return y;
}

int main(int argc, char* argv[]){
	int x = atoi(argv[1]);
	printf("x : %d\n",reverse(x));
	return 0;
}
