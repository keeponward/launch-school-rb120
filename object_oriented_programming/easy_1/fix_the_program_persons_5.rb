# Fix the Program - Persons

# Complete this program so that it produces the expected output:

# Expected output:

# John Doe
# Jane Smith

class Person

  def initialize(first_name, last_name)
    self.first_name = first_name
    self.last_name = last_name
    # @first_name = first_name.capitalize
    # @last_name = last_name.capitalize
  end

  def first_name=(first_name)
    @first_name = first_name.capitalize
  end

  def last_name=(last_name)
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

