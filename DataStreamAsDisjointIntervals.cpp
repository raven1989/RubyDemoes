/* Given a data stream input of non-negative integers a1, a2, ..., an, ..., summarize the numbers seen so far as a list of disjoint intervals.
 * 
 * For example, suppose the integers from the data stream are 1, 3, 7, 2, 6, ..., then the summary will be:
 * 
 * [1, 1]
 * [1, 1], [3, 3]
 * [1, 1], [3, 3], [7, 7]
 * [1, 3], [7, 7]
 * [1, 3], [6, 7]
 * Follow up:
 * What if there are lots of merges and the number of disjoint intervals are small compared to the data stream's size? */

#include<iostream>
#include<algorithm>
#include<set>
#include<vector>
#include<sstream>

using namespace std;

/**
 * Definition for an interval.
 * struct Interval {
 *     int start;
 *     int end;
 *     Interval() : start(0), end(0) {}
 *     Interval(int s, int e) : start(s), end(e) {}
 * };
 */
struct Interval {
    int start;
    int end;
    Interval() : start(0), end(0) {}
    Interval(int s, int e) : start(s), end(e) {}
	friend ostream& operator<<(ostream& out, Interval& o);
};
ostream& operator<<(ostream& out, Interval& o){
	out << "(" << o.start << "," << o.end << ")";
	return out;
}
class SummaryRanges {
public:
    /** Initialize your data structure here. */
	struct IntervalComp{
		bool operator() (const Interval& a, const Interval& b){
			return a.end < b.start;
		}
	};
	typedef set<Interval, IntervalComp> IntervalSet;
    SummaryRanges() {
        
    }
    
    void addNum(int val) {
			int start, end;
			start = end = val;
			IntervalSet::iterator it = data_.lower_bound(Interval(start, end));
			IntervalSet::iterator rear = it;
			IntervalSet::iterator front = data_.end();
			if(rear!=data_.begin()){
				front = --it;
			}
			if(rear!=data_.end() && rear->start-1<=val){
				end = rear->end;
				start = min(start, rear->start);
			}else{
				rear = data_.end();
			}
			if(front!=data_.end() && front->end+1>=val){
				start = front->start;
				end = max(end, front->end);
			}else{
				front = data_.end();
			}
			if(rear!=data_.end()) data_.erase(rear);
			if(front!=data_.end()) data_.erase(front);
			data_.insert(Interval(start,end));
    }
    
    vector<Interval> getIntervals() {
      vector<Interval> res(data_.size());
			copy(data_.begin(), data_.end(), res.begin());
      return res;
    }
private:
  IntervalSet data_;
};

/**
 * Your SummaryRanges object will be instantiated and called as such:
 * SummaryRanges obj = new SummaryRanges();
 * obj.addNum(val);
 * vector<Interval> param_2 = obj.getIntervals();
 */
template<typename T>
string printHelper(const T & container){
	ostringstream oss;
	oss << "[";
	int idx = 0;
	for(typename T::const_iterator it=container.begin(); it!=container.end(); ++it){
		if(idx>0 && idx<container.size()){ 
			oss<<",";
		}
		idx++;
		typename T::value_type v = *it;
		oss << v;
	}
	oss << "]";
	return oss.str();
} 

int main(){
	SummaryRanges* obj = new SummaryRanges();
	obj->addNum(1);
	cout << printHelper<vector<Interval> >(obj->getIntervals()) << endl;
	obj->addNum(3);
	cout << printHelper<vector<Interval> >(obj->getIntervals()) << endl;
	obj->addNum(7);
	cout << printHelper<vector<Interval> >(obj->getIntervals()) << endl;
	obj->addNum(2);
	cout << printHelper<vector<Interval> >(obj->getIntervals()) << endl;
	obj->addNum(6);
	cout << printHelper<vector<Interval> >(obj->getIntervals()) << endl;
	return 0;
}
