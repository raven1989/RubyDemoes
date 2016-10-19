// Given an array nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.
//
// For example,
// Given nums = [1,3,-1,-3,5,3,6,7], and k = 3.
//
// Window position                Max
// ---------------               -----
// [1  3  -1] -3  5  3  6  7       3
// 1 [3  -1  -3] 5  3  6  7       3
// 1  3 [-1  -3  5] 3  6  7       5
// 1  3  -1 [-3  5  3] 6  7       5
// 1  3  -1  -3 [5  3  6] 7       6
// 1  3  -1  -3  5 [3  6  7]      7
// Therefore, return the max sliding window as [3,3,5,5,6,7].

#include<iostream>
#include<vector>
#include<deque>
#include<sstream>
using namespace std;

vector<int> maxInSlidingWindow(vector<int>& nums, int k){
  if(nums.size()<=0){
    vector<int> res(0);
    return res;
  }
  int resSize = nums.size()-k+1;
  if(resSize<1){ resSize=1; }
  vector<int> res(resSize);
  int ri = 0;
  int i=0;
  deque<int> dq;
  while(i<nums.size()){
    int windowLeft = i-k+1;
    if(!dq.empty()){
      int cur = nums[i];
      while(!dq.empty() && (dq.front()<windowLeft || nums[dq.front()]<=cur)){
        dq.pop_front();
      }
      while(!dq.empty() && nums[dq.back()]<=cur){
        dq.pop_back();
      }
    }
    dq.push_back(i++);
    if(windowLeft>=0 || i==nums.size() ){
      res[ri++]=nums[dq.front()];
    }
  }
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
  int a[] = {1,3,-1,-3,5,3,6,7};
  vector<int> nums(a,a+sizeof(a)/sizeof(int));
  cout << printHelper(nums) << " : " << printHelper(maxInSlidingWindow(nums, 3)) << endl;
  cout << printHelper(nums) << " : " << printHelper(maxInSlidingWindow(nums, 10)) << endl;
  return 0;
}
