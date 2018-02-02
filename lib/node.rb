require 'pry'
class Node
  attr_accessor :data, :parent , :children
  def initialize(data, word = false)
    @data = data
    @children = Hash.new
    @word = word
  end


  def inspect
    "#{@data}"
  end

  def insert(word)
    current = self
    unless current.data.nil?
      word = word.chars
      char = word.shift

      if children.include?(char)
        current = children.fetch(char)
        current.insert(word.join)

      else
        children[char] = Node.new(char, word == [])
        current = children[char]
        current.insert(word.join)
      end
    else
      "done"
    end
  end


  def word?
    @word
  end


  def suggest(word, result = [])
    ptr = self
    word.chars.each do |char|
      ptr = children.fetch(char)
    end
    
    ptr.find_children
  end


  def find_children(result = [])
    children.each do |child|
      result << child[1].data
      child[1].find_children(result)
    end

    result
  end
  
end
