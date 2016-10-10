#!/usr/ruby/bin
#Given n non-negative integers a1, a2, ..., an, where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
#
#Note: You may not slant the container.
#
#从最宽的开始找，即从两边开始：
#哪边低移动哪边
#无论是左边移动还是右边移动，宽度都会变小，那么如果高度小于等于之前的，则面积必然是变小，
#所以去要找大于原来的高度，才有可能面积比原来的大，
#而且，如果只移动一边，面积只有可能变小，因为即使移动到的高度比原来高，算面积时取的高度还是原来的高度，而宽度则变小

def maxArea(height)
	left = 0
	right = height.size-1
	max_area = 0
	h = 0
	while left<right do
		puts "#{left}, #{right}"
		h = [height[left],height[right]].min
		area = h*(right-left)
		if area>max_area then
			max_area = area
		end
		while left<right and height[left]<=h do
			left += 1
		end
		while left<right and height[right]<=h do
			right -= 1
		end
	end
	return max_area
end

[
	[1,1],
	[3,2,2,1],
	[1,2,4,3],
	[1,3,1,1,3],
].each{ |x| 
	puts "#{x} : #{maxArea x}"
}
