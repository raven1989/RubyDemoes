#!/usr/bin/ruby

def beatStock(stocks)
	buy = 0
	sell = 0
	min = 0
	max_diff = stocks[sell]-stocks[buy]
	for i in 0...stocks.size
		if stocks[buy] > stocks[i] then
			min = i
		end
		diff = stocks[i] - stocks[min]
		if diff > max_diff then
			max_diff = diff
			buy = min
			sell = i
		end
	end
	return buy,sell
end

stocks = [2,7,1,3]
buy,sell = beatStock(stocks)
puts "buy:#{buy} sell:#{sell}"

def maxDistance(seq)
	i = j = -1
	min = 0
	max = 0
	n = seq.size
	k = 0
	while k<n do
		if seq[k]<seq[min] then
			min = k
		end
		dist = seq[k]-seq[min]
		if dist > max then
			max = dist
			i = min
			j = k
		end
		k+=1
	end
	return i,j,(seq[j]-seq[i])
end

# seq = [2,6,1,2,6,7,0,9,3,5]
seq = [7,6,6,5,4]
i,j,d = maxDistance(seq)
puts "i:#{i} j:#{j} dist:#{d}"
