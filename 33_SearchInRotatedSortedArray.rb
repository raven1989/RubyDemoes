#!/usr/ruby/bin
#
#Suppose a sorted array is rotated at some pivot unknown to you beforehand.
#
#(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
#
#You are given a target value to search. If found in the array return its index, otherwise return -1.
#
#You may assume no duplicate exists in the array.
#
#这道题默认了数组是升序
#所以先找到最小值，也就是有序数组真实的头
#然后再利用二分查找，通过(i+head)%nums.size是真正的mid值来进行正常的移动左右游标

def search(nums, target)
  if nums.nil? then
    -1
  else
    left = 0
    right = nums.size-1
    while left<right do
      mid = left+(right-left)/2
      if nums[mid]>nums[right] then
        left = mid+1
      else
        right = mid
      end
    end
    head = left
    left = 0
    right = nums.size-1
    while left<=right do
      mid = left+(right-left)/2
      realMid = (mid+head)%nums.size
      if nums[realMid]==target then
        return realMid
      elsif nums[realMid]<target then
        left = mid+1
      else
        right = mid-1
      end
    end
    -1
  end
end

def searchByOn(nums, target)
  nums.index(target)||-1
end


[
  [[1,2,3,4,5], 4],
  [[1,2,3,4,5], 6],
  [[4,5,6,7,0,1,2], 6],
  [[5,1,3], 5],
].each{ |x|
  puts "find #{x[1]} in #{x[0]} : #{search(x[0],x[1])} check:#{searchByOn(x[0],x[1])}"
}
