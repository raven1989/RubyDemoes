#!/usr/bin/ruby

class Heap
	def initialize(compare="<")
		@heap_ = Array.new
		@cnt_ = 0
		@compare_ = compare
	end
	
	def shiftDown(i)
		tmp = @heap_[i]
		while i<@cnt_ do
			left = i*2+1
			right = left+1
			cur = left
			if right<@cnt_ and eval("@heap_[right]"+@compare_+"@heap_[left]") then
				cur = right
			end
			# puts "#{i} #{cur}"
			if cur<@cnt_ and eval("@heap_[cur]"+@compare_+"tmp") then
				@heap_[i] = @heap_[cur]
				i = cur
			else
				@heap_[i] = tmp
				break
			end
		end
	end

	def shiftUp(i)
		tmp = @heap_[i]
		while i>=0 do
			father = (i-1)/2
			if father>=0 and eval("tmp"+@compare_+"@heap_[father]") then
				@heap_[i] = @heap_[father]
				i = father
			else
				@heap_[i] = tmp
				break
			end
		end
	end

	def push(e)
		@heap_.push(e)
		shiftUp(@cnt_)
		@cnt_ += 1
	end

	def top
		if @cnt_>0 then
			return @heap_[0]
		end
	end

	def pop
		if @cnt_>0 then
			res = @heap_[0]
			@cnt_ -= 1
			if @cnt_>0 then
				@heap_[0] = @heap_[@cnt_]
				@heap_.delete_at(@cnt_)
				shiftDown(0)
			elsif @cnt_==0 then
				@heap_.delete_at(@cnt_)
			end
			return res
		end
	end

	def empty?
		return (not @cnt_>0)
	end

	def test(a)
		@heap_ = a
		@cnt_ = a.size
		shiftDown(0)
	end

	def to_s
		"#{@heap_}"
	end

end
