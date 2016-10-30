#!/usr/ruby/bin
#
#Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
#
#You may assume no duplicates in the array.
#
#Here are few examples.
#[1,3,5,6], 5 → 2
#[1,3,5,6], 2 → 1
#[1,3,5,6], 7 → 4
#[1,3,5,6], 0 → 0
#
#默认数组是升序的
#这个问题就是找到第一个大于等于target的数

def search(nums, target)
  if nums.nil? or nums.size<1 then
    0
  else
    left = 0
    right = nums.size-1
    while left<right do
      mid = left+(right-left)/2
      if nums[mid]==target then
        return mid
      elsif nums[mid]>target then
        right = mid
      else
        left = mid+1
      end
    end
    #处理target比所有的数都大的情况
    nums[left]<target ? left+1 : left
  end
end

[
  [[1,3,5,6], 5],
  [[1,3,5,6], 2],
  [[1,3,5,6], 7],
  [[1,3,5,6], 0],
].each{|x|
  puts "find #{x[1]} in #{x[0]} : #{search(x[0], x[1])}"
}
