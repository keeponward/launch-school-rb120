# Unexpected Change

# Modify the following code to accept a string containing a first and last name. The name should be split into two instance variables in the setter method, then joined in the getter method to form a full name.

# Expected output:

# John Doe

class Person
  attr_accessor :name

  def name=(name)
    arr = name.split(' ')
    @first = arr[0]
    @last = arr[1]
  end

  def name
    arr = []
    arr << @first << @last
    arr.join(' ')
  end
  
end

# LS Solution
class Person
  def name=(name)
    @first_name, @last_name = name.split(' ')
  end

  def name
    "#{@first_name} #{@last_name}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
