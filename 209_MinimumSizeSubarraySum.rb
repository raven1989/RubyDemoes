#!/usr/ruby/bin
#
#Given an array of n positive integers and a positive integer s, find the minimal length of a subarray of which the sum ≥ s. If there isn't one, return 0 instead.
#
#For example, given the array [2,3,1,2,4,3] and s = 7,
#the subarray [4,3] has the minimal length under the problem constraint.
#
# Satisfied Window Question

def minSubarray(s, nums)
  if nums.nil? or nums.size==0 then
    return 0
  end
  sum = 0
  left = 0
  minSize = nums.size
  res = 0
  (0...nums.size).each{ |i|
    sum += nums[i]
    if sum>=s then
      # 收缩左边
      while left<=i and sum-nums[left]>=s do
        sum -= nums[left]
        left +=1
      end
      windowSize = i-left+1
      if windowSize<=minSize then
        res = minSize = windowSize
      end
      # window 左边往前移动一位
      sum -= nums[left]
      left += 1
    end
  }
  res
end

[
  [100, []],
  [7, [2,3,1,2,4,3]],
  [15, [1,2,3,4,5]],
].each{ |x|
  puts "#{x[0]}, #{x[1]} : #{minSubarray x[0],x[1]}"
}
