#!/usr/bin/ruby
#Write a function that takes a string as input and reverse only the vowels of a string.
#
#Example 1:
#Given s = "hello", return "holle".
#
#Example 2:
#Given s = "leetcode", return "leotcede".
#
#Note:
#The vowels does not include the letter "y".
#
#
def reverse_vowels(s)
	cs = s.bytes
	i = 0
	j = cs.size-1
	dict = ['A','E','I','O','U','a','e','i','o','u'].flat_map {|x| x.bytes}
	while i<j do
		while i<j and not (dict.include? cs[i]) do
			i += 1
		end
		while i<j and not (dict.include? cs[j]) do
			j -=1
		end
		if i<j then
			swap(cs, i, j)
			i += 1
			j -= 1
		end
	end
	cs.map {|x| x.chr}.join
end
def swap(s, i, j)
	s[i] ^= s[j]
	s[j] ^= s[i]
	s[i] ^= s[j]
end

# s = "hello"
s = "leetcode"
puts reverse_vowels(s)
