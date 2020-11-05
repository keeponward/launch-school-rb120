# Calculated Age

# Using the following code, multiply @age by 2 upon assignment, then multiply @age by 2 again when @age is returned by the getter method.

# Expected output:

# 80


class Person
  def age=(age)
    @age = 2 * age
  end
  
  def age
    2 * @age
  end
end

person1 = Person.new
person1.age = 20
puts person1.age
