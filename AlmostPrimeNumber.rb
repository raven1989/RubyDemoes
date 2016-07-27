#!/usr/bin/ruby
#A k-Almost Prime Number is a number having exactly k prime factors (not necessary distinct).
#
#For example,
#2, 3, 5, 7, 11 ….(in fact all prime numbers) are 1-Almost Prime Numbers as they have only 1 prime factors (which is themselves).
#4, 6, 9…. are 2-Almost Prime Numbers as they have exactly 2 prime factors (4 = 2*2, 6 = 2*3, 9 = 3*3)
#Similarly 32 is a 5-Almost Prime Number (32 = 2*2*2*2*2) and so is 72 (2*2*2*3*3)
#All the 1-Almost Primes are called as Prime Numbers and all the 2-Almost Prime are called as semi-primes.
#The task is to print first n numbers that are k prime.

def countPrimeFactor(num)
	n = num
	count = 0
	if n<2 then
		return count
	end
	while n%2==0 do
		count+=1
		n/=2
	end
	i=3
	while i<Math.sqrt(num).ceil do
		while n%i==0 do
			count+=1
			n/=i
		end
		i+=2
	end
	if n>2 then
		count+=1
	end
	return count
end

def almostPrimeNumber(k, n)
	cnt = 0
	i = 2
	res = Array.new
	while cnt<n do
		if countPrimeFactor(i)==k then
			res.push(i)
			cnt+=1
		end
		i+=1
	end
	return res
end

n = 10
cnt = countPrimeFactor(n)
puts "#{n} #{cnt}"

res = almostPrimeNumber(2, 7)
puts "#{res}"
