class Person
  attr_accessor :name, :first_name, :last_name 
  def initialize(name)
    @name = name
    @first_name = name
    @last_name = ''
  end

  def name
    first_name + ' ' + last_name
  end
end

# Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
