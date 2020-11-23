class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    # super()
    @color = color
  end
end

puts "Yo bruno"

bruno = GoodDog.new("brown")  

puts bruno.name
# puts bruno.color



