require 'pry'
class Node
  attr_accessor :data, :parent , :children
  def initialize(data, parent, word = false)
    @data = data
    @children = Hash.new
    @parent = parent
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
        children[char] = Node.new(char, self,word == [])
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


  def suggest(word)
    ptr = self
    word.chars.each do |char|
      ptr = children.fetch(char)
    end
    
    ptr.find_word(word, ptr)
  end


  def find_word(word, ptr)
    children.map do |child|
      return child[1].find_ancestors if child[1].word?
      ptr = child[1]
      child[1].find_word(word, ptr)
    end
  end


  def find_ancestors(result = [])
    ptr = self
    until ptr.data == "Master"
      result << ptr.data
      ptr = ptr.parent
    end

    result.reverse.join
  end
  
end
