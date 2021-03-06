#!/usr/ruby/bin

#Given a sorted array, remove the duplicates in place such that each element appear only once and return the new length.
#
#Do not allocate extra space for another array, you must do this in place with constant memory.
#
#For example,
#Given input array nums = [1,1,2],
#
#Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively. It doesn't matter what you leave beyond the new length.


def removeDuplicates(nums)
  if nums.nil? then
    0
  elsif nums.size<2 then
    nums.size
  else
    slow = fast = 1
    while fast<nums.size do
      if not nums[fast]==nums[fast-1] then
        nums[slow] = nums[fast]
        slow += 1
      end
      fast += 1
    end
    slow
  end
end

[
  [],
  [1,1,2],
].each{ |x| 
  puts "#{x} : #{removeDuplicates x}"
}
