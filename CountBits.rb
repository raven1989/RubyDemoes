#!/usr/bin/ruby
#Count bits in num where is 1

def countBits(num)
	if num==0 then
		return num
	end
	i = 1
	while (num&=(num-1))!=0 do
		i += 1
	end
	return i
end

res = [0b10000, 0b010101, 0b11110, 0].map {|x| countBits x}
puts "#{res}"
