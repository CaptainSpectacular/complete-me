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


  def find_node(word)
    ptr = self

    word.chars.each do |char|
      ptr = ptr.children[char]
    end

    ptr ? ptr : "Not found"
  end



  def find_children(node, kids = [])
    node.children.each do |child|

      kids << child[1]
      child[1].find_children(child[1], kids)

    end
    kids.select{|x| x.word?}
  end


  def find_parents(node, results = [])
    results << node.data
    find_parents(node.parent, results) unless node.parent.data == 'Master'
    results.reverse.join
    
  end


  def find_word(substring)
    start = find_node(substring)
    kids = find_children(start).compact
    words = []
    kids.each do |kid|
      words << kid.find_parents(kid)
    end
    
    words.uniq
  end

  

end