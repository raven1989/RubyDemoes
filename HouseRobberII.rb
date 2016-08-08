#!/usr/bin/ruby
#Note: This is an extension of House Robber.
#
#After robbing those houses on that street, the thief has found himself a new place for his thievery so that he will not get too much attention. This time, all houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, the security system for these houses remain the same as for those in the previous street.
#
#Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.
#
# a = [a0, a1, a2, a3, a4]
# b = [0, a1, a2, a3, a4]
# f0 = a0                            g0 = 0
# f1 = max(a0, a1)                   g1 = max(0, a1) = a1
# f2 = max(a2+f0, f1)                g2 = max(a2+g0, g1)
# f3 = max(a3+f1, f2)                g3 = max(a3+g1, g2)
# fi = max(a[i]+f[i-2], f[i-1])      gi = max(a[i]+g[i-2], g[i-1])
# 最终所求的最大和为 ：max(a4+g2, f3)
#                      max(ai+g[i-2], f[i-1])

def robDp(nums)
  f, g = [], []
  (0...nums.size-1).each{ |i|
    f[i] = [nums[i]+(i-2<0 ? 0 : f[i-2]), (i-1<0 ? 0 : f[i-1])].max
    g[i] = [(i>0 ? nums[i] : 0)+(i-2<0 ? 0 : g[i-2]), (i-1<0 ? 0 : g[i-1])].max
  }
  [(f.size-1<0 ? 0 : f[-1]), (nums[-1]||0)+(g.size-2<0 ? 0 : g[-2])].max
end

def rob(nums)
  f_before_last, f_last = 0, 0
  g_before_last, g_last = 0, 0
  (0...nums.size-1).each{ |i|
    f_before_last, f_last = f_last, [nums[i]+f_before_last, f_last].max
    g_before_last, g_last = g_last, (i==0 ? 0 : [nums[i]+g_before_last, g_last].max)
  }
  [f_last, (nums[-1]||0)+g_before_last].max
end

[
  [],
  [5,1,1,2,3],
  [5,1,1,2,1,3],
  [5,1,1,2,1,3,2],
].each { |x| 
  puts "#{x} : #{robDp x}"
  puts "#{x} : #{rob x}"
}
