#!/usr/ruby/bin

#Given an array and a value, remove all instances of that value in place and return the new length.
#
#Do not allocate extra space for another array, you must do this in place with constant memory.
#
#The order of elements can be changed. It doesn't matter what you leave beyond the new length.
#
#Example:
#Given input array nums = [3,2,2,3], val = 3
#
#Your function should return length = 2, with the first two elements of nums being 2.

def removeElement(nums, val)
  if nums.nil? then
    0
  else
    fast = slow = 0
    while fast < nums.size do
      if not nums[fast]==val then
        nums[slow] = nums[fast]
        slow += 1
      end
      fast += 1
    end
    slow
  end
end

[
  [[],9],
  [[3,2,2,3],3],
].each{ |x|
  puts "#{x[0]} remove #{x[1]} : #{removeElement x[0], x[1]}"
}
