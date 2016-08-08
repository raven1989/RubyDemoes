#!/usr/bin/ruby
#You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.
#
#Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.

def nonadjointMaxSum(nums)
	dp = []
	(0...nums.size).each{ |i| 
		dp[i] = [nums[i]+(i-2<0 ? 0 : dp[i-2]), (i-1<0 ? 0 : dp[i-1])].max
		#puts "#{i} : #{dp[i]}"
	}
	dp[nums.size-1]||0
end

def rob(nums)
  before_last, last = 0, 0
  for i in nums do
    before_last, last = last, [before_last+i, last].max
  end
  last
end

[
	[1,2,3,4],
	[5,6,7,1,2],
	[2,1,1,3],
	[1,1]
].each{ |x| 
	puts "#{x} : #{nonadjointMaxSum x}"
	puts "#{x} : #{rob x}"
}
