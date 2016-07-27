#!/usr/bin/ruby

def reproduct(life_span, m, kth_mon)
	colony = Array.new(life_span, 0)
	front = 0
	colony[front] = 1
	cur_mon = 2
	while cur_mon<=kth_mon do
		front = (front+life_span-1)%life_span
		colony[front] = (colony[(front+2)%life_span] + colony[(front+3)%life_span] + colony[(front+4)%life_span])*m
		cur_mon += 1
	end
	res = Array.new
	for i in 0...life_span
		res.push(colony[(front+i)%life_span])
	end
	return res
end

colony = reproduct 5, 2, 5
puts "#{colony}"
