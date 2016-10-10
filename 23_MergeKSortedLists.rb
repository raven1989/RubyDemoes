#!/usr/ruby/bin
#
#Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

require_relative 'Heap'

# Definition for singly-linked list.
class ListNode
	attr_accessor :val, :next
	def initialize(val)
		@val = val
		@next = nil
	end
	def value
		if @next.nil? then
			[@val]
		else
			[@val]+@next.value
		end
	end
	def to_s
		"#{value}"
	end
	def inspect
		to_s
	end
end

def a2lHelper(arr)
	res = h = ListNode.new(0)
	arr.each{|x|
		h.next = ListNode.new(x)
		h = h.next
	}
	# puts "#{res.next}"
	res.next
end

class HeapNode
	attr_accessor :node, :from
	def initialize(node, from)
		@node = node
		@from = from
	end
	def <=> other
		@node.val <=> other.node.val
	end
	def < other
		(self<=>other) < 0
		# @node.val < other.node.val
	end
end

def kMerge(lists)
	#计算k路归并的堆的大小，即有k个叶子节点的完全二叉树的节点数
	# puts "......Begin....."
	heap_size = 0
	d = 1
	k = lists.size
	while d<k do
		heap_size += d
		d = d<<1
	end
	heap_size += (k-(d-k))
	# puts "#{k} merge : #{heap_size}"
	#初始化堆，这个堆中时刻要有每一路的节点，则排序一定正确
	#某一路多一些，某一路少一些则不影响正确性
	#当然，如果某一路已经为空，则堆中可能已经没有该路的节点，但排序仍然是正确的
	sorter = Heap.new
	(0...heap_size).each{|i|
		cur = lists[i%k]
		if not cur.nil? then
			lists[i%k] = cur.next
			cur.next = nil
			sorter.push(HeapNode.new(cur,i%k))
		end
	}
	# puts ".....Sort....."
	#辅助用头节点
	head = ListNode.new(0)
	cursor = head
	#开始排序
	while not sorter.empty? do
		top = sorter.pop
		cursor.next = top.node 
		k = top.from
		if not lists[k].nil? then
			sorter.push(HeapNode.new(lists[k],k))
			lists[k] = lists[k].next
		end
		cursor = cursor.next
		cursor.next = nil
	end
	head.next
end

def biMerge(l1, l2)
	head = ListNode.new(0)
	cur = head
	i = l1
	j = l2
	while not i.nil? and not j.nil? do
		if i.val<j.val then
			cur.next = i
			i = i.next
		else
			cur.next = j
			j = j.next
		end
		cur = cur.next
	end
	cur.next = i||j
	head.next
end

def merge(lists)
	k = lists.size
	if k>32 then
		left = merge(lists[0,k/2])
		right = merge(lists[k/2,k-k/2])
		biMerge(left,right)
	else
		kMerge(lists)
	end
end


[
	# [],
	# [[1,3],[0,2]],
	# [[1,3],[0,2],[2,3],[1,5,6,7,8]],
	[[1,2,2],[1,1,2]],
	[[1,2,3],[1,4,6]],
].each{|x|
	lists = x.map{|a| a2lHelper(a)}
	puts "#{x} kMerge : #{merge(lists)}"
}
