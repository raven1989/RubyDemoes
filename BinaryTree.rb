#!/usr/bin/ruby

class BinaryTree < Struct.new(:left, :right, :value)
	def to_s
		lstr = left.nil?? "":"#{left} "
		rstr = right.nil?? "":" #{right}"
		lstr+value.to_s+rstr
	end
	def inspect
		"#{self}"
	end
	def set_left(l)
		self.left = l
	end
	def set_right(r)
		self.right = r
	end
end
