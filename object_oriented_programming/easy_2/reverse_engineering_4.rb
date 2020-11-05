# Reverse Engineering
# Write a class that will display:

# ABC
# xyz
# 
# when the following code is run:

class Transform

  def self.lowercase(str)
    str.downcase
  end

  def initialize(name)
    @name = name
  end

  def uppercase
    @name.upcase
  end

end


my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')