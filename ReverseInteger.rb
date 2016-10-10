#!/usr/bin/ruby
#
#Reverse digits of an integer.
#
#Example1: x = 123, return 321
#Example2: x = -123, return -321
#
#click to show spoilers.
#
#Have you thought about this?
#Here are some good questions to ask before coding. Bonus points for you if you have already thought through this!
#
#If the integer's last digit is 0, what should the output be? ie, cases such as 10, 100.
#
#Did you notice that the reversed integer might overflow? Assume the input is a 32-bit integer, then the reverse of 1000000003 overflows. How should you handle such cases?
#
#For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.

def reverse(z)
	x = z
	y = 0
	while x!=0 do
		y *= 10
		y += x%10
		x /= 10
	end
	return y
end

[
	0,
	123,
	# -123, #因为ruby,python的负数除法是向负无穷取正的，所以这个这个不行
].each{|x|
	puts "#{x} : #{reverse x}"
}
