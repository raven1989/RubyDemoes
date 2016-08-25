#!/usr/bin/ruby
#     0 1 2 3  4      0 1 2
# [a=[1,3,8,10,11], b[4,9,13], k=2] 为例，找k=2的数
# 1.二分法，首先比较a[2]=8和b[1]=9  
# 8<9 
# 所以 a[2]前面至少有a[0:1]两个数，后面至少有a[3:4]+b[1:2]共四个数，
# 那么a[2]排好序的数组中的位置范围是 p0=[1,7-4] => p0=[1,3]
# 同理，b[1]前面至少有a[0:2]+b[0]共四个数，后面至少有b[2]一个数，
# 那么b[1]的取值范围是 [4:6]
# 可以看出b[1]以及它后面的数都不可能在位置2，所以抛弃它们，将右游标指向b[mid]=b[1], br=1
#	   为什么不指向b[mid-1]呢？
#	   因为在程序中(a+b)/2是偏向左边的值，比如(0+1)/2=0，
#	   如果指向b[m-1]，那么b[m-1]这个值就有可能考察不到，
#	   比如：[0,1,2,3,4,5] mid=(0+5)/2=2 下一次: mid=(0+2-1)/2=0，发现1被跳过了
#	   向左移动的时候就不会这样
#	2.接下来考察a[2]和b[0]
#	2>0
#	a[2]前面至少有a[0:1]+b[0]三个数，后面至少有a[3:4]两个数，注意到上一次a[2]的范围
#	所以a[2]的取值范围是 p1=[max(p0.left,3), min(p0.right,5)]=[3,3]，
#	它比k大，我们会抛弃它和它后面的数，右游标右移至mid位置，即ar=mid=2, mid=(0+2)/2=1
#	b[0]前面至少有0个数，后面至少有a[2:4]+b[1:2]五个数，所以b[0]的位置范围是 [0,2]
#	3. a[1]和b[0] 3<4
#		al=0 ar=2 am=1 a[1] => [1,1]; bl=0 br=1 bm=0 b[0] => [max(0,2),min(2,5)]=[2,2]
#	4.al=2 ar=2 am=2 al==ar break
#
#	这时候k一定在[1,1][2,2]中的一个，注意到这里有一个规律，位置范围一定是这样的形式：
#		[x,y][y+1,z]
#
###########	定律：结束时，一定有一个序列已经全部二分扫描完毕，且这个值一定不在这个序列中 ###############
# 因为值所在的那个序列会在游标包含了这个值之后的某一个时机停止更新，因为要找的k不会被跳过去
########################################################################################################
#
########### 定律：如果比较短的序列没有二分扫描完，则停止时，mid指向的位置一定是要找的数 ################
# 因为short比较短，如果要找的数不在其中，一定会先于long扫描完
########################################################################################################
#
########### 定律：如果short先扫描完毕，那么这个数一定在long中，且结束时mid指向的这个数的位置范围上届和下届相等(设为x)，######################
# ######### 且此时左右游标l,r指向long[l:r]这个范围在最终序列中是连续的，并且|k-x|<=|l-mid|，即要找的数一定在这个连续的序列中 ################
# 因为对于long[mid]而言，short中的每一个值都比较过了，所以long[mid]的位置范围一定不会再被short中的值插入而改变
#####################################################################################################################################
#
#考虑初始情况的可能取值范围
#a[1,2,3,4] b[5,6], k=2，显然位置2之后的数a[3]=4不可能，
#所以取值范围是a[0,2], b[0,1]
#这里一共有三种情况
# 1. k<m<n
#    m[0,k] n[0,k]
# 2. m<k<n
#    m[0,min(k,m)] n[max(0,k-m),k]
# 3. m<n<k
#    m[max(0,k-n),m] n[max(0,k-m),n]
# 综合起来 
# sl, sr = 0, [k,short.size-1].min
# ll, lr = [k-short.size,0].max, [k,long.size-1].min

def kthOf2Sorted(nums1, nums2, k)
	if nums1.empty? then
		return nums2[k]
	elsif nums2.empty? then
		return nums1[k]
	end
	long, short = nums1.size > nums2.size ? [nums1,nums2] : [nums2,nums1]
	len = long.size + short.size
	# 这里将size包括进来是为了中值可以取到最后一个值
	sl, sr = 0, [k+1,short.size].min
	ll, lr = [k-short.size,0].max, [k+1,long.size].min
	# puts "...start...#{k}th...short#{short.size}...long#{long.size}"
	# puts "#{short} (#{sl},#{sr})"
	# puts "#{long} (#{ll},#{lr})"
	slow = llow = -1
	sup = lup = len
	sm = lm = 0
	# i = 0
	begin
		sm = sl+(sr-sl)/2
		lm = ll+(lr-ll)/2
		if short[sm]<long[lm] then
			slow, sup = [sm,slow].max, [sup, len-(short.size-sm+long.size-lm)].min
			llow, lup = [llow, lm+sm+1].max, [lup,len-(long.size-lm)].min
		else
			slow, sup = [slow, sm+lm+1].max, [sup, len-(short.size-sm)].min
			llow, lup = [lm,llow].max, [lup, len-(long.size-lm+short.size-sm)].min
		end
		# puts "short@#{sm} (#{sl},#{sr}) #{short[sm]} : (#{slow},#{sup})"
		# puts "long@#{lm} (#{ll},#{lr}) #{long[lm]} : (#{llow},#{lup})"
		if sr<=sl or lr<=ll then
			break
		end
		if sup<llow then
			if k<llow then
				# if lm<=ll then
					# break
				# end
				lr = lm
				llow, lup = -1, len
			elsif k>sup then
				# if sm+1>=sr then
					# break
				# end
				sl = sm+1
				slow, sup = -1, len
			end
		else
			if k<slow then
				# if sm<=sl then
					# break
				# end
				sr = sm
				slow, sup = -1, len
			elsif k>lup then
				# if lm+1>=lr then
					# break
				# end
				ll = lm+1
				llow, lup = -1, len
			end
		end
		# i += 1
	end while sl<=sr and ll<=lr and sl<short.size and ll<long.size #and i<10
	# end while true
	# puts "...after.loop..."
	# puts "#{short}@#{sm} (#{sl},#{sr}) #{short[sm]} : (#{slow},#{sup})"
	# puts "#{long}@#{lm} (#{ll},#{lr}) #{long[lm]} : (#{llow},#{lup})"
	# if k<=sup and k>=slow then
		# # puts "#{k}th short[#{index=sm-slow+k}]: #{short[index]}"
		# short[sm]
	# else
		# # puts "#{k}th long[#{index=lm-llow+k}] : #{long[index]}"
		# long[lm-llow+k] #lm+(k-llow)
	# end
	if sl>=sr then
		long[lm+k-llow] # 一定有llow==lup
	else
		short[sm]
	end
end

[
	# [[1,3,8,10,11], [4,9,13], 2],
	# [[1,9,10,11,13], [3,4,8], 2],
	# [[1,2,2], [1,2,3], 2],
	# [[1,2,2], [1,2,3], 3],
	# [[1,2,2], [1,2,3], 0],
	# [[1,2,4,8,9,10], [11], 3],
	# [[1,2,8], [3,4,5,6,7], 3],
	# [[1,2], [1,2], 2],
].each { |x| puts "#{(x[0]+x[1]).sort} #{x[2]}th #{kthOf2Sorted x[0],x[1],x[2]}" } 
