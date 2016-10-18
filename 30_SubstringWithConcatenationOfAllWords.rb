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

[
  ["barfoothefoobarman", ["foo","bar"]],
  ["wordgoodgoodgoodbestword", ["word","good","best","good"]],
].each{ |x| 
  puts "#{x[0]}, #{x[1]} : #{findAllConcatenations x[0],x[1]}"
}
