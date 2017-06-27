#!/usr/ruby/bin
# 提供一个int rand()函数，在高度[1,H)之间随机选择一个高度，要求高度越高概率越低
# 这个东西使用在level db中决定一条数据在几层level的跳表中建立节点
# P(h=1) = 3/4
# P(h=2) = 1/4*3/4
# P(h=3) = 1/8*3/4
#

def randomHeight(max)
  h = 1
  while h<max
    if rand(max)%4==0 then
      h = h+1
    else
      break
    end
  end
  h
end

[
  12, 
].each{|x| 
  puts "#{x} : #{randomHeight x}"
}
