#!/usr/bin/ruby

def findIntersection(a, b)
	i = 0
	j = 0
	res = Array.new
	while i<a.size && j<b.size do
		if a[i]<b[j] then
			i+=1
		elsif a[i]>b[j] then
			j+=1
		else
			overlab = Array.new
			while a[i]==b[j] do
			  overlab.push(a[i])
				if(i>=a.size || j>=b.size) then
					res.push(overlab)
					break
				else
					i+=1
					j+=1
				end
			end
			res.push(overlab)
		end
	end
	return res
end

a = Array[1,2,5,6,7,8,9,10,11]
b = Array[3,4,5,6,7,11,12,13]
res = findIntersection a, b
for it in res
	puts "#{it}"
end
