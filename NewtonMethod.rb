#!/usr/bin/ruby

def binarySqrt(n)
	x = n/2.0
	tmp = x*x
	begin
		if tmp>n then
			x/=2.0
		else
			x*=1.5
		end
		tmp = x*x
	end while (n-tmp).abs>1e-6
	return x
end

n = 4
x = binarySqrt n
puts "binarySart #{n} : #{x}"

#牛顿迭代法求f(x)=0的解的近似值，随便找一点P0(x0,f(x0))
#过P0做切线与x轴交于一点L0，
#计算L0：切线方程L点斜式 y-f(x0)=f'(x0)*(x-x0) -> y=f'(0)*(x-x0)+f(x0)
#L0(x0-f(x0)/f'(x0),0), x1=x0-f(x0)/f'(x0)
#再过P1(x1, f(x1))做切线与x轴交于L1 etc.
#得到一组x的逼近序列x0,x1,x2,...
#通项公式：x(n) = x(n-1)-f(x(n-1))/f'(x(n-1))
#
#求一个数的开方 x^2 = n
#f(x)=x^2-n f'(x)=2x
#x(i) = x(i-1)-([x(i-1)]^2-n)/x(i-1)*2

def NewtonSqrt(n)
	if n<0 then
		return nil
	elsif n==0 then
		return 0.0
	end
	x = n/2.0
	tmp = x
	begin
		tmp = x
		x = x - (x*x-n)/(x*2)
	end while (x-tmp).abs>1e-6
	return x
end

x = NewtonSqrt n
puts "NewtonSqrt #{n} : #{x}"

#x^2+x+1=n
def NewtonX2X1(n)
	delta = 1+4*n
	if delta<0 then
		return nil
	end
	x = n/2.0
	tmp = x
	begin
		tmp = x
		x = x-(x*x+x+1-n)/(x*2+1)
	end while (x-tmp).abs>1e-6
	return x
end

n = 1
x = NewtonX2X1 n
puts "x^2+x+1=n when n=#{n} x=#{x}"
