#!/usr/bin/ruby

#Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
#
#For example, given nums = [0, 1, 0, 3, 12], after calling your function, nums should be [1, 3, 12, 0, 0].
#
#Note:
#You must do this in-place without making a copy of the array.
#Minimize the total number of operations.
#

def moveZeroes(nums)
  slow = fast = 0
  while fast<nums.size do
    if not nums[slow]==0 then
      slow += 1
    elsif nums[fast]!=0 then
      nums[slow] ^= nums[fast]
      nums[fast] ^= nums[slow]
      nums[slow] ^= nums[fast]
      slow += 1
    end
    fast += 1
  end
end

nums = [0,1,0,3,12]
ori = Array.new(nums)
moveZeroes nums
puts "#{ori} : #{nums}"
