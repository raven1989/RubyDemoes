#!/usr/bin/ruby
#
# not finished

def selfCrossing?(nums)
	quad = Array.new(4)
	x,y = 0,0
	o = q = nil
	(0..nums.size).each {|i| 
		# puts "(#{x},#{y}) q#{q} o#{o} #{quad}"
		cur = i%4
		if not q.nil? and not o.nil? and not quad[cur].nil? then
			if q[0]==o[0] and (y-q[1]).abs<(o[1]-q[1]).abs and (quad[cur][1]-y).abs>=(quad[cur][1]-q[1]).abs then
				return true
			elsif q[1]==o[1] and (x-q[0]).abs<(o[0]-q[0]).abs and (quad[cur][0]-x).abs>=(quad[cur][0]-q[0]).abs then
				return true
			end
		# 考虑原点的上一个点处重合
		# [1,1,2,2,1,1]
		elsif not q.nil? and q[0]==x and q[1]==y then
			return true
		# 考虑原点处重合
		# [1,1,2,1,1]
		elsif not o.nil? and o[0]==x and o[1]==y then
			return true
		end
		if i>=nums.size
			return false
		end
		q = o
		o = quad[cur]
		quad[cur] = [x,y]
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
	[1,1,2,1,1],
	[1,1,2,2,1,1],
	[1,1,2,2,3,3,4,4,10,4,4,3,3,2,2,1,1],
].each {|x|
	puts "#{x} : #{selfCrossing? x}"
}
