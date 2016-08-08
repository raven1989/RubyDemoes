#!/usr/bin/ruby
#Given a positive integer n, break it into the sum of at least two positive integers and maximize the product of those integers. Return the maximum product you can get.
#
#For example, given n = 2, return 1 (2 = 1 + 1); given n = 10, return 36 (10 = 3 + 3 + 4).
#
#Note: You may assume that n is not less than 2 and not larger than 58.
#
#Show Hint 
#

require 'set'

def integerBreak(n)
	if n==2 then
		return 1
	elsif n==3 then
		return 2
	elsif n==4 then
		return 4
	end
	e = n/3
	m = n%3
	if m==0 then
		3**e
	elsif m==1 then
		4*3**(e-1)
	else
		2*3**e
	end
end

n = [7,8,9,10]
res = n.map {|x| [x,(integerBreak x)]}
puts "#{res}"
