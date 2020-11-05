# Generic Greeting (Part 1)

# Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.

# Expected output:

# Hello! I'm a cat!

class Cat

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

end

kitty = Cat.new

Cat.generic_greeting

p kitty.class

# kitty.class is the class, Cat

kitty.class.generic_greeting


