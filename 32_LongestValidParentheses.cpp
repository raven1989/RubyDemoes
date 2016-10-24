/* Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.
 * 
 * For "(()", the longest valid parentheses substring is "()", which has length = 2.
 * 
 * Another example is ")()())", where the longest valid parentheses substring is "()()", which has length = 4. */

/* 利用栈来匹配括号
 * 1. 考虑一对valid parentheses：()
 *    压栈(，遇到)弹栈，每弹一次len+=2，直到不能弹栈为止，此时栈的大小为0，用v[0]这个索引记住len
 * 2. 考虑多对valid parentheses：()()()
 *    与上面的情况相同，每次都会更新v[0] += len
 * 3. 考虑嵌套：(())
 *    按照上面的逻辑，会连续弹栈两次，所以len+=4，同样更新v[0]+=len
 * 4. 考虑组合：((()()()))
 *    首先会压栈：((( stack.size=3，遇到第一个)，然后弹栈一次，更新v[2]+=2
 *    此时栈为：(( stack.size=2，然后遇到下一对()，压栈弹栈后stack.size还是2，所以更新v[2]+=2
 *    此时栈为：(( stack.size=2，然后遇到下一对()，压栈弹栈后stack.size还是2，所以更新v[2]+=2
 *    接下来连续两个))，连续两次弹栈：stack.size=0，此时更新v[0]+=4
 *    此时v={4,0,6}，显然应该将4和6加起来得到10
 *    结论：如果一次更新v[i]的操作结束后，对于j>i，如果v[j]!=0，则应该将所有的v[j]累加到v[i]，然后将v[j]清零
 *    因为嵌套的缘故，所以会将多组valid parentheses分散到不同的深度i上去
 * 5. 考虑invalid的括号，这样的括号可能是(，也可能是)，比如：((), )()，所以除了(一定压栈外，栈为空或者栈顶是)时)也要压栈
 *    这种括号因为无法匹配到，所以会一直留在栈中，因此会将不同合法的括号解组分隔开来：
 *    如果是一组合法的括号解，那么最终肯定会更新到v[0]，而其他位数字都是0；
 *    当其中有一个非法括号时，会有两组解，第一组解更新到v[0]，第二组解更新到v[k] (k=非法括号索引+1)
 *    因为合法组解最终会弹栈到这些位置 */

#include<iostream>
#include<vector>
#include<stack>
#include<sstream>
using namespace std;

string printHelper(const vector<int>&);

int longestValidParentheses(const string& str){
  int res = 0;
  if(str.size()<=0){
    return res;
  }
  vector<int> v(str.size());
  // fill(v.begin(),v.begin()+v.size(),0);
  stack<char> s;
  int i=0;
  int maxSize = 0;
  string::const_iterator it=str.begin(); 
  while(it!=str.end()){
    if(*it=='('){
      s.push(*it++);
    }else{
      int len=0;
      if(s.empty() || s.top()==')'){
        s.push(*it++);
        continue;
      }
      while(!s.empty() && it!=str.end() 
          && s.top()=='(' && *it==')'){
        len += 2;
        s.pop();
        ++it;
      }
      v[s.size()] += len;
      if(maxSize>s.size()){
        for(int j=maxSize; j>s.size(); --j){
          v[s.size()] += v[j];
          v[j] = 0;
        }
      }
      maxSize=s.size();
      if(v[s.size()]>res){
        res = v[s.size()];
      }
    }
  }
  /*for(vector<int>::const_iterator vit=v.begin(); vit!=v.end(); ++vit){
    if(*vit>res){
    res = *vit;
    }
    }*/
  return res;
}

string printHelper(const vector<int>& v){
  ostringstream oss;
  for(vector<int>::const_iterator it=v.begin(); it!=v.end(); ++it){
    oss << *it << " ";
  }
  return oss.str();
}

int main(){
  string str;
  cin >> str;
  cout << str << " : " << longestValidParentheses(str) << endl;
}
