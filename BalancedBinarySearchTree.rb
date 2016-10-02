#!/usr/bin/ruby
 
# Definition for a binary tree node.
class TreeNode
	attr_accessor :val, :bf, :left, :right
	def initialize(val, bf=0, left=nil, right=nil)
		@val = val
		@left, @right = left, right
		@null = "nil"
    @bf = bf
	end
	def to_s
		if @left.nil? and @right.nil? then
			"#{@val}"
		else
			"#{@val}#<#{@left||@null},#{@right||@null}>"
		end
	end
	def inspect
		to_s
	end

  #Single L-rotation
  def lRotate()
    b = @right
    @right = b.left
    b.left = self
    @bf = b.bf = 0
    return b
  end
  #R-rotation then L-rotation
  def rLRotate()
    b = @right
    c = b.left
    #R-rotation
    b.left = c.right
    c.right = b
    #L-rotation
    @right = c.left
    c.left = self
    #set balance factor
    @bf = b.bf = 0
    if c.bf<0 then
      b.bf = 1
    elsif c.bf>0 then
      @bf = -1
    end
    c.bf = 0
    return c
  end
  #Single L-rotation
  def rRotate()
    b = @left
    @left = b.right
    b.right = self
    @bf = b.bf = 0
    return b
  end
  #L-rotation then R-rotation
  def lRRotate()
    b = @left
    c = b.right
    #L-rotation
    b.right = c.left
    c.left = b
    #R-rotation
    @left = c.right
    c.right = self
    #set balance factor
    @bf = b.bf = 0
    if c.bf<0 then
      @bf = 1
    elsif c.bf>0 then
      b.bf = -1
    end
    c.bf = 0
    return c
  end

  def inseart(pre,val)
    if val<@val then
      if @left.nil? then
        @left = TreeNode.new(val)
      else
        if @left.inseart(self,val)==0 then
          return 0
        end
      end
      if @bf<0 then
        if @left.bf<0 then
          pre.left = rRotate()
        else
          pre.left = lRRotate()
        end
        return 0
      end
      return @bf -= 1
    else
      if @right.nil? then
        @right = TreeNode.new(val)
      else
        if @right.inseart(self,val)==0 then
          return 0
        end
      end
      if @bf>0 then
        if @right.bf>0 then
          pre.right = lRotate()
        else
          pre.right = rLRotate()
        end
        return 0
      end
      return @bf += 1
    end
  end

end

root = TreeNode.new(20)
pre = TreeNode.new(0)
pre.right = root
puts "root : #{root}"
[10,30,5,8,9,40].each{|x|
  root.inseart(pre,x)
  root = pre.left||pre.right
  pre.right = root
  pre.left = nil
  puts "inseart #{x} : #{root}"
}
