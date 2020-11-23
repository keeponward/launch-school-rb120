module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Student

  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def to_s
    "I'm a student. My name is: #{name}.  My grade is: #{grade}"
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

class Vehicle

  @@num_vehicles = 0

  attr_accessor :color
  attr_accessor :model
  attr_reader :year

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0

    @@num_vehicles += 1
  end

  def self.get_num_vehicles()
    @@num_vehicles
  end

  def speed_up(num)
    @current_speed += num
    puts "Increased your speed by #{num} mph"
  end

  def brake(num)
    @current_speed -= num
    puts "Decreased your speed by #{num} mph"
  end

  def shut_off
    @current_speed = 0
    puts "Park this punk"
  end

  def speed_now()
    puts "Current speed is: #{@current_speed} mph"
  end

  def spray_paint(color)
    puts "Spray painting the car to be #{color}"
    self.color = color
  end

  def to_s
    "My car is a #{color}, #{year}, #{model}!"
  end

  def print_vars()
    puts "year is: #{year}"
    puts "color is: #{color}"
    puts "model is: #{model}"
    puts "current_speed is: #{@current_speed} mph"
  end

  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2

  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    super(year, color, model)
  end
end

class MyCar < Vehicle

  NUMBER_OF_DOORS = 4

  def initialize(year, color, model)
    super(year, color, model)
  end
end

my_car = MyCar.new(2007, 'White', 'Highlander')
my_car.speed_now
my_car.speed_up(50)
my_car.speed_now

puts my_car.color
puts my_car.year

my_car.color = 'Tan'
puts my_car.color

my_car.print_vars

my_car.spray_paint('Purple')

my_car.print_vars

puts Vehicle.gas_mileage(156, 5)

puts my_car

my_truck = MyTruck.new(2000, 'Blue', 'F-100')

my_truck.speed_now
my_truck.speed_up(40)
my_truck.speed_now

puts my_truck.color
puts my_truck.year

my_truck.color = 'Tan'
puts my_truck.color

my_truck.print_vars

my_truck.spray_paint('Purple')

my_truck.print_vars

puts Vehicle.get_num_vehicles


# puts MyCar.ancestors
# puts MyTruck.ancestors
# puts Vehicle.ancestors


puts my_car.age
puts my_truck.age


my_student = Student.new('Bill', 88)

puts my_student

# puts my_student.grade

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than?(bob)

class Rock

end

def Rock.info
   "This is a Rock class"
end

p Rock.info



class Stone

end

stone = Stone.new

def stone.info
    "This is a stone object"
end

p stone.info


def volume_up;  puts "volume up"; end

volume_up