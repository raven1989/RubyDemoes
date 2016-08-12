#!/usr/bin/ruby
#The thief has found himself a new place for his thievery again. There is only one entrance to this area, called the "root." Besides the root, each house has one and only one parent house. After a tour, the smart thief realized that "all houses in this place forms a binary tree". It will automatically contact the police if two directly-linked houses were broken into on the same night.
#
#Determine the maximum amount of money the thief can rob tonight without alerting the police.

#Example 1:
#		 3
#		/ \
#	 2   3
#		\   \ 
#		 3   1
#Maximum amount of money the thief can rob = 3 + 3 + 1 = 7.
#Example 2:
#		 3
#		/ \
#	 4   5
#	/ \   \ 
# 1   3   1
#Maximum amount of money the thief can rob = 4 + 5 = 9.
#
#后序遍历，从叶子开始，对于每一个子树结构
#                                root
#                             /         \
#              /     left_root          right_root        \
# left_subtree|       /     \              /     \         |right_subtree
#              \  last_left_subtree   last_right_subtree  /
#
# f(root) = max( f(left_subtree)+f(right_subtree), root+f(last_left_subtree)+f(last_right_subtree) )
 
# Definition for a binary tree node.
class TreeNode
	attr_accessor :val, :left, :right
	def initialize(val, left=nil, right=nil)
		@val = val
		@left, @right = left, right
		@null = "nil"
	end
	def to_s
		if @left.nil? and @right.nil? then
			"#{@val}"
		else
			"#{@val}#<#{@left||@null},#{@right||@null}>"
		end
	end
	def inspect
		to_s
	end
end

def rob(root)
	now, last = postTraverse root
	now
end

def postTraverse(root)
	if root.nil? then
		return 0,0
	end
	left, left_last = postTraverse(root.left)
	right, right_last = postTraverse(root.right)
	return [left+right, root.val+left_last+right_last].max, left+right
end

[
	nil,
	TreeNode.new(3, TreeNode.new(2,nil,TreeNode.new(3)), TreeNode.new(3,nil,TreeNode.new(1)))
].each { |x| 
	puts "#{x} : #{rob x}"
}
