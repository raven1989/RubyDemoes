#!/usr/ruby/bin
#
#Merge two sorted linked lists and return it as a new list. 
#The new list should be made by splicing together the nodes of the first two lists.

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

def merge(l1,l2)
	#利用一个辅助头Node，方便处理各种特殊情况
	head  = ListNode.new(0)
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

[
	[[],[]],
	[[],[1]],
	[[1],[1]],
	[[1,2,3,4],[1]],
	[[1,2,3,4],[2,7]],
].each{|x|
	puts "#{x[0]} #{x[1]} merge : #{merge a2lHelper(x[0]),a2lHelper(x[1])}"
}
