#!/usr/bin/ruby
#You have a number of envelopes with widths and heights given as a pair of integers (w, h). One envelope can fit into another if and only if both the width and height of one envelope is greater than the width and height of the other envelope.
#
#What is the maximum number of envelopes can you Russian doll? (put one inside other)
#
#Example:
#Given envelopes = [[5,4],[6,4],[6,7],[2,3]], the maximum number of envelopes you can Russian doll is 3 ([2,3] => [5,4] => [6,7]).
#
#将序列排序，长度升序，长度相等时高度降序，长度就不用管了，只用关注高度：
#问题化简为求宽度的最长升序列：
#比如 (6,7)(6,5)时，只关注[7,5]， 
#假设序列是 a[1,2,3,4,7,5,5]，[1,2,3,4,7]满足升序，到5时破坏了升序，这时候用5替换7，因为如果后面的数字大于7则必然大于5，反之则不亦然；
#[5,5]的时候也要替换，所以
#遍历序列，找出序列res[0-i)中大于等于a[i]的数字res[k]，将res[k]=a[i]，如果是没有，就将a[k] push到res中，
#c++和ruby RBTree 中的lower_bound正好满足这个条件，但是RBTree在遍历的过程中不能更新，所以使用等价的binary_search去做
#整个过程是 nlogn 的

def russianDoll(envelopes)
	if envelopes.size < 2 then
		return envelopes.size
	end
	dp = []
	envelopes.sort! {|a,b| (tmp=a[0]<=>b[0])!=0 ? tmp : b[1]<=>a[1]	}.each { |_,h| 
		i=(0...dp.size).bsearch { |index| dp[index] >= h }
		dp[i||dp.size] = h
	}
	# puts "#{dp}"
	dp.size
end

# envelopes = Array[Array[5,4],Array[6,5],Array[6,7],Array[2,3],Array[7,6]]
envelopes = [[5,4],[6,5],[6,7],[2,3],[7,6]]
puts "envelopes: #{envelopes}"
res = russianDoll envelopes
puts res
