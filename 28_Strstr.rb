#!/usr/ruby/bin
#Implement strStr().
#
#Returns the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

def strStr(haystack, needle)
  if needle.size==0 then
    return 0
  elsif needle.size>haystack.size then
    return -1
  end
  (0...haystack.size-needle.size+1).each{ |index| 
    i = index
    j = 0
    while j<needle.size and haystack[i]==needle[j] do
      i+=1
      j+=1
    end
    if j==needle.size then
      return index
    end
  }
  -1
end

[
  ["", ""],
  ["aaa", "aa"],
  ["abaa", "aa"],
].each{|x|
  puts "#{x[0]}, #{x[1]} : #{strStr x[0],x[1]}"
}
