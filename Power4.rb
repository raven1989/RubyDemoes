#!/usr/bin/ruby
#Given an integer (signed 32 bits), write a function to check whether it is a power of 4.
#
#Example:
#Given num = 16, return true. Given num = 5, return false.
#
#Follow up: Could you solve it without loops/recursion?
#
# num & num-1 == 0说明32位上只有一个1
# 证明：(4^i-1)%3==0 
# 01 -1 = 0 % 3 = 0
# 100-1 = 011%3 = 0
# 10000-1 = 01111 = 01100 + 00011 = 3x4^1 + 3x4^0
# 4^i-1 一定是地位偶数个连续1
# 3x4^0 + 3x4^1 + ... + 3x4^(i-1) = 3x[1+4+16+...+4^(i-1)] = 3 x 1x(1-4^i)/(1-4) = 4^i-1

def power4?(num)
	# num>0 and num&(num-1)==0 and (num&0x55555555)==num
	num>0 and num&(num-1)==0 and (num-1)%3==0
end

res = [0, 1, 2, 3, 4, 8, 16, 64].map {|x| [x,(power4? x)]}
puts "#{res}"
