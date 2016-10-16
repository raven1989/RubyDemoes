//Divide two integers without using multiplication, division and mod operator.
//If it is overflow, return MAX_INT.
//
//除法的本质是减法，但是给dividend一个一个去减会得到TLE，所以指数增长减divisor的个数
//比如：13/3
//3<<1=6<<1=12<<1=18，18比13大了，所以先减去12=3<<2，左移两次相当于乘了1<<2个3, 
//将4个3从13里面减去，13-12=1
//用1再来一遍上述过程，等到0
//所以最后是 1<<2 + 0 = 4
#include<iostream>
#include<climits>
#include<cstdlib>
using namespace std;

int divide(int dividend, int divisor){
  if(divisor==0 || dividend==INT_MIN&&divisor==-1){
    return INT_MAX;
  }
  int sign = (dividend<0)^(divisor<0);
  //这里用long是必须的，如果用int的话对于任意的x<INT_MAX, INT_MAX/x都会死循环
  long absDividend = labs(static_cast<long>(dividend));
  long absDivisor = labs(static_cast<long>(divisor));
  int res = 0;
  while(absDividend>=absDivisor){
    int cur = 1;
    long multiple = absDivisor;
    //用long是必须的，如果用int的话对于任意的x<=INT_MAX, INT_MAX/x都会死循环
    //因为对任意的x<=INT_MAX而言，x无论如何左移都<=INT_MAX
    while((multiple<<1)<=absDividend){
      multiple <<= 1;
      cur <<= 1;
    }
    absDividend -= multiple;
    res += cur;
  }
  return sign ? 0-res : res;
}

int main(){
  int dividend, divisor;
  cin >> dividend >> divisor;
  cout << dividend << "/" << divisor << " = " << divide(dividend, divisor) << endl;
  return 0;
}
