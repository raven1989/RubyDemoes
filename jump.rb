#!/usr/bin/ruby
#有一排台阶，每一个台阶上有一个非负整数，代表在该台阶上时最多能向前跳几个台阶。判断是否能到达最后一个台阶
#这是个线段覆盖的问题
#       |-|-|-
#         |-|-|
# steps 3 2
# index 0 1 2 3
# 能到达的最远目标 dest(i) = i+steps[i]
# dest(0)=3,dest(1)=3
# 当能从0跳到1时，即1<=dest(0)时，能到达的最远目标是max_dest = max(dest(0),dest(1))
# max_dest>=n时能到达，否则不能
def jump(steps)
	dest = 0
	i = 0
	while i<=dest && i<steps.size do
		di = i+steps[i]
		dest = di>dest ? di:dest
		i += 1
	end
	return dest>=steps.size ? true:false
end

# steps = Array[1,1,1,1,1]
# steps = Array[3,1,1,0,2]
steps = Array[4,2,3,1,0]
res = jump steps
puts "#{steps} #{res}"
