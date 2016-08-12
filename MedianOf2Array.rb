#!/usr/bin/ruby
#

def check(nums1, nums2)
	(a=(nums1+nums2).sort).size%2==0 ? a[(a.size-1)/2,2] : a[a.size/2,1]
end

def median(nums1, nums2)
	res = []
	h1,t1 = 0, (len1=nums1.size)-1
	h2,t2 = 0, (len2=nums2.size)-1
	# puts "len : #{len1} #{len2}"
	if len1!=0 and len2!=0 then
		m = (nums1.size+nums2.size-1)/2
		m1 = m2 = 0
		low1 = low2 = -1
		up1 = up2 = len1+len2
		begin
			m1 = h1+(t1-h1)/2
			m2 = h2+(t2-h2)/2
			# puts "m2:#{m2} h2:#{h2} t2:#{t2}"
			if nums1[m1]<nums2[m2] then
				low1,up1 = [m1,low1].max, [tmp=len1+len2-1-(tmp1=(len1-m1-1 + len2-m2)),up1].min
				# puts "tmp : #{tmp} #{tmp1}"
				low2,up2 = [m1+m2+1,low2].max, [len1+len2-1-(len2-1-m2),up2].min
			else
				low1,up1 = [m2+m1+1,low1].max, [len1+len2-1-(len1-1-m1),up1].min
				low2,up2 = [m2,low2].max, [len1+len2-1-(len2-m2-1 + len1-m1),up2].min
			end
			puts "nums1@#{m1} : #{nums1[m1]} [#{low1},#{up1}] for #{m}"
			puts "nums2@#{m2} : #{nums2[m2]} [#{low2},#{up2}] for #{m}"
			if m<low1 then
				if t1>h1 and m1>0 then
					t1 = m1-1
					low1, up1 = -1, len1+len2
					# puts "clear nums1@#{m1} : #{nums1[m1]} [#{low1},#{up1}]"
				end
			elsif m>up1 and m1<len1-1 then
				if t1>h1 then
					h1 = m1+1
					low1, up1 = -1, len1+len2
				end
			else
				if low1==up1 then
					res << nums1[m1]
					if ((len1+len2)%2==0 and res.size<2) then  
						m=m+1
						h1,t1 = 0, len1-1
						h2,t2 = 0, len2-1
						next
					else
						break
					end
					# puts "res:#{res} change 2 #{m}"
				end
			end
			if m<low2 then
				if t2>h2 and m2>0 then
					t2 = m2-1
					low2, up2 = -1, len1+len2
				end
			elsif m>up2 and m2<len2-1 then
				if t2>h2 then
					h2 = m2+1
					low2, up2 = -1, len1+len2
				end
			else
				if low2==up2 then
					res << nums2[m2]
					if ((len1+len2)%2==0 and res.size<2) then 
						m=m+1
						h1,t1 = 0, len1-1
						h2,t2 = 0, len2-1
						next
					else
						break
					end
				end
				# puts "res:#{res} change 2 #{m}"
			end
		end while true
	else
		if len1==len2 then
			return nil
		elsif len1==0 then
			res << nums2[m=(len2-1)/2]
			if len2%2==0 then res << nums2[m+1] end
		else
			res << nums1[m=(len1-1)/2]
			if len1%2==0 then res << nums1[m+1] end
		end
	end
	sum = 0
	res.each {|x| sum+=x}
	sum*1.0/res.size
end

[
	# [[1],[1]],
	# [[1,2,4,8,9,10],[3,5,6]],
	# [[1,2,4,8,9,10],[3,5]],
	# [[1,2,4,8,9,10],[11]],
	# [[1,2,4,8,9,10],[11,12]],
	# [[],[11,12]],
	[[1,2,2],[1,2,3]],
].each { |x| 
	puts "#{(x[0]+x[1]).sort}  median:#{median x[0], x[1]} check:#{check x[0],x[1]}"
}
