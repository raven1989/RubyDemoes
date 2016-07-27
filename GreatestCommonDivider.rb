#!/usr/bin/ruby

def gcd(x, y)
	if x==0 or y==0 then
		return x==0 ? y:x
	elsif x*y < 0 then
		return nil
	elsif x < y then
		x+=y
		y=x-y
		x-=y
	end
	begin
		tmp = y
		y = x%y
		x = tmp
	end while y!=0
	return x
end

d = gcd 12, -4
puts "gcd : #{d}"
