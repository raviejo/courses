class Bulldog
  def to_s
    "I'm a Bulldog! Woof woof!"
  end
  
  def jump
    "Bulldog just jumped!"
  end
end

class Cat
  def to_s
    "I'm a kitty cat! MEOW!"
  end
  
  def jump
    "Kitty cat just jumped!"
  end
end

class Person
  attr_accessor :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

bob.pets << Cat.new
bob.pets << Bulldog.new
bob.pets.each do |pet|
  puts pet.jump
end