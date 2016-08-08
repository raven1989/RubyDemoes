 /* Given a non-empty 2D matrix matrix and an integer k, find the max sum of a rectangle in the matrix such that its sum is no larger than k.
  * 
  * Example:
  * Given matrix = [
  *   [1,  0, 1],
  *     [0, -2, 3]
  *     ]
  *     k = 2
  *     The answer is 2. Because the sum of rectangle [[0, 1], [-2, 3]] is 2 and 2 is the max number no larger than k (k = 2).
  * 
  *     Note:
  *     The rectangle inside the matrix must have an area > 0.
  *     What if the number of rows is much larger than the number of columns?
  * 
  *     Brutal Force
  *     优化了从一个数组找到小于k的最大子序列和，n*logn
  *     整个是 m^2*n*logn */

#include<iostream>
#include<set>
#include<vector>
using namespace std;

int maxSubarrayLtK(vector<int>& array, int k);

 /* 问题首先落在如何遍历所有的submatrix，m x m的matrix总共有 Σn * Σm个，Σi 表示1到i的和
  * 这样考虑，对于n行的矩阵，取i=1行，有1-n共n行
  * 取 i=2 有 12, 23, 34, ..., n-1n 共n-1行
  * 以此类推，最后一个就是n行，只有一个
  * 固行有 1+...+n 种情况
  * 对于列，同理可得有 1+...+m 种情况，
  * 所以，总共有 Σn * Σm 个submatrix
  * 
  * 遍历的话，从第一行开始，找出subarrayLtK，然后将第二行加到第一行再执行subarrayLtk，然后将第三行加上去依次类推直到加上最后一行
  * 然后，对第二行执行以上的过程，直到最后一行 */
int maxSubmatrixLtK(vector<vector<int> >& matrix, int k){
	int row = matrix.size();
	if(row<=0) return INT_MIN; 
	int col = matrix[0].size();
	int max = INT_MIN;
	if(row<col){
		vector<int> tmp(col);
		for(int i=0; i<row; i++){
			fill(tmp.begin(), tmp.end(), 0);
			for(int d=i; d<row; d++){
				for(int j=0; j<col; j++){
					tmp[j] += matrix[d][j];
				}
				/* for(vector<int>::iterator it=tmp.begin(); it!=tmp.end(); ++it){
				 *   cout << *it << " ";
				 * }
				 * cout << endl; */
				int r = maxSubarrayLtK(tmp, k);
				if(r==k) return k;
				if(r<k && r>max){
					max = r;
				}
			}
		}
	}else{
		vector<int> tmp(row);
		for(int j=0; j<col; j++){
			fill(tmp.begin(), tmp.end(), 0);
			for(int d=j; d<col; d++){
				for(int i=0; i<row; i++){
					tmp[i] += matrix[i][d];
				}
				int r = maxSubarrayLtK(tmp, k);
				if(r==k) return k;
				if(r<k && r>max){
					max = r;
				}
			}
		}
	}
	return max;
} 

 /* 问题归结为如何求数组的最大不超过k子序列和：
  * 获得一个前i项和的序列，那么对于任意的sj-si就表示子序列a(i+1)-aj的和，sj-0表示a0-aj的和
  * 要满足的条件有
  * 	i<j
  * 	sj-si<=k => sj-k<=si
  * 	想要sj-si尽量逼近k，也就是让sj-k尽量逼近si，利用二叉搜索树
  * 	遍历j 0->s.size-1，对于任意的sj，在si中找出最接近但大于等于sj-k的si，i取值为[0,j)
  * 	lower_bound满足这个需求 ... , sj-k, [lower_bound ...
  * 	upper_bound返回同一个东西，但是不包含等于，... , sj-k, (upper_bound ... */
int maxSubarrayLtK(vector<int>& array, int k){
	int max = INT_MIN;
	vector<int> sums(array.size());
	int sum = 0;
	for(int i=0; i<sums.size(); i++){
		sum += array[i];
		sums[i] = sum;
	}
	set<int> rbt;
	rbt.insert(0);
	set<int>::iterator sit = rbt.end();
	for(vector<int>::iterator it=sums.begin(); it!=sums.end(); ++it){
		sit = rbt.lower_bound((*it)-k);
		if(sit!=rbt.end()){
			int tmp = (*it) - (*sit);
			if(tmp==k) return k;
			if(tmp<k && tmp>max) max=tmp;
		}
		rbt.insert(*it);
	}
	return max;
}

int main(){
	int a0[] = {1, 0, 1};
	vector<int> v0(a0, a0+sizeof(a0)/sizeof(int));
	int a1[] = {0, -2, 3};
	vector<int> v1(a1, a1+sizeof(a1)/sizeof(int));
	// cout << maxSubarrayLtK(v1, -1) << endl;
	vector<vector<int> > m;
	m.push_back(v0);
	m.push_back(v1);
	cout << maxSubmatrixLtK(m, 2) << endl;
	return 0;
}

