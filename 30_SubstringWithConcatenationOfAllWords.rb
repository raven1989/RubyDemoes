#!/usr/ruby/bin
#
#You are given a string, s, and a list of words, words, that are all of the same length. Find all starting indices of substring(s) in s that is a concatenation of each word in words exactly once and without any intervening characters.
#
#For example, given:
#s: "barfoothefoobarman"
#words: ["foo", "bar"]
#
#You should return the indices: [0,9].
#(order does not matter).

def findAllConcatenations(s, words)
  res = []
  if words.nil? then
    return res
  end
  patternOffset = words[0].size
  patternSize = words.size * patternOffset
  if patternSize > s.size then
    return res
  else
    hash = Hash.new
    words.each{ |word|
      hash.include?(word) ? hash[word]+=1 : hash[word]=1
    }
    (0..s.size-patternSize).each{ |index| 
      replicaHash = hash.dup
      (index...index+patternSize).step(patternOffset){ |i| 
        tmp = s[i,patternOffset]
        if replicaHash.include?(tmp) then
          if (replicaHash[tmp]-=1) == 0 then
            replicaHash.delete(tmp)
          end
        else
          break
        end
      }
      if replicaHash.size == 0 then
        res << index
      end
    }
    res
  end
end

# 维持一个satisfied window
# 维持一个window，尝试去扩充window
# 1. s=foobarfoo，当前window = foo，遇到bar是满足条件的词，扩充window = foobar
# 2. s=foovbar，当前window = foo，遇到vba不是一个满足条件的词，此时window移动到vba之后，window=r
#    (这里错过了bar，在后面解释如何处理)
# 3. s=foobarfoo，当前window = foobar，window已经满足条件，此时记录输出，将window移动一个词的width，window=bar，继续
# 4. s=foofoobar，当前window = foo，接下来的foo是一个满足条件的词，但扩充后window不满足条件，
#    此时应持续将window左边移动一个词的width，直到window满足条件或者为空，再继续
# 5. s=foobarfoo，当前window = foo，遇到bar是满足条件的词，扩充window = foobar，找到一个满足的解后，将window的左边移动一个width
#    window = bar
# 最后一个问题，如果遇到afoobar这种类型的，切割变为: afo|oob|ar
# 所以要循环单词width遍：从f开始切割 foo|bar，从o开始切割 oob|ar
#
# 以上方法最外层循环是width遍
# 每一遍过s.n/width次个词，所以时间复杂度是 width*s.n/width = s.n o(n)的
def findBySatisfiedWindow(s, words)
  res = []
  if s.nil? or words.nil? or s.size==0 or words.size==0 then
    return res
  end
  patternOffset = words[0].size
  patternSize = words.size * patternOffset
  if s.size < patternSize then
    return res
  end
  hash = Hash.new
  words.each{ |word|
    hash.include?(word) ? hash[word]+=1 : hash[word]=1
  }
  (0...patternOffset).each{ |start|
    curHash = Hash.new
    left = start
    # 找到合法词的计数，当findCnt==words.size时，说明是一个解
    findCnt = 0
    i = start
    while i<=s.size-patternOffset do
      if left > s.size-patternSize then
        break
      end
      word = s[i, patternOffset]
      if hash.include?(word) then
        # words中的词，尝试扩充window
        if not curHash.include?(word) then
          curHash[word] = 1
          findCnt += 1
        elsif curHash[word]<hash[word] then
          curHash[word]+=1 
          findCnt += 1
        else
          # 说明重复的词出现了，将第一个与word相同词前面的词都要去掉，因为它们不可能构成合法window了
          # 对应情况4
          while left<i and not (repeat=s[left, patternOffset]).eql?(word) do
            curHash[repeat]-=1 # 允许减到0，后面扩充时直接走上面的elsif逻辑
            findCnt -= 1
            left += patternOffset
          end
          if left<i then
            # 去掉第一个与word相同的词，不用更改curHash和findCnt，因为删除了上一个word还要加入当前word，结果不变
            left += patternOffset
          end
        end
        # puts "window : #{s[left, i-left+patternOffset]}"
        if findCnt==words.size then
          # 对应情况5
          res << left
          curHash[s[left, patternOffset]] -= 1
          findCnt -= 1
          left += patternOffset
          # puts "window : #{s[left, i-left+patternOffset]}"
        end
      else
        # 如果这个词压根就不在words中，说明当前window不可能有解了，reset 所有变量
        curHash.clear
        findCnt = 0
        # 从当前词的下一个词开始重做window
        left = i+patternOffset
        # puts "window : #{s[left, i-left+patternOffset]}"
      end
      i += patternOffset
    end
  }
  res
end

[
  ["barfoothefoobarman", ["foo","bar"]],
  ["wordgoodgoodgoodbestword", ["word","good","best","good"]],
  ["awordgoodgoodgoodbestword", ["word","good","best","good"]],
].each{ |x| 
  # puts "#{x[0]}, #{x[1]} : #{findAllConcatenations x[0],x[1]}"
  puts "#{x[0]}, #{x[1]} : #{findBySatisfiedWindow x[0],x[1]}"
}
