#!/usr/bin/ruby
#
#Given an unsorted array of integers, find the length of longest increasing subsequence.
#
#For example,
#Given [10, 9, 2, 5, 3, 7, 101, 18],
#The longest increasing subsequence is [2, 3, 7, 101], therefore the length is 4. Note that there may be more than one LIS combination, it is only necessary for you to return the length.
#
#Your algorithm should run in O(n2) complexity.
#
#Follow up: Could you improve it to O(n log n) time complexity?
#
#
#noted that this solution can only return the size of increasing subsequence correctly instead of the subsequence, for example: [4,5,1]

def longestIncreasingSubseq(nums)
	res = []
	nums.each { |x| 
		index = (0...res.size).bsearch { |i| 
			res[i] >= x
		}
		res[index||res.size] = x
	}
	res.size
end

[
	[4,5,1],
	[10, 9, 2, 5, 3, 7, 101, 18]
].each {|x|
	puts "#{x} longest increasing subsequence size is #{longestIncreasingSubseq x}"
}
