#!/usr/bin/ruby
#Given a positive integer num, write a function which returns True if num is a perfect square else False.
#
#Note: Do not use any built-in library function such as sqrt.
#
#Example 1:
#
#Input: 16
#Returns: True
#Example 2:
#
#Input: 14
#Returns: False

def ifPerfectSquare(num)
	if num<0 then
		return false
	elsif num==0 then
		return true
	end
	left = 0
	right = num
	while left<=right do
		mid = left+(right-left)/2
		square = mid**2
		if square==num then
			return true
		elsif square<num then
			left = mid+1
		else
			right = mid-1
		end
	end
	return false
end

puts ifPerfectSquare(3)
