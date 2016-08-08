#!/usr/bin/ruby
#Given a non negative integer number num. For every numbers i in the range 0 ≤ i ≤ num calculate the number of 1's in their binary representation and return them as an array.
#
#Example:
#For num = 5 you should return [0,1,1,2,1,2].
#
#Follow up:
#
#It is very easy to come up with a solution with run time O(n*sizeof(integer)). But can you do it in linear time O(n) /possibly in a single pass?
#Space complexity should be O(n).
#Can you do it like a boss? Do it without using any builtin function like __builtin_popcount in c++ or in any other language.
#
#
# 0 : 0
# 1 : 1
#
# 1<<1+0 : 2
# 1<<1+1 : 3
#
# 2<<1+0 : 4
# 2<<1+1 : 5
# 3<<1+0 : 6
# 3<<1+1 : 7

def countBitsForEach(num)
	res = [0,1]
	i = 1
	while res.size<num+1 do
		res << res[i]
		if res.size==num+1 then
			break
		end
		res << res[i]+1
		i += 1
	end
	res[0,num+1]
end

[0,1,2,3,4,5].each{|x|
	puts "#{x} : #{countBitsForEach x}"
}
