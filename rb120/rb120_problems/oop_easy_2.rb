# 1. Fix the Program - Mailable
# Correct the following program so it will work properly. Assume that the Customer
# and Employee classes have complete implementations; just make the smallest possible
# change to ensure that objects of both types have access to the print_address method.

# module Mailable
#   def print_address
#     puts "#{name}"
#     puts "#{address}"
#     puts "#{city}, #{state} #{zipcode}"
#   end
# end

# class Customer
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# class Employee
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# betty = Customer.new 
# bob = Employee.new
# betty.print_address
# bob.print_address

# 2. Fix the Program - Drivable
# Correct the following program so it will work properly. Assume that the Car class has
# a complete implementation; just make the smallest possible change to ensure that cars
# have access to the drive method.

# module Drivable
#   def drive
#   end
# end

# class Car
#   include Drivable
# end

# bobs_car = Car.new
# bobs_car.drive

# 3. Complete The Program - Houses
# Assume you have the following code:
# class House
#   include Comparable
  
#   attr_reader :price

#   def initialize(price)
#     @price = price
#   end
  
#   def <=>(other)
#     price <=> other.price
#   end
# end

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < home2
# puts "Home 2 is more expensive" if home2 > home1

# 4. Reverse Engineering
# Write a class that will display:
# ABC
# xyz

# class Transform
#   attr_reader :text
#   def initialize(text)
#     @text = text
#   end
  
#   def uppercase
#     text.upcase
#   end
    
  
#   def self.lowercase(text)
#     text.downcase
#   end
# end

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')

# 5. What Will This Do?
# What will the following code print?

# class Something
#   def initialize
#     @data = 'Hello'
#   end

#   def dupdata
#     @data + @data
#   end

#   def self.dupdata
#     'ByeBye'
#   end
# end

# thing = Something.new
# puts Something.dupdata # => "ByeBye"
# puts thing.dupdata # => "HelloHello"

# 6. Comparing Wallets
# Consider the following broken code:

# class Wallet
#   include Comparable

#   def initialize(amount)
#     @amount = amount
#   end

#   def <=>(other_wallet)
#     amount <=> other_wallet.amount
#   end
  
#   protected
#   attr_reader :amount
# end

# bills_wallet = Wallet.new(500)
# pennys_wallet = Wallet.new(465)
# if bills_wallet > pennys_wallet
#   puts 'Bill has more money than Penny'
# elsif bills_wallet < pennys_wallet
#   puts 'Penny has more money than Bill'
# else
#   puts 'Bill and Penny have the same amount of money.'
# end

# 7. Pet Shelter
# Consider the following code:

# class Shelter
#   attr_reader :adoptions, :animal_shelter
  
#   def initialize(animal_shelter)
#     @adoptions = Hash.new([])
#     @animal_shelter = Owner.new(animal_shelter)
#   end
  
#   def adopt(owner=@animal_shelter, pet)
#     update_pets(pet)
#     adoptions[owner] += [pet]
#     owner.increment_pets
#   end
  
#   def update_pets(pet)
#     adoptions.each do |owner, pets|
#       next unless pets.include?(pet) 
#       pets.delete(pet)
#       owner.decrement_pets
#     end
#   end
  
#   def print_adoptions
#     adoptions.each do |owner, pets|
#       case owner
#       when animal_shelter
#         puts "The #{owner.name} has the following unadopted pets:"
#       else
#         puts "#{owner.name} has adopted the following pets:"
#       end
#       pets.each do |pet|
#         puts pet
#       end
#       puts
#     end
#   end
# end

# class Pet
#   attr_reader :kind, :name
  
#   def initialize(kind, name)
#     @kind = kind
#     @name = name
#   end
  
#   def to_s
#     "a #{kind} named #{name}"
#   end
# end

# class Owner
#   attr_reader :name
#   attr_accessor :number_of_pets
  
#   def initialize(name)
#     @name = name
#     @number_of_pets = 0
#   end
  
#   def increment_pets
#     self.number_of_pets += 1
#   end
  
#   def decrement_pets
#     self.number_of_pets -= 1
#   end
# end
# butterscotch = Pet.new('cat', 'Butterscotch')
# pudding      = Pet.new('cat', 'Pudding')
# darwin       = Pet.new('bearded dragon', 'Darwin')
# kennedy      = Pet.new('dog', 'Kennedy')
# sweetie      = Pet.new('parakeet', 'Sweetie Pie')
# molly        = Pet.new('dog', 'Molly')
# chester      = Pet.new('fish', 'Chester')

# casper       = Pet.new('parakeet', 'Casper')
# jaden        = Pet.new('dog', 'Jaden')
# cooper       = Pet.new('dog', 'Cooper')

# phanson = Owner.new('P Hanson')
# bholmes = Owner.new('B Holmes')

# shelter = Shelter.new("Animal Shelter")
# shelter.adopt(phanson, butterscotch)
# shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
# shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
# shelter.adopt(bholmes, molly)
# shelter.adopt(bholmes, chester)

# shelter.adopt(casper)
# shelter.adopt(jaden)
# shelter.adopt(cooper)

# shelter.adopt(phanson, jaden)

# shelter.print_adoptions
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
# puts "The #{shelter.animal_shelter.name} has #{shelter.animal_shelter.number_of_pets} adopted pets."
# Write the classes and methods that will be necessary to make this code run,
# and print the following output:

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.

# 8. Pet ShelterFix The Program - Expander
# What is wrong with the following code? What fix(es) would you make?
# class Expander
#   def initialize(string)
#     @string = string
#   end

#   def to_s
#     expand(3)
#   end

#   private

#   def expand(n)
#     @string * n
#   end
# end

# expander = Expander.new('xyz')
# puts expander

# 9. Moving
# You have the following classes.

module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    @name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    @name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    @name
  end

  private

  def gait
    "runs"
  end
end

# You need to modify the code so that this works:

mike = Person.new("Mike")
p mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
p kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
p flash.walk
# => "Flash runs forward"

# You are only allowed to write one new method to do this.

# 10. Nobility
# Now that we have a Walkable module, we are given a new challenge.
# Apparently some of our users are nobility, and the regular way of walking
# simply isn't good enough. Nobility need to strut.


class Noble
  include Walkable
  
  attr_reader :name, :title
  
  def initialize(name, title)
    @name = name
    @title = title
  end
  
  def to_s
    "#{title} #{@name}"
  end
  
  def gait
    "struts"
  end
end

# We need a new class Noble that shows the title and name when walk is called:
byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"

# We must have access to both name and title because they are needed for other
# purposes that we aren't showing here.
p byron.name
# => "Byron"
p byron.title
# => "Lord"