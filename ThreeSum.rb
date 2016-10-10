#!/usr/bin/ruby
#
#Given an array S of n integers, are there elements a, b, c in S such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.
#
#Note: The solution set must not contain duplicate triplets.
#
#For example, given array S = [-1, 0, 1, 2, -1, -4],
#
#A solution set is:
#[
#  [-1, 0, 1],
#  [-1, -1, 2]
#]

def threeSum(nums)
	sorted = nums.sort
	res = []
	last = nil
	(0...sorted.size).each{ |i| 
		cur = 0-sorted[i]
		if last.nil? || last!=cur then
			(twoSum sorted[i+1,sorted.size-i-1],last=cur).each{ |x|
				res << ([sorted[i]]+x)
			}
		end
	}
	return res.uniq
end

def twoSum(sorted, target)
	i = 0
	j = sorted.size-1
	res = []
	while i<j do
		if sorted[i]>target then
			break
		end
		tmp = sorted[i]+sorted[j]
		if tmp<target then
			i += 1
		elsif tmp>target then
			j -= 1
		else
			res << [sorted[i],sorted[j]]
			i += 1
			j -= 1
		end
	end
	return res
end

[
	[],
	[-1, 0, 1, 2, -1, -4],
	[-1, 0, 0, 0, 0, 0],
].each{|x|
	puts "#{x} : #{threeSum x}"
}
