#!/usr/ruby/bin
#
#Given a linked list, reverse the nodes of a linked list k at a time and return its modified list.
#
#If the number of nodes is not a multiple of k then left-out nodes in the end should remain as it is.
#
#You may not alter the values in the nodes, only nodes itself may be changed.
#
#Only constant memory is allowed.
#
#For example,
#Given this linked list: 1->2->3->4->5
#
#For k = 2, you should return: 2->1->4->3->5
#
#For k = 3, you should return: 3->2->1->4->5
#

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

def reverse4K(head, k)
	pre = nil
	cur = head
	i = 0
	while not cur.nil? and i<k do
		pre = cur
		cur = cur.next
		i += 1
	end
	if i<k then
		head
	else
		tmp = reverse4K(cur, k)
		h = nil
		pre.next = nil
		pre.next,h = reverse(head, h)
		h
	end
end

#不能利用引用传递修改参数的内容，好尴尬
def reverse(cur, head)
	h = head
	if cur.nil? then 
	elsif cur.next.nil? then
		h = cur
	else
		tmp,h = reverse(cur.next, head)
		tmp.next = cur
	end
	puts "#{head}"
	return cur,(head||h)
end


[
	[[],1],
	[[1,2,3,4],2],
].each{|x|
	head = [nil]
	reverse(a2lHelper(x[0]), head[0])
	puts "#{x[0]} : #{head}"
	puts "#{x[0]} by #{x[1]} group : #{reverse4K(a2lHelper(x[0]),x[1])}"
}
