#!/usr/bin/ruby
#i=当前人数，
#p(i)表示当前序列某人的位置，(位置编号为0~i-1)
#p(i-1)表示下一个序列中某人的位置，如果是淘汰的人，视他的位置为i-1
#举个例子，令m=3
#当i=5时，0 1 2 3 4
#当i=4时，2 3 4 0 1 其中4是假设的人，已经被淘汰了
#可以观察到
#p(i) = (p(i-1)+m) % i

def JosephCircle(n, m)
	out = 0
	i = 2
	while i<=n do
		out = (out+m)%i
		i+=1
	end
	return out
end

last = JosephCircle 6, 3
puts last
