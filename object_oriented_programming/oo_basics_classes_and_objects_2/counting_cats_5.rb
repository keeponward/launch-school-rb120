# Counting Cats

# Using the following code, create a class named Cat that tracks the number of times a new Cat object is instantiated. The total number of Cat instances should be printed when ::total is invoked.


# Cat.total
# Expected output:

# 2

class Cat
  @@num_cats = 0

  def initialize
    @@num_cats += 1
  end

  def self.total
    puts @@num_cats
  end

end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total

