#!/usr/bin/ruby
require_relative 'BinaryTree'

def ss2BsTree(seq, head, rear)
	if head == rear then
		BinaryTree.new(nil, nil, seq[head])
	elsif head > rear then
		nil
	else
		root = (head + rear)/2
		left = ss2BsTree(seq, head, root-1)
		right = ss2BsTree(seq, root+1, rear)
		BinaryTree.new(left, right, seq[root])
	end
end

seq = Array[2,3,4,5,6]
# seq = Array[2,3,4]
puts "#{seq}"

bst = ss2BsTree(seq, 0, seq.size-1)
puts bst
