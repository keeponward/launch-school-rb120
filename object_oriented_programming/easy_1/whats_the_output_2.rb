# What's the Output?

# Take a look at the following code:

# What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase!
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name  # => Fluffy
puts fluffy       # => My name is FLUFFY.
puts fluffy.name  # => FLUFFY
puts name         # => FLUFFY

# FE
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name



