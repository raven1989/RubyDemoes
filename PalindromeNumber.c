/* Determine whether an integer is a palindrome. Do this without extra space.
 * 
 * click to show spoilers.
 * 
 * Some hints:
 * Could negative integers be palindromes? (ie, -1)
 * 
 *   If you are thinking of converting the integer to string, note the restriction of using extra space.
 * 
 *   You could also try reversing an integer. However, if you have solved the problem "Reverse Integer", you know that the reversed integer might overflow. How would you handle such case?
 * 
 *   There is a more generic way of solving this problem. */

#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>

/* 反转一半的数字，判断是否相等 */
bool isPalindrome(int x){
	/* 处理形如1210这样的数字 */
	if(x<0 || (x!=0 && x%10==0)){
		return false;
	}
	int y = 0;
	while(x>y){
		y = y*10+x%10;
		x /= 10;
	}
	/* 分别处理位数为偶数和奇数的情况 */
	return (x==y || x==y/10);
}

int main(int argc, char* argv[]){
	int x = atoi(argv[1]);
	printf("%d : %s\n",x,(isPalindrome(x) ? "true":"fasle"));
	return 0;
}
