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

def beatStock1(stocks)
  #这个要求不能当天买当天卖，必须至少差一天
  diff = []
  (1...stocks.size).each { |i| 
    diff[i-1] = stocks[i]-stocks[i-1]
  }
  #puts "#{diff}"
  # 求和最大子序列
  buy = sell = 0
  i = j = 0
  sum = max_sum = 0
  while j<diff.size do
    cur = sum + diff[j]
    if cur<0 then
      i = j+1 
      sum = 0
    else
      sum = cur
      if sum > max_sum then
        buy = i
        sell = j
        max_sum = sum
      end
    end
    j += 1
  end
  return buy,sell+1
end

[
  [2,7,1,3],
  [7,6,3,1],
].each { |stocks|
buy,sell = beatStock(stocks)
puts "beatStocks #{stocks} --> buy:#{buy} sell:#{sell}"
buy,sell = beatStock1(stocks)
puts "beatStocks1 #{stocks} --> buy:#{buy} sell:#{sell}"
}

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
