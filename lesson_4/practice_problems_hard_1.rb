# Practice Problems: Hard 1

# Question 1
# Alyssa has been assigned a task of modifying a class that was initially created to keep track of secret information. The new requirement calls for adding logging, when clients of the class attempt to access the secret data. Here is the class in its current form:

class SecretFile

  def initialize(secret_data, security_logger)
    @data = secret_data
    @security_logger = security_logger
  end

  def data
    @security_logger.create_log_entry
    @data
  end
end

# She needs to modify it so that any access to data must result in a log entry being generated. That is, any call to the class which will result in data being returned must first call a logging class. The logging class has been supplied to Alyssa and looks like the following:

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end

# Hint: Assume that you can modify the initialize method in SecretFile to have an instance of SecurityLogger be passed in as an additional argument. It may be helpful to review the lecture on collaborator objects for this practice problem.

arr = [1, 2, 3]

security_logger = SecurityLogger.new

secret_file = SecretFile.new(arr, security_logger)

# Question 2

# Ben and Alyssa are working on a vehicle management system. So far, they have created classes called Auto and Motorcycle to represent automobiles and motorcycles. After having noticed common information and calculations they were performing for each type of vehicle, they decided to break out the commonality into a separate class called WheeledVehicle. This is what their code looks like so far:

# module Fuel
#   attr_writer :fuel_capacity, :fuel_efficiency
#   attr_accessor :speed, :heading

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end
# 
# class WheeledVehicle
#   include Fuel

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     @tires = tire_array
#     @fuel_efficiency = km_traveled_per_liter
#     @fuel_capacity = liters_of_fuel_capacity
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end
# 
#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end

# end

# class Auto < WheeledVehicle
#   def initialize
#     # 4 tires are various tire pressures
#     super([30,30,32,32], 50, 25.0)
#   end
# end

# class Motorcycle < WheeledVehicle
#   def initialize
#     # 2 tires are various tire pressures
#     super([20,20], 80, 8.0)
#   end
# end

# # Now Alan has asked them to incorporate a new type of vehicle into their system - a Catamaran defined as follows:

# class Catamaran
#   attr_reader :propeller_count, :hull_count

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     # ... code omitted ...
#   end
# end

# # This new class does not fit well with the object hierarchy defined so far. Catamarans don't have tires. But we still want common code to track fuel efficiency and range. Modify the class definitions and move code into a Module, as necessary, to share code among the Catamaran and the wheeled vehicles.


# auto = Auto.new

# p auto.range

# Question 3

# Building on the prior vehicles question, we now must also track a basic motorboat. A motorboat has a single propeller and hull, but otherwise behaves similar to a catamaran. Therefore, creators of Motorboat instances don't need to specify number of hulls or propellers. How would you modify the vehicles code to incorporate a new Motorboat class?

# class Motorboat < Catamaran

#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)

#   end
# end

# LS Solution (Question 3)

# We can create a new class to present the common elements of motorboats and catamarans. We can call it, for example, Seacraft. We still want to include the Moveable module to get the support for calculating the range.

module Moveable
  attr_writer :fuel_capacity, :fuel_efficiency
  attr_accessor :speed, :heading

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Seacraft
  include Moveable

  attr_reader :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end

  def range
    super + 10
  end
end
# We can now implement Motorboat based on the Seacraft definition. We don't need to include a reference to Moveable since that is already included in the Seacraft super class.

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end
# And we alter the Catamaran to inherit from Seacraft and move hull and propeller tracking out since it's taken over by Seacraft. We can also remove the reference to the Moveable module.

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end
# The super method automatically receives and passes along any arguments which the original method received. Because of that, we can remove the arguments being passed into super:

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super
  end
end
# In fact, because super is the only statement in this initialize method and there's nothing to override, we can remove it altogether.

class Catamaran < Seacraft
end

# Question 4



