#!/usr/bin/ruby
#Given a non-empty array of integers, return the k most frequent elements.
#
#For example,
#Given [1,1,1,2,2,3] and k = 2, return [1,2].
#
#Note: 
#You may assume k is always valid, 1 ≤ k ≤ number of unique elements.
#Your algorithm's time complexity must be better than O(n log n), where n is the array's size.

def topKMostFreq(nums, k)
	h = {}
	bucket = Array.new(nums.size) {|e| e=[] }
	nums.each { |x| 
		h[x] = h[x].nil? ? 1 : h[x]+1
	}
	freq = h.to_a
	# puts "#{freq}"
	kthLargest freq, 0, freq.size-1, k
end

def kthLargest(nums2d, left, right, k)
	l = left
	r = right
	while (xth=partition(nums2d, l, r))!=k do
		# puts "xth : #{xth}"
		if xth<k then
			l = xth+1
		elsif xth>k then
			r = xth-1
		end
	end
	# puts "#{nums2d}"
	res = []
	i = 0
	while i<k do
		res<<nums2d[i][0]
		i+=1
	end
	return res
end

def partition(nums2d, left, right)
	l = left
	r = right
	p = r-(r-l)/2
	tmp = nums2d[p]
	nums2d[p] = nums2d[r]
	while l<r do
		while l<r and nums2d[l][1]>=tmp[1] do
			l += 1
		end
		swap(nums2d, l, r)
		while l<r and nums2d[r][1]<=tmp[1] do
			r -= 1
		end
		swap(nums2d, l, r)
	end
	p = l
	nums2d[p] = tmp
	return p
end
def swap(nums2d, i, j)
	tmp = nums2d[i]
	nums2d[i] = nums2d[j]
	nums2d[j] = tmp
end

# nums = [1,1,1,2,2,3]
# nums = [1,2]
nums = [3,0,1,0]
# nums = [4,1,-1,2,-1,2,3]
k = 1
res = topKMostFreq nums, k
puts "#{res}"
