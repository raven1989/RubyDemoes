#!/usr/bin/ruby
#
#Given an array S of n integers, find three integers in S such that the sum is closest to a given number, target. Return the sum of the three integers. You may assume that each input would have exactly one solution.
#
#    For example, given array S = {-1 2 1 -4}, and target = 1.
#
#    The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
#
# 去找两个值：
# 1.小于target的最大值
# 2.大于target的最小值
# 下面这个方法是O(n^2)的

def threeSumClosest(nums, target)
	sorted = nums.sort
	closest = nil
	i = 0
	while i<nums.size do
		t = target-sorted[i]
		tmp = twoSumClosest(sorted[i+1,sorted.size-i-1], t)
		if not tmp.nil?
			tmp += sorted[i]
			if tmp==target then
				return target
			elsif closest.nil? then
				closest = tmp
			else
				closest = (closest-target).abs<(tmp-target).abs ? closest : tmp
			end
		end
		i += 1
	end
	closest
end

def twoSumClosest(sorted, target)
	i = 0
	j = sorted.size-1
	max_lt_t = nil
	min_gt_t = nil
	while i<j do
		tmp = sorted[i]+sorted[j]
		if tmp==target then
			return tmp
		elsif tmp<target then
			i += 1
			if max_lt_t.nil? || tmp>max_lt_t then
				max_lt_t = tmp
			end
		else
			j -= 1
			if min_gt_t.nil? || tmp<min_gt_t then
				min_gt_t = tmp
			end
		end
	end
	if not max_lt_t.nil? and not min_gt_t.nil? then
		(max_lt_t-target).abs<(min_gt_t-target).abs ? max_lt_t : min_gt_t
	else
		max_lt_t || min_gt_t
	end
end

[
	[[-1,2,1,-4], 1],
].each{|x|
	puts "#{x[0]} by target #{x[1]} : #{threeSumClosest x[0],x[1]}"
}
