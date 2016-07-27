#!/usr/bin/ruby

def wholePosibilities(coin)
	n = coin.length
	p = Array.new(n)
	for i in 0..n-1
		p[i] = Array.new(n)
	end
	for i in 0..n-1
		p[i][i] = coin[i]
	end
	for i in 0..n-2
		p[i][i+1] = coin[i]>coin[i+1]? coin[i]:coin[i+1]
	end
	for j in 2..n-1
		i = 0
		while i<n && j<n do
			pi = coin[i] + (p[i+2][j]<p[i+1][j-1]? p[i+2][j]:p[i+1][j-1])
			pj = coin[j] + (p[i+1][j-1]<p[i][j-2]? p[i+1][j-1]:p[i][j-2])
			p[i][j] = pi>pj ? pi:pj
			i+=1
			j+=1
		end
	end
	# puts "#{p}"
	# puts p[0][n-1]
	return p
end

def printMoves(p)
	n = p.size
	i = 0
	j = n-1
	winner = Array.new
	loser = Array.new
	while i<j do
		if p[i+1][j]<p[i][j-1] then
			winner.push(i)
			i+=1
		else
			winner.push(j)
			j-=1
		end
		if i==j then
			loser.push(i)
			break
		end
		if p[i+1][j]<p[i][j-1] then
			loser.push(i)
			i+=1
		else
			loser.push(j)
			j-=1
		end
	end
	return winner,loser
end

coin = Array[1,1,5,1,2,3,1,2]
# coin = Array[1,2,5,3,1,1]
puts "coins : #{coin}"
p = wholePosibilities coin
winner, loser = printMoves(p)
puts "winner:#{winner}\nloser:#{loser}"
