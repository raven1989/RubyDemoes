#!/usr/bin/ruby
#
#Given a sorted array of integers, find the starting and ending position of a given target value.
#
#Your algorithm's runtime complexity must be in the order of O(log n).
#
#If the target is not found in the array, return [-1, -1].
#
#For example,
#Given [5, 7, 7, 8, 8, 10] and target value 8,
#return [3, 4].
#
#related 278
#
#将问题分解为两个子问题
#1. find数组中第一个target的索引
#2. rfind数组中倒数第一个target的索引

def searchRange(nums, target)
  if nums.nil? or nums.size<1 then
    [-1,-1]
  else
    l = -1
    r = -1
    #找左边界
    left = 0
    right = nums.size-1
    while left<right do
      mid = left+(right-left)/2
      if nums[mid]<target then
        left = mid+1
      else
        right = mid
      end
    end
    if nums[left]==target then
      l = left
    else
      return [l,r]
    end
    #找右边界
    left = 0
    right = nums.size-1
    while left<right do
      #让mid偏右边的值，这样就不会出现死循环
      #比如 1,2 找1
      mid = left+(right-left+1)/2
      if nums[mid]>target then
        right = mid-1
      else
        left = mid
      end
    end
    if nums[left]==target then
      r = left
    end
    [l,r]
  end
end

[
  [[5,7,7,8,8,10], 8],
  [[1], 0],
].each{|x|
  puts "find #{x[1]} in #{x[0]} : #{searchRange x[0],x[1]}"
}
