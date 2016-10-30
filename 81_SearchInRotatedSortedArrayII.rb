#!/usr/bin/ruby
#
#Follow up for "Search in Rotated Sorted Array":
#What if duplicates are allowed?
#
#Would this affect the run-time complexity? How and why?
#
#Write a function to determine if a given target is in the array.
#
#默认数组是升序
#related : 33,153
#
#知识一：首先考虑下对于有duplicates的有序数组仍然是可用二叉查找的
#比如1,1,1,1,2,3,4
#所以，目标还是要找到rotated之前数组的头
#
#1. 这种重复在中间的情况会有影响吗？
#   比如：3,1,1,1,2，二分查找第一个比right小的数字是3后面的1，事实上头也是它
#2. 只有重复数字分别位于rotated数组的头和尾的时候，普通的二分查找找出的头才会有问题：
#   比如：4,4,4,4,1,2,4
#   这个时候nums[mid]==nums[right]，不能用mid=right直接跳过mid后的数组，因为显然跳过了比nums[mid]小的数字
#   比如  1,1,1,2,1,1 也不能，因为跳过了真正的头，即2后面的1
#   对于这种头尾相同的情况，预处理一下，将其变成：
#   4,1,2,4
#   1,2,1
#   这两个数组因为nums[mid]!=nums[right]，所以不会出现误跳的情况，用普通的二分查找找到数组的头，然后再利用上面提到的第一个知识找target

def search(nums, target)
  if nums.nil? or nums.size<1 then
    false
  else
    left = 0
    right = nums.size-1
    if nums[left]==nums[right] then
      while right-1>left and nums[left]==nums[right-1] do
        right -= 1
      end
      while left+1<right and nums[right]==nums[left+1] do
        left += 1
      end
      #处理类似[1,1,1,1]的情况
      if left==right-1 then
        return nums[left]==target
      end
    end
    while left<right do
      #puts "#{left} #{right}"
      mid = left+(right-left)/2
      if nums[mid]>nums[right] then
        left = mid+1
      else
        right = mid
      end
    end
    head = left
    #puts "#{head}:#{nums[head]} #{head+1}:#{nums[head+1]}"
    left = 0
    right = nums.size-1
    while left<=right do
      mid = left+(right-left)/2
      realMid = (mid+head)%nums.size
      if nums[realMid]==target then
        return true
      elsif nums[realMid]<target then
        left = mid+1
      else
        right = mid-1
      end
    end
    false
  end
end

def searchByOn(nums, target)
  nums.index(target).nil? ? false : true
end

[
  [[1,2,3,4,5], 4],
  [[1,2,3,4,5], 6],
  [[4,5,6,7,0,1,2], 6],
  [[4,5,6,7,0,1,2], 3],
  [[5,1,3], 5],
  [[4,4,4,4,0,1,2,4], 4],
  [[3,1,1,1,1], 3],
  [[1,1,1,1,1,1,2,1,1,1], 2],
  [[1,1], 0],
  [[1,1,3], 3],
].each{ |x|
  puts "find #{x[1]} in #{x[0]} : #{search(x[0],x[1])} check:#{searchByOn(x[0],x[1])}"
}
