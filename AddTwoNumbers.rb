#!/usr/bin/ruby
#
#You are given two linked lists representing two non-negative numbers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
#
#Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
#Output: 7 -> 0 -> 8

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

def add(l1, l2)
	c = 0
	h1 = l1
	h2 = l2
	res = h3 = nil
	while not h1.nil? and not h2.nil? do
		tmp = h1.val+h2.val+c
		c = tmp/10
		if h3.nil? then 
			h3 = ListNode.new(tmp%10)
		else
			h3.next = ListNode.new(tmp%10)
			h3 = h3.next
		end
		if res.nil? then
			res = h3
		end
		h1 = h1.next
		h2 = h2.next
	end
	while not h1.nil? do
		tmp = h1.val + c
		c = tmp/10
		if h3.nil? then
			h3 = ListNode.new(tmp%10)
		else
			h3.next = ListNode.new(tmp%10)
			h3 = h3.next
		end
		if res.nil? then
			res = h3
		end
		h1 = h1.next
	end
	while not h2.nil? do
		tmp = h2.val + c
		c = tmp/10
		if h3.nil? then
			h3 = ListNode.new(tmp%10)
		else
			h3.next = ListNode.new(tmp%10)
			h3 = h3.next
		end
		if res.nil? then
			res = h3
		end
		h2 = h2.next
	end
	if c>0 then
		h3.next = ListNode.new(c)
	end
	return res
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

[
	[[2,4,3],[5,6,4]],
].each{ |x|
	puts "#{x[0]} + #{x[1]} = #{add a2lHelper(x[0]), a2lHelper(x[1])}"
}
