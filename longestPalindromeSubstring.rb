#!/usr/bin/ruby

def preProceed(str)
	res = Array.new
	res.push('^')
	str.each_char {|c| res.push(c)}
	res.push('$')
	return res.join('#')
end

def longestPalindromeSubstring(str)
	s = preProceed(str)
	r = Array.new(s.size) {|e| e=0}
	i = 0
	center = 0
	right = 0
	while i<s.size do
		if i==center then
			while right<s.size and (center*2-right)>=0 and s[right]==s[center*2-right] do
				right+=1
			end
			r[center] = right-center-1
			i+=1
		else
			i_mirror = center*2-i
			if r[i_mirror] < right-i and (i_mirror-r[i_mirror]-1)>0
				r[i] = r[i_mirror]
				i+=1
			else 
				right = right-i>0? right:i
				r[i] = right-i
				center = i
				# puts r[i]
			end
		end
	end
	puts "#{r}"
	max_r = 0
	pivot = 0
	j = 0
	while j<r.size do
		if max_r < r[j] then
			max_r = r[j]
			pivot = j
		end
		j+=1
	end
	# puts s[pivot],pivot,r[pivot],max_r
	return s[pivot-max_r, max_r*2+1].delete('#')
end

# str = 'abab'
str = 'aaaa'
r = longestPalindromeSubstring str
puts preProceed(str)
puts r
