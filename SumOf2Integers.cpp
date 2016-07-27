#include<iostream>
using namespace std;
/* Calculate the sum of two integers a and b, but you are not allowed to use the operator + and -. */

// Example:
/* Given a = 1 and b = 2, return 3. */
int sum(int a, int b){
	if(b==0) return a;
	int base = a^b;
	int carrier = (a&b) << 1;
	return sum(base, carrier);
}

int main(){
	int a=0, b=0;
	cin >> a >> b; 
	cout << a << "+" << b << " = " << sum(a,b) << endl;
	return 0;
}
