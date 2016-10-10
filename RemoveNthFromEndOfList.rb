#!/usr/ruby/bin
#
#Given a linked list, remove the nth node from the end of list and return its head.
#
#For example,
#
#   Given linked list: 1->2->3->4->5, and n = 2.
#
#   After removing the second node from the end, the linked list becomes 1->2->3->5.

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

def remove(head, n)
	if n<=0 then
		return head
	end
	i = nil
	pre = nil
	j = head
	k = n
	while not j.nil? and k>0 do
		j = j.next
		k -= 1
	end
	if k<=0 then
		i = head
		while not j.nil? do
			pre = i
			i = i.next
			j = j.next
		end
		if pre.nil? then
			head.next
		else
			pre.next = i.next
			head
		end
	else
		head
	end
end

[
	[[],0],
	[[],1],
	[[1],1],
	[[1,2,3,4],1],
	[[1,2,3,4],2],
].each{|x|
	puts "#{x[0]} remove #{x[1]}th from end : #{remove a2lHelper(x[0]),x[1]}"
}
