#!/usr/ruby/bin
#
#Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).
#
#For example,
#S = "ADOBECODEBANC"
#T = "ABC"
#Minimum window is "BANC".
#
#Note:
#If there is no such window in S that covers all characters in T, return the empty string "".
#
#If there are multiple such windows, you are guaranteed that there will always be only one unique minimum window in S.

#Satisfied Window Question
#
# 1. 移动window的右边：依次移动右边遍历每一个char
#    如果char不在T中，什么也不做，继续
#    如果char在T中，record(record记录当前window中各种char的数量)增加char的计数，如果record[char]==t中char出现的次数，count加1
# 2. 当找到一个valid window，条件是count值达到T中的char数量：
#    这时候window右边一定是首次指向了一个T中的char
#    window左边则不一定是，因此尝试左移，
#      左移条件是，如果left char不在T中或者left char在T中但record计数>t中当前char的计数(这说明window中在left char之后还有相同的char，所以不需要这个)
#    左移完成后是以left char为头的最小valid window(显而易见)
#    执行3
# 3. 找到一个valid window后，尝试更新最小window，
#    再将left char左移动一位，同时更新record和count

def minWindow(s, t)
  if s.nil? or t.nil? then
    return ""
  end
  chars = Hash.new
  t.chars.each{ |c| 
    if chars.include?(c) then
      chars[c] += 1
    else
      chars[c] = 1
    end
  }
  if chars.size > s.size then
    return ""
  end
  res = ""
  sa = s.chars
  minSize = sa.size
  left = 0
  i = 0
  record = Hash.new
  # 如果count==chars.size表示找到了一个valid window
  count = 0
  while i<sa.size do
    char = sa[i]
    if chars.include?(char) then
      if not record.include?(char) then
        record[char] = 1
      else
        # 如果加完是1，则说明是上次删除了，本次window首次出现
        record[char]+=1
      end
      if record[char]==chars[char] then 
        count += 1
      end
    end
    # 找到一个valid window
    if count==chars.size then
      #首先收缩左边，收缩后left char一定是在t中且当前window只有一个
      while left<i do
        leftChar = sa[left]
        # left char不是t中的字符
        if not chars.include?(leftChar) then
          left += 1
        # left char是t中的字符，切当前window中有不止一个时，可以去掉
        elsif record.include?(leftChar) and record[leftChar]>chars[leftChar] then
          record[leftChar] -= 1
          left += 1
        else
          break
        end
      end
      windowSize = i-left+1
      # puts "window : #{sa[left, windowSize].join("")}"
      if windowSize<=minSize then
        minSize = windowSize
        res = sa[left, windowSize].join("")
      end
      # 将left左边移动一个，继续寻找可能的valid window
      # 当前left指向的一定是t中的字符且record值为1
      record[sa[left]]-=1
      count -= 1
      left += 1
      if left>s.size-chars.size then
        break
      end
    end
    i += 1
  end
  res
end

[
  ["a","a"],
  ["a","aa"],
  ["ADOBECODEBANC","ABC"],
].each{ |x|
  puts "#{x[0]}, #{x[1]} : #{minWindow x[0],x[1]}"
}
