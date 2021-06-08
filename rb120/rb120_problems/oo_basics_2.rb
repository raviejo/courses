# 1. Generic Greeting (Part 1)
# Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.
class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

# 2. Hello, Chloe!
# Using the following code, add an instance method named #rename that renames kitty when invoked.

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def rename(name)
    self.name = name
  end
end

kitty = Cat.new('Sophie')
kitty.name
kitty.rename('Chloe')
kitty.name
# Expected output:
# Sophie
# Chloe

# 3. Identify Yourself (Part 1)
# Using the following code, add a method named #identify that returns its calling object.

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify
# Expected output (yours may contain a different object id):

#<Cat:0x007ffcea0661b8 @name="Sophie">

# 4. Generic Greeting (Part 2)
# Using the following code, add two methods: ::generic_greeting and #personal_greeting.
# The first method should be a class method and print a greeting that's generic to the
# class. The second method should be an instance method and print a greeting that's
# custom to the object.

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def self.generic_greeting
    puts "Hello! I'm a cat"
  end
  
  def personal_greeting
    puts "Hello! My name is #{name}"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting

# Expected output:
# Hello! I'm a cat!
# Hello! My name is Sophie!

# 5. Counting Cats
# Using the following code, create a class named Cat that tracks the number of times a new
# Cat object is instantiated. The total number of Cat instances should be printed when
# ::total is invoked.
class Cat
  @@number_of_cats = 0
  
  def initialize
    @@number_of_cats += 1
  end
  
  def self.total
    puts @@number_of_cats
  end
end
kitty1 = Cat.new
kitty2 = Cat.new

Cat.total
# Expected Output
# 2

# 6. Colorful Cat
# Using the following code, create a class named Cat that prints a greeting when #greet
# is invoked. The greeting should include the name and color of the cat. Use a constant
# to define the color.

class Cat
  COLOR = "purple"
  
  attr_accessor :name
  
  def initialize(name)
    self.name = name
  end
  
  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR} cat"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# Expected Output
# Hello! My name is Sophie and I'm a purple cat!

# 7. Identify Yourself (Part 2)
# Update the following code so that it prints I'm Sophie! when it invokes puts kitty.
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    puts "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty

# Expected Output:
# I'm Sophie!

# 8. Public Secret
# Using the following code, create a class named Person with an instance variable named @secret.
# Use a setter method to add a value to @secret, then use a getter method to print @secret.

class Person
  attr_accessor :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret

# Expected Output:
# Shh.. this is a secret!

# 9. Private Secret
# Using the following code, add a method named share_secret that prints the value of @secret when invoked.
class Person
  attr_writer :secret
  
  def share_secret
    puts secret
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

# Expected output:
# Shh.. this is a secret!

# 10. Protected Secret
# Using the following code, add an instance method named compare_secret that compares the value of @secret
# from person1 with the value of @secret from person2.
class Person
  attr_writer :secret

  def compare_secret(other)
    secret == other.secret
  end
  
  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)

# Expected Output:
# false