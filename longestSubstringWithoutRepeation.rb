#!/usr/bin/ruby

def longestSubstringWithoutRepeation(str)
	alphabet = Hash.new
	'abcdefghijklmnopqrstuvwxyz'.split('').map {|c| alphabet[c]=-1}
	# puts "#{alphabet}"
	array = str.split('')
	#index[i]记录上一次array[i]这个字符出现的位置索引
	index = Array.new(array.size)
	for i in 0...index.size do
		index[i] = alphabet[array[i]]
		alphabet[array[i]] = i
	end
	# puts "#{index}"
	i = 0
	head = len = 0
	max_head = 0
	max_len = 0
	while i<array.size do
		while i<array.size and index[i]<head do
			len += 1
			i += 1
		end
		if len>max_len then
			max_head = head
			max_len = len
		end
		# puts "#{max_head},#{max_len}"
		if i<array.size then
			head = index[i] + 1
			len = i-head+1
		end
	end
	return str[max_head,max_head+max_len]
end

# substr = longestSubstringWithoutRepeation 'abbcv'
substr = longestSubstringWithoutRepeation 'abcbcv'
# substr = longestSubstringWithoutRepeation 'abcdae'
puts substr
