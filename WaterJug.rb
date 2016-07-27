#!/usr/bin/ruby
#You are given two jugs with capacities x and y litres. There is an infinite amount of water supply available. You need to determine whether it is possible to measure exactly z litres using these two jugs.
#
#If z liters of water is measurable, you must have z liters of water contained within one or both buckets by the end.
#
#Operations allowed:
#
#Fill any of the jugs completely with water.
#Empty any of the jugs.
#Pour water from one jug into another till the other jug is completely full or the first jug itself is empty.
#
#设i次操作时，两瓶子中的水总量为t(i)，显然 0<= t(i) <=x+y，
#显然ti组成的序列就是能得到的结果集
#在第i次时，我们面临的操作有 
#          | t(i)-y t(i)>=y
# t(i+1) = |
#          | t(i)-x t(i)>=x
#这个过程可以一直执行n次持续到t(i)<(x or y)，这个过程相当于 t(i+n) = t(i)%x or t(i+n)%y  --------- (1)
#不选取 t(i)+y or t(i)+x 的原因是  t(i-1)=t(i)+(y or x)
#当然如果交替进行就不一样了：t(i)=t(i-1)-x t(i+1)=t(i)-y  ---------------------------------------- (2)
#

def measurable?(x, y, z)
	if z>x+y then
		return false
	end
	p = Array.new(x+y+1)
	q = Queue.new
	p[0] = 1
	p[x] = 1
	p[y] = 1
	p[x+y] = 1
	min = x<y ? x : y
	max = x+y-min
	p[min*2] = 1
	if not p[z].nil? then
		return true
	end
	q.push(max)
	while not q.empty? do
		cur = q.deq(true)
		tmp1 = cur-max
		if tmp1>0 and p[tmp1].nil? then
			if tmp1==z then return true end
			p[tmp1] = 1
			q.push(tmp1)
			tmp1 += min
			if tmp1<x+y and p[tmp1].nil? then
				if tmp1==z then return true end
				p[tmp1] = 1
				q.push(tmp1)
			end
		end
		tmp2 = cur-min
		if tmp2>0 and p[tmp2].nil? then
			if tmp2==z then return true end
			p[tmp2] = 1
			q.push(tmp2)
			tmp2 += max
			if tmp2<x+y and p[tmp2].nil? then
				if tmp2==z then return true end
				p[tmp2] = 1
				q.push(tmp2)
			end
		end
	end
	return (not p[z].nil?)
end

def measurable1?(x, y, z)
	if z>x+y then
		return false
	end
	if z==0 then return true end
	if x==0 then return z==y end
	if y==0 then return z==x end
	c = gcd(x,y)
	return z%c==0
end
def gcd(x, y)
	min = x<y ? x : y
	max = x-min+y
	return modAndSwap(max, min)
end
def modAndSwap(max, min)
	tmp = max%min
	if tmp==0 then
		return min
	end
	return modAndSwap(min, tmp)
end

x = 22003
y = 31237
z = 1
puts "#{measurable?(x,y,z)}"
puts "#{measurable1?(x,y,z)}"
