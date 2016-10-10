#!/usr/bin/ruby
require_relative 'BinaryTree'
require_relative 'Heap'

left = BinaryTree.new(nil,nil,4)
right = BinaryTree.new(nil,nil,6)
root = BinaryTree.new(nil,nil,5)
puts left,right
root.set_left(left)
root.set_right(right)
puts root

mheap = Heap.new(">")
# mheap.test(Array[1,2,3,4,5])
for it in Array[2,1,3,5,0,6] do
	mheap.push(it)
end
puts mheap
mheap.pop
puts mheap

class E < Struct.new(:value)
	def < other
		return value<other.value
	end
	def to_s
		"#{value}"
	end
	def inspect
		to_s
	end
end

eheap = Heap.new()
e = Array[E.new(1), E.new(1), E.new(2), E.new(1), E.new(2), E.new(2)]
for it in e do
	eheap.push(it)
end
puts eheap
