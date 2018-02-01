require 'pry'
class Node
  attr_accessor :data, :parent , :children
  def initialize(data)
    @data = data
    @children = Hash.new
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
        children[char] = Node.new(char)
        current = children[char]
        current.insert(word.join)
      end
    else
      "done"
    end
  end


  def suggest(word, result = [])

  end
  

  def recursive_children(result)
    children.each do |child|
      result << child.data
      child.recursive_children(result)
    end

    result
  end
  
end
