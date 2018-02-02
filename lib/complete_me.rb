require './lib/node'
class CompleteMe
  attr_reader :dictionary, :root

  def initialize
    @dictionary = []
    @root = Node.new("Master")
  end

  
  def insert(word)
    root.insert(word)
  end


  def populate(dictionary = './words')
    file = File.open(dictionary)
    file.readlines.each{ |line| @dictionary << line.strip }
    file.close
  end


  def suggest(word)
    root.suggest(word)
  end


  def import_dictionary
    dictionary.each{ |d| insert(d.downcase)}
  end

end