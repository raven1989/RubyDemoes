#!/usr/bin/ruby

class Prime
	def initialize
		@flags_ = Array[0,0,nil]
		@cur_ = 2
	end
	def next
		res = @cur_
		begin
			tmp = @cur_
			idx = 2
			while idx<=tmp do
				@flags_[tmp*idx] = 0
				idx+=1
			end
			@cur_+=1
		end while @flags_[@cur_]!=nil
		# puts "#{@flags_}"
		return res
	end
end

primes = Prime.new
i = 0
p = Array.new
while i<20 do 
	p.push(primes.next)
	i+=1
end
puts "#{p}"
