# Pet Shelter (Further Exploration)
# Consider the following code:

# Write the classes and methods that will be necessary to make this code run, and print the following output:

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# The Animal Shelter has the following unadopted pets:
# a dog named Asta
# a dog named Laddie
# a cat named Fluffy
# a cat named Kat
# a cat named Ben
# a parakeet named Chatterbox
# a parakeet named Bluebell
#    ...


# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.
# The Animal shelter has 7 unadopted pets.

# The order of the output does not matter, so long as all of the information is presented.


class Pet
  attr_accessor :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end

end

class Owner
  attr_accessor :name, :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end

  def inc_num_pets
    @number_of_pets += 1
  end

end

class Shelter
  attr_accessor :hash

  def initialize
    @hash = {}
    @pet_arr = []
  end

  def admit_pet(pet)
    # puts pet
    @pet_arr << pet
  end

  def adopt(owner, pet)
    if @pet_arr.include?(pet)
      if @hash.has_key?(owner.name)
        @hash[owner.name] << pet
      else
        @hash[owner.name] = [pet]
      end
      owner.inc_num_pets
      @pet_arr.delete(pet)
    else
      puts "#{pet} is not available for adoption."
    end
  end

  def print_adoptions
    @hash.each do |name, arr_of_adopted_pets|
      puts ""
      puts "#{name} has adopted the following pets:"
      puts arr_of_adopted_pets
    end
    puts ""
  end

  def print_unadoptions
    puts "The Animal Shelter has the following unadopted pets:"
    puts ""
    puts @pet_arr
    puts ""
  end
end



butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

asta          = Pet.new('dog', 'Asta')
laddie        = Pet.new('dog', 'Laddie')
fluffy        = Pet.new('cat', 'Fluffy')
kat           = Pet.new('cat', 'Kat')
ben           = Pet.new('cat', 'Ben')
chatterbox    = Pet.new('parakeet', 'Chatterbox')
bluebell      = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new

shelter.admit_pet(butterscotch)
shelter.admit_pet(pudding)
shelter.admit_pet(darwin)
shelter.admit_pet(kennedy)
shelter.admit_pet(sweetie)
shelter.admit_pet(molly)
shelter.admit_pet(chester)
shelter.admit_pet(asta)
shelter.admit_pet(laddie)
shelter.admit_pet(fluffy)
shelter.admit_pet(kat)
shelter.admit_pet(ben)
shelter.admit_pet(chatterbox)
shelter.admit_pet(bluebell)


shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions
shelter.print_unadoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."




