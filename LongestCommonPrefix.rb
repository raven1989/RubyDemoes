#!/usr/ruby/bin
#
#Write a function to find the longest common prefix string amongst an array of strings.

def prefix(strs)
	prefix4recursion strs || ""
end

def prefix4recursion(strs)
	len = strs.size
	if len==0 then
		nil
	elsif len==1 then
		strs[0]
	elsif len==2 then
		prefix4two strs[0],strs[1]
	else
		prefix4two prefix4recursion(strs[0,len/2]), prefix4recursion(strs[0+len/2,len-len/2])
	end
end

def prefix4two(str0, str1)
	if str0.nil? then
		str1
	elsif str1.nil? then
		str0
	else
		res = []
		i = 0
		while i<str0.size and i<str1.size and str0[i]==str1[i] do
			res << str0[i]
			i += 1
		end
		res.join("")
	end
end

[
	[],
	["abc", "abd", "adc"],
	["abc", "abd", "adc", ""],
].each{|x|
	puts "#{x} common prefix : #{prefix x}"
}
