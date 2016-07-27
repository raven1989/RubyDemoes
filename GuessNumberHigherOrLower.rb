#!/usr/bin/ruby
#We are playing the Guess Game. The game is as follows:
#
#I pick a number from 1 to n. You have to guess which number I picked.
#
#Every time you guess wrong, I'll tell you whether the number I picked is higher or lower.
#
#However, when you guess a particular number x, and you guess wrong, you pay $x. You win the game when you guess the number I picked.
#
#Example:
#
#n = 10, I pick 8.
#
#First round:  You guess 5, I tell you that it's higher. You pay $5.
#Second round: You guess 7, I tell you that it's higher. You pay $7.
#Third round:  You guess 9, I tell you that it's lower. You pay $9.
#
#Game over. 8 is the number I picked.
#
#You end up paying $5 + $7 + $9 = $21.
#Given a particular n ≥ 1, find out how much money you need to have to guarantee a win.

def getMoneyAmount(n)
	candidates = Array.new
	i = n-1
	if i<=0 then
		return 0
	end
	while i>0 do
		candidates.push(i)
		i-=2
	end
	p = Array.new(candidates.size)
	i = 0
	while i<p.size do
		p[i] = Array.new(candidates.size)
		i += 1
	end
	i = 0
	while i<p.size do
		p[i][i] = candidates[i]
		i += 1
	end
	delta = 1
	while delta<p.size do
		i = 0
		while i+delta<p.size do
			wp = Array.new
			j = i+delta
			k = i
			while k<=j do
				pl = 0
				pr = 0
				if k-1>=i then
					pl = p[i][k-1]
				end
				if k+1<=j then 
					pr = p[k+1][j]
				end
				wp.push(candidates[k] + Array[pl,pr].max)
				k+=1
			end
			p[i][j] = wp.min
			i+=1
		end
		delta += 1
	end
	return p[0][p.size-1]
end

cost = getMoneyAmount 18
puts cost
