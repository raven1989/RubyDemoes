#!/usr/ruby/bin
#
#Given a linked list, swap every two adjacent nodes and return its head.
#
#For example,
#Given 1->2->3->4, you should return the list as 2->1->4->3.
#
#Your algorithm should use only constant space. You may not modify the values in the list, only nodes itself can be changed.

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

#深度到最后，先交换最后面的，然后回溯过程中依次交换好前面的
#如果从前往后交换，则需要多记住前一对的后一个：
# a->b->c->d  b->a->c->d 这里接下来要记住a，以便交换后d->c，将a.next=d
def swapPairs(head)
	i = head
	j = i.nil? ? i : i.next
	if i.nil? or j.nil? then
		head
	else
		j.next=swapPairs(i.next.next)
		swap4Pair(i,j)
	end
end

def swap4Pair(i,j)
	if i.nil? or j.nil?
		i||j
	else
		i.next = j.next
		j.next = i
		j
	end
end

#再写一个深度后续回溯置换，利用i表示第几个元素(i=0,1,...)
#if i%2==0, 这时候要交换当前节点和当前节点的next
#if i%2==1, 这时候不需要交换，就返回当前节点
def postSwapPairs(head, ith)
	if head.nil? or head.next.nil? then
		head
	else
		last = postSwapPairs(head.next, ith+1)
		if ith%2==0 then
			head.next = last.next
			last.next = head
			last
		else
			head.next = last
			head
		end
	end
end


[
	[],
	[1,2,3,4],
	[1,2,3,4,5],
].each{|x|
	puts "#{x} : #{swapPairs(a2lHelper(x))}"
	puts "#{x} : #{postSwapPairs(a2lHelper(x), 0)}"
}
