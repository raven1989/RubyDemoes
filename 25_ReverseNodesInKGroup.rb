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

# 使用类后序递归来实现：
# 比如 0 -> 1 -> 2 -> 3 -> 4, 以k=3来反转
# 先到达最后一个，返回的过程中，
# 1. if i%k==0, 那么说明这是一组的第一个元素，需要将这个组链表反转
# 2. if i%k+1==k, 那么说明这是上一组链表前的第一个节点，需要将上一组链表的头和它连接起来
# 
# eg:
# 1. 到最后一个节点
#                                    |
# 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7
# 2. 返回到3，这是一组的头结点，去调用normalReverse，长度不满足要求不会反转
#                               |
# 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7
#
#                               |
# 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7
# 
# 返回的组头节点还是6
#
# 3. 返回到5，这是上一组头结点的前一个节点，将6和5连接起来
#                          |
# 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7
#
# 4. 返回到3，这又是一组节点的第一个节点，调用normalReverse，反转长度为k的链表节点
#                |
# 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7
#                          |
#                5 -> 4 -> 3          
# 当前节点变成组的最后一个，然后把上一组的头和当前节点连接起来
#                          |
#                5 -> 4 -> 3 -> 6 -> 7  head.next = groupHead 
# 返回的是当前组的头结点5
#
# 5. 回溯到2，把当前节点和上一组的头结点连接起来
#           |
# 0 -> 1 -> 2 -> 5 -> 4 -> 3 -> 6 -> 7 head.next = groupHead
#
# 6. 依次回溯至结束，返回最后一组的头结点，就是整个翻转后链表的头结点

def postReverseInKGroup(head, ith, k)
	if head.nil? then
		head
	else
		# postReverserInKGroup返回上一组的链表的头结点
		groupHead = postReverseInKGroup(head.next, ith+1, k)
		if ith%k==0 then
			cur, newHead, breverse = normalReverse(head, 0, k)
			if breverse then
				# 如果这一组反转了，那么当前的节点head会变成最后一个元素
				# 我们要把它和它的前一组链表的头结点连接起来
				head.next = groupHead
			end
			# 返回当前组的头结点
			newHead
		elsif ith%k+1==k then
			head.next = groupHead
			groupHead
		else
			groupHead
		end
	end
end

# 这个普通的reverse链表，i表示第几个链表节点，n表示链表的长度
# 增加了一个特殊的条件，如果链表长度小于n，则不反转链表
# 为了满足这个条件，使用递归反转链表，先到最后一个，来判断是否需要反转链表
def normalReverse(head, i, n)
	if head.nil? then
		return head, head, false
	elsif n-i==1 then
		return head, head, true
	else
		last, newhead, breverse = normalReverse(head.next, i+1, n)
		if breverse then
			last.next = head
			head.next = nil
			return head, newhead, breverse
		else
			return head, head, breverse
		end
	end
end

[
	[[],1],
	[[1,2,3,4],2],
	[[1,2,3,4],3],
	[[1,2,3,4,5],3],
	[[1,2],3],
].each{|x|
	puts "#{x[0]} by #{x[1]} group : #{postReverseInKGroup(a2lHelper(x[0]),0,x[1])}"
	# puts "#{x[0]} by #{x[1]} group : #{normalReverse(a2lHelper(x[0]),0,x[1])}"
}
