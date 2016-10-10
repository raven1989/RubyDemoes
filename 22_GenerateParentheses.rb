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

#我们再来写一个tricky的后序遍历方法
#令i表示放置第i个(，i=0,1,2,...,n-1
#那么第i个括号可以放的范围是[i,2i]，计算方式：
#i后面还有n-i-1对，再加上i自己对应的)，总共是2n个括号，所以上界的索引是：
#2n-[2(n-i-1)+1]-1 = 2i
#             (
#     ((             (x(
#((( ((x( ((xx(   (x(( (x(x(
#可以看到这是一个不定多叉树，依然可以深度递归，后序放置

def postPlace(n)
  place(0, 0, n).map{ |x| 
    x.join("")
  }
  #place(0, 0, n)
end

#i表示放置第几个(，从0开始计，first表示当前数组可放置(的第一个位置索引，n为总数
def place(i, first, n)
  if i==n then
    #i==n时，已经到达根节点，有多少根节点就有多少解，所以在这里初始化括号数组
    solution = Array.new(n*2){|e| e=")"}
    [solution]
  else
    #从j=first开始，假设放置了(在j位置，然后将剩下的空位递归给下一个去放置第i+1个(
    #放置好第i+1个之后返回，再真的把(放在j位置，因为数组是在叶子节点才生成的
    #it's tricky，但是好处是不用提前处理有多少个结果
    solutions = []
    (first..(2*i)).each{ |j|
      cur = place(i+1, j+1, n)
      cur.map{ |solution| 
        solution[j] = "("
      }
      solutions += cur
    }
    solutions
  end
end

[
	0, 1, 2, 3,
].each{|x|
	puts "#{x} : #{generate x}"
	puts "#{x} : #{postPlace x}"
}
