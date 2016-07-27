#!/usr/bin/ruby

def swap(seq, i, j)
	seq[i] ^= seq[j]
	seq[j] ^= seq[i]
	seq[i] ^= seq[j]
end

def partition(seq, head, tail)
	if head>=tail then
		return head
	end
	pivot = (head+tail)/2
	tmp = seq[pivot]
	swap(seq, pivot, tail)
	while head<tail do 
		while head<tail && seq[head]<tmp do
			head+=1
		end
		seq[tail]=seq[head]
		while head<tail && seq[tail]>tmp do
			tail-=1
		end
		seq[head]=seq[tail]
	end
	pivot = head
	seq[pivot] = tmp
	return pivot
end

def kth(seq, head, tail, k)
	pivot = partition(seq, head, tail)
	puts "#{seq}"
	if pivot == k then
		return seq[k]
	elsif pivot > k then
		kth(seq, 0, pivot-1, k)
	else
		kth(seq, pivot+1, seq.size-1, k)
	end
end

seq = Array[0,4,2,3,6]
k = 3
puts "#{seq} sorted:#{seq.sort} #{k}th : #{kth seq, 0, seq.size-1, k}"

