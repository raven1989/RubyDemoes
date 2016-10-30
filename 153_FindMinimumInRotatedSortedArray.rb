#!/usr/ruby/bin
#
#Suppose a sorted array is rotated at some pivot unknown to you beforehand.
#
#(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
#
#Find the minimum element.
#
#You may assume no duplicate exists in the array.
#
#默认了数组都是升序

# related: 33

def searchMin(nums)
  if not nums.nil? and nums.size>0 then
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
    nums[left]
  end
end

[
  [0,1,2,3,4,5],
  [4,5,0,1,2,3],
  [3,5,6,3],
  [3,3,3,3],
].each{|x|
  puts "#{x} : #{searchMin x}"
}
