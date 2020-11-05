# Hello, Chloe!
# 
# Using the following code, add an instance method named #rename that renames kitty when invoked.

# Expected output:

# Sophie
# Chloe


class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(rep_name)
    self.name = rep_name
  end
end

kitty = Cat.new('Sophie')
p kitty.name
kitty.rename('Chloe')
p kitty.name


