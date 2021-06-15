module Speak
  def speak(sound)
    puts sound
  end
end

# class GoodDog
#   include Speak
# end

class HumanBeing
  include Speak
end

# sparky = GoodDog.new
# sparky.speak("Arf!")

bob = HumanBeing.new
# bob.speak("Hello!")

# Ancestors
# Method lookup chain
# puts "---GoodDog ancestors---"
# puts GoodDog.ancestors
# puts ''
# puts "---HumanBeing ancestors---"
# puts HumanBeing.ancestors

# How do we create an object in Ruby?
# Give an example of the creation of an object.

# In Ruby classes define objects
# Objects are created by using the class keyword
# For example
# class CellPhone
#   include Call
# end

# iphone = CellPhone.new

# What is a module? What is its purpose? How do we
# use them with our classes? Create a module for the
# class you created in exercise 1 and include it properly.

# A module is a collection of behaviors that is usable in other
# classes via mixins. A module can be "mixed in" to a class by
# using the `include` method invocation. 

module Call
  def call(phone_number)
    puts "Dialing #{phone_number}..."
  end
end

class CellPhone
  include Call
end

iphone = CellPhone.new

# iphone.call('617 710 1631')

# ---------------------------------------

# class GoodDog
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
  
#   def name
#     @name
#   end

#   def name=(name)
#     @name = name
#   end

#   def speak
#     "#{@name} says arf!"
#   end
# end

# milo = GoodDog.new("Milo")
# puts milo.speak
# puts milo.name
# milo.name = "Milardo"
# puts milo.name

class GoodDog
  attr_reader :name
  attr_accessor :height, :weight, :playful

  def initialize(name)
    @name = name
  end
  
  def speak
    "#{name} says arf!"
  end

  def change_info(h, w, pl)
    self.height = h
    self.weight = w
    self.playful = pl
  end

  def info
    puts "#{self.name} weighs #{self.weight} and is #{self.height} tall"
  end
end

# Instantiate a GoodDog object called `milo`
milo = GoodDog.new("Milo")

# Set it's state
milo.height = "25 inches"
milo.weight = "45 lbs"

# GoodDog class state attributes
puts milo.name
puts milo.height
puts milo.weight

# GoodDog class behavior methods
puts milo.speak

# Set all attributes at once
milo.change_info("26 inches", "43 lbs", true)
milo.info