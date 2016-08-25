#!/usr/bin/ruby
#

def selfCrossing?(nums)
	quad = Array.new(4)
	x,y = 0,0
	(0...nums.size).each {|i| 
		quad[cur=i%4] = [x,y]
		# puts "#{quad}"
		first = quad[(cur+1)%4]
		if cur==0 then
			y += nums[i]
			# puts "#{cur} [#{x},#{y}] #{first}"
			if (not first.nil?) and x<=first[0] and y>=first[1] then #2象限
				return true
			end
		elsif cur==1 then
			x -= nums[i]
			# puts "#{cur} [#{x},#{y}] #{first}"
			if (not first.nil?) and x<=first[0] and y<=first[1] then #3
				return true
			end
		elsif cur==2 then
			y -= nums[i]
			# puts "#{cur} [#{x},#{y}] #{first}"
			if (not first.nil?) and x>=first[0] and y<=first[1] then #4
				return true
			end
		else
			x += nums[i]
			# puts "#{cur} [#{x},#{y}] #{first}"
			if (not first.nil?) and x>=first[0] and y>=first[1] then #1
				return true
			end
		end
	}
	return false
end


[
	[2,1,1,2],
	[1,2,3,4],
	[1,1,1,1],
].each {|x|
	puts "#{x} : #{selfCrossing? x}"
}
