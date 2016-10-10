#!/usr/ruby/bin
#
#Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
#
#The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
#

def valid?(s)
	stack = []
	s.chars.each {|c| 
		if c=="(" or c=="[" or c=="{" then
			stack << c
		else
			if stack.size>0 then
				top = stack[stack.size-1]
				stack.delete_at(stack.size-1)
				if not ( (top=="(" and c==")") or (top=="[" and c=="]") or (top=="{" and c=="}") ) then
					return false
				end
			else
				return false
			end
		end
	}
	return stack.size==0
end

[
	"",
	"{()[]}",
	"(]",
	"{",
].each{|x|
	puts "#{x} : #{valid? x}"
}
