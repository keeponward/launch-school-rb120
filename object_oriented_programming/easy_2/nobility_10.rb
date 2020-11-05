# Nobility

# Now that we have a Walkable module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.

# We need a new class Noble that shows the title and name when walk is called:

# byron = Noble.new("Byron", "Lord")
# p byron.walk
# # => "Lord Byron struts forward"
# We must have access to both name and title because they are needed for other purposes that we aren't showing here.

# byron.name
# => "Byron"
# byron.title
# => "Lord"

# Lifted from LS Solution (Discussion)
# module Walkable
#   def walk
#     "#{self} #{gait} forward"
#   end
# end

# class Person
#   attr_reader :name

#   include Walkable

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end

#   private

#   def gait
#     "strolls"
#   end
# end

# class Cat
#   attr_reader :name

#   include Walkable

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end

#   private

#   def gait
#     "saunters"
#   end
# end

# class Cheetah
#   attr_reader :name

#   include Walkable

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end

#   private

#   def gait
#     "runs"
#   end
# end

# class Noble
#   attr_reader :name, :title

#   include Walkable

#   def initialize(name, title)
#     @name = name
#     @title = title
#   end

#   def to_s
#     "#{title} #{name}"
#   end

#   private

#   def gait
#     "runs"
#   end
# end


# Further Exploration

class Mammal

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def walk
    "#{name} #{self.gait} forward"
  end
end

class Person < Mammal
  private

  def gait
    "strolls"
  end
end

class Cat < Mammal
  private

  def gait
    "saunters"
  end
end

class Cheetah < Mammal
  private

  def gait
    "runs"
  end
end

class Noble < Mammal

  def initialize(name, title)
    super(title + ' ' + name)
  end

  private

  def gait
    "struts"
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

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"


