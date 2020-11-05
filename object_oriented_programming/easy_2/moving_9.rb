# Moving

# You have the following classes.

# You need to modify the code so that this works:

# mike = Person.new("Mike")
# mike.walk
# # => "Mike strolls forward"

# kitty = Cat.new("Kitty")
# kitty.walk
# # => "Kitty saunters forward"

# flash = Cheetah.new("Flash")
# flash.walk
# # => "Flash runs forward"
# You are only allowed to write one new method to do this.

# class Mammal

#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def walk
#     "#{name} #{self.gait} forward"
#   end
# end

# class Person < Mammal
#   private

#   def gait
#     "strolls"
#   end
# end

# class Cat < Mammal
#   private

#   def gait
#     "saunters"
#   end
# end

# class Cheetah < Mammal
#   private

#   def gait
#     "runs"
#   end
# end

# LS Solution

module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end


mike = Person.new("Mike")
p mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
p kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
p flash.walk
# => "Flash runs forward"

