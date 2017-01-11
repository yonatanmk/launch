class Bird
  attr_reader :name

  def initialize name
    @name = name
  end

  def fly(x)
    return Bird.new("Steve")
  end
end

arr = [Bird.new("Mark"), Bird.new("Evelyn"), Bird.new("Chris")]

puts arr.reduce(:fly).name
