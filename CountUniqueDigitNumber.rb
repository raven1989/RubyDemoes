#!/usr/bin/ruby

def countUniqDigitNumber(n)
	if n<0 then
		return 0
	end
	if n>10 then
		return countUniqDigitNumber(10)
	end
	if n==0 then
		return 1
	elsif n==1 then
		return 10
	end
	d = Array.new
	d.push(10)
	d.push(9*9) #C91 * A91
	sum = 0
	d.each {|e| sum+=e}
	i = 2
	while i<n do
		d.push(d[i-1]*(10-i))
		sum += d[i]
		i += 1
	end
	return sum
end

puts countUniqDigitNumber(3)
