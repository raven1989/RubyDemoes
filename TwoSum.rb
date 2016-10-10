#!/usr/bin/ruby
#
#Given an array of integers, return indices of the two numbers such that they add up to a specific target.
#
#You may assume that each input would have exactly one solution.
#
#Example:
#Given nums = [2, 7, 11, 15], target = 9,
#
#Because nums[0] + nums[1] = 2 + 7 = 9,
#return [0, 1].

def twoSum(nums, target)
	sorted = (0...nums.size).sort{ |a,b| nums[a]<=>nums[b]}
	# puts "#{sorted}"
	i = 0
	j = sorted.size-1
	while i<j do
		tmp = nums[sorted[i]]+nums[sorted[j]]
		if tmp<target then
			i += 1
		elsif tmp>target then
			j -= 1
		else
			return [sorted[i],sorted[j]]
		end
	end
	return []
end

[
	[[2,7,11,5], 9],
].each{ |x| 
	puts "#{x[0]}, #{x[1]} : #{twoSum x[0],x[1]}"
}
