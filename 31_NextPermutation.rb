#!/usr/bin/ruby
#
#Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.
#
#If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).
#
#The replacement must be in-place, do not allocate extra memory.
#
#Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.
#1,2,3 → 1,3,2
#3,2,1 → 1,2,3
#1,1,5 → 1,5,1
#
# 考虑这种情况，当一组数从低位向高位为单调升序时，如：432，这就是最大了，根据题目要求reverse即可
# 再考虑，一组数如：xxx2431，这组数的低三位已经是最大，所以想要更大必须加入更高位数2，
# 2应该放哪里？才是下一组次大数？
# 注意到这个数是当前高位为x，千位为2时的最大数了，所以下一组比它大的数是要改变千位的，而且应该是次大于2的数
# 那么从后往前找到3，交换2和3，变为xxx3421
# 注意到低3位的单调性没有改变，所以这个数是千位为3的最大数，所以将其低三位reverse就是千位为3的最小数，也就是上一个数的次大数

def nextPermutation(nums)
  if nums.nil? or nums.size<=1 then
    return
  end
  # 从后向前找到递增的最高位
  insertion = nums.size-1
  while insertion>0 and nums[insertion-1]>=nums[insertion] do
    insertion -= 1
  end
  if insertion==0 then
    nums.reverse!
  else
    i = nums.size-1
    # pre是新加入的位
    pre = insertion-1
    # 找到比pre大的第一个数
    while i>pre and nums[i]<=nums[pre] do
      i -= 1
    end
    # puts "#{pre}, #{i}"
    swap(nums, pre, i)
    reverse(nums, insertion, nums.size-1)
  end
end

def reverse(nums, head, tail)
  while head<tail do
    swap(nums, head, tail)
    head += 1
    tail -= 1
  end
end

def swap(nums, left, right)
  if left < right then
    nums[left] ^= nums[right]
    nums[right] ^= nums[left]
    nums[left] ^= nums[right]
  end
end

def test(nums)
  i = 1
  (1..nums.size).each{|x| i *= x}
  (0...i).each{|t|
    nextPermutation(nums)
    puts "#{nums} -> " 
  }
end

# x = [1,2,3]
# y = x.clone
# nextPermutation y
# puts "#{x} -> #{y}"
# test x
[
  [1,2,3],
  [1,2,3,4],
  [1,1,5],
  [1,2,3,4,5],
].each{|x|
  puts "#{x} ->"
  test x
  puts "-----------------------------------"
}
