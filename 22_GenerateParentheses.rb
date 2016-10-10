#!/usr/ruby/bin
#
#Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

# For example, given n = 3, a solution set is:

# [
  # "((()))",
  # "(()())",
  # "(())()",
  # "()(())",
  # "()()()"
# ]
#
# 本质上是在0-2*n-1个位置上放"("，因为一旦所有的"("都放好了，那么")"的位置也确定了
# 1.0位置必须是一个"("
# 2.第二个"("可以放置的位置为[0+1, 2]，因为第二个"("后面至少有n-2対括号和自己的")" (2n-1)-(2*(n-2)+1) = 2
# 3.所以第i个"("可以放置的位置为[前一个"("的索引+1, (2n-1)-(2*(n-i)+1)=2(i-1)]
# 4.recursively, 对已经放置好第i个"("的所有结果，在每一个可能的位置上放置第i+1个

def generate(n)
	template = Array.new(n*2) {|x| x=")"}
	i = template.size/2-n+1
	generate4Recursion(template, 0, (i-1)*2, n).map{|x|
		x.join("")
	}
end

def generate4Recursion(template, first_i, last_i, n)
	# puts "#{template} #{n} #{first_i} #{last_i}"
	if n<= 0 then
		[template]
	else
		cur = []
		first_is = []
		k = first_i
		while k<=last_i do
			tmp = Array.new(template)
			tmp[k] = "("
			cur << tmp
			first_is << k
			k += 1
		end
		res = []
		(0...cur.size).each{ |index|
			i = template.size/2-(n-1)+1
			res += generate4Recursion(cur[index], first_is[index]+1, (i-1)*2, n-1)
		}
		res
	end
end

[
	0, 1, 2, 3,
].each{|x|
	puts "#{x} : #{generate x}"
}
