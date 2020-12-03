# Privacy

# Consider the following class:

# Modify this class so both flip_switch and the setter method switch= are private methods.


class Machine

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def state
    self.read_switch
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end

  def read_switch()
    self.switch
  end
  
end

# LS Solution
class Machine
  
  def start
    flip_switch(:on)     # self.flip_switch(:on) is okay in Ruby 2.7 or higher
  end

  def stop
    flip_switch(:off)    # self.flip_switch(:off) is okay in Ruby 2.7 or higher
  end

  def [](index)
    puts "Hi Karl.  The index you passed in is: #{index}"
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

my_machine = Machine.new

my_machine.stop
my_machine.start

puts my_machine[4]


