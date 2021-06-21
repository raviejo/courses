# 1. Banner Class
# class Banner
#   def initialize(message)
#     @message = message
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+-" + "-" * @message.size + "-+"
#   end

#   def empty_line
#     "| " + " " * @message.size + " |"
#   end

#   def message_line
#     "| #{@message} |"
#   end
# end

# Complete this class so that the test cases shown below work as intended.
# You are free to add any methods or instance variables you need.
# However, do not make the implementation details public.

# You may assume that the input will always fit in your terminal window.

# Test Cases
# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

# banner = Banner.new('')
# puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

## Further Exploration
# class Banner
#   def initialize(message, width=0)
#     width = message.size if width.zero?
#     @message = message.slice(0, width)
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+-" + "-" * @message.size + "-+"
#   end

#   def empty_line
#     "| " + " " * @message.size + " |"
#   end

#   def message_line
#     "| #{@message} |"
#   end
# end

# banner = Banner.new("To boldly go where no one has been before", 4)
# puts banner

# banner = Banner.new("To boldly go where no one has been before")
# puts banner

# 2. What's the output?
# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     "My name is #{@name.upcase}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # => "Fluffy"
# puts fluffy # => "My name is FLUFFY"
# puts fluffy.name # => "FLUFFY"
# puts name # => "FLUFFY"

# Further Exploration:

# name = 42
# fluffy = Pet.new(name)
# name += 1
# puts fluffy.name # => "42"
# puts fluffy # => "My name is 42"
# puts fluffy.name # => "42"
# puts name # => 43

# When the constructor is called, `@name` is initialized to the String `"42"`. Keep in mind that the `to_s` method invocation within the
# constructor will return a new String object. If we take that at face value then the return values for the `puts` method calls on lines
# `4-6` make perfect sense.

# Another less important point is that the `name` local variable outside the class definition is being reassinged on line `3`.

# If inspected carafully, the `name` local variable and `@name` instance variable within the class definition never point to the same object.

# 3. Fix the Program - Books (Part 1)
# Complete this program so that it produces the expected output:
# class Book
#   attr_reader :author, :title
  
#   def initialize(author, title)
#     @author = author
#     @title = title
#   end

#   def to_s
#     %("#{title}", by #{author})
#   end
# end

# book = Book.new("Neil Stephenson", "Snow Crash")
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# Further Exploration
# 1. Banner Class
# class Banner
#   def initialize(message)
#     @message = message
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+-" + "-" * @message.size + "-+"
#   end

#   def empty_line
#     "| " + " " * @message.size + " |"
#   end

#   def message_line
#     "| #{@message} |"
#   end
# end

# Complete this class so that the test cases shown below work as intended.
# You are free to add any methods or instance variables you need.
# However, do not make the implementation details public.

# You may assume that the input will always fit in your terminal window.

# Test Cases
# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

# banner = Banner.new('')
# puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

## Further Exploration
# class Banner
#   def initialize(message, width=0)
#     width = message.size if width.zero?
#     @message = message.slice(0, width)
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+-" + "-" * @message.size + "-+"
#   end

#   def empty_line
#     "| " + " " * @message.size + " |"
#   end

#   def message_line
#     "| #{@message} |"
#   end
# end

# banner = Banner.new("To boldly go where no one has been before", 4)
# puts banner

# banner = Banner.new("To boldly go where no one has been before")
# puts banner

# 2. What's the output?
# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     "My name is #{@name.upcase}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # => "Fluffy"
# puts fluffy # => "My name is FLUFFY"
# puts fluffy.name # => "FLUFFY"
# puts name # => "FLUFFY"

# Further Exploration:

# name = 42
# fluffy = Pet.new(name)
# name += 1
# puts fluffy.name # => "42"
# puts fluffy # => "My name is 42"
# puts fluffy.name # => "42"
# puts name # => 43

# When the constructor is called, `@name` is initialized to the String `"42"`. Keep in mind that the `to_s` method invocation within the
# constructor will return a new String object. If we take that at face value then the return values for the `puts` method calls on lines
# `4-6` make perfect sense.

# Another less important point is that the `name` local variable outside the class definition is being reassinged on line `3`.

# If inspected carafully, the `name` local variable and `@name` instance variable within the class definition never point to the same object.

# 3. Fix the Program - Books (Part 1)
# Complete this program so that it produces the expected output:
# class Book
#   attr_reader :author, :title
  
#   def initialize(author, title)
#     @author = author
#     @title = title
#   end

#   def to_s
#     %("#{title}", by #{author})
#   end
# end

# book = Book.new("Neil Stephenson", "Snow Crash")
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# Further Exploration
# What are the differences between attr_reader, attr_writer, and attr_accessor? Why did we use attr_reader instead of one of the other two?
# The `attr` methods are essentially shorthand for creating getter and setter methods.
# `attr_reader` creates a *getter* method
# `attr_writer` creates a *setter* method
# `attr_accessor` creates both a *getter* and a *setter*.

# In the case of this example, we only needed to get the value of the `@author` and `@title` instance variables, so the 
# `attr_writer` method wouldn't allow us to get anything, only set or override the instance variables. The `attr_accessor`
# method would allow us to get the `@author` and `@title` instance variables, but also override them. Assuming that these
# books are published, it would not be okay to change their title or author.  

# Would it be okay to use one of the others? Why or why not?
# Instead of attr_reader, suppose you had added the following methods to this class:
# def title
#   @title
# end

# def author
#   @author
# end

# In this case by explicitly writing the getter methods we add a lot of unnecessary code to our class and behave in the same way
# as using the `attr_reader` method. 
# The benefit of explicitly writing *getters* or *setters* is that we can manipulate their implementation with more detail than by using any of
# the `attr` methods. For example, say that for security we didn't want our author getter to return the String object that we initialized it to.
# Maybe we don't want any client code mutating it with an `upcase!` or `delete`.

# We could instead return a copy of `@author` like so:
# ```ruby
# # rest of code omitted
# def author
#   @author.dup
# end
# # rest of code omitted
# ```

# Even if we attempted to use malicious or destructive code such as:
# ```ruby
# book.author.each_char { |char| book.author.delete(char) }
# ```

# The value of the String object that `@author` is pointing to would remain unchanged.

# Would this change the behavior of the class in any way? If so, how?
# If not, why not? Can you think of any advantages of this code?

# 4. Fit the Program - Books (Part 2)
# Complete this program so that it produces the expected output:
# class Book
#   attr_accessor :title, :author
#   def to_s
#     %("#{title}", by #{author})
#   end
# end

# book = Book.new
# book.author = "Neil Stephenson"
# book.title = "Snow Crash"
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)

# 5. Fix the Program - Persons
# Complete this program so that it produces the expected output:
# class Person
#   attr_writer :first_name, :last_name
  
#   def initialize(first_name, last_name)
#     @first_name = first_name
#     @last_name = last_name
#   end

#   def to_s
#     "#{@first_name.capitalize} #{@last_name.capitalize}"
#   end
# end

# person = Person.new('john', 'doe')
# puts person

# person.first_name = 'jane'
# person.last_name = 'smith'
# puts person

# John Doe
# Jane Smith

# 6. Fix the Program - Flight Data
# Consider the following class definition:

# class Flight
#   attr_accessor :database_handle

#   def initialize(flight_number)
#     @database_handle = Database.init
#     @flight_number = flight_number
#   end
# end

# There is nothing technically incorrect about this class, but the definition may lead to problems in the future.
# How can this class be fixed to be resistant to future problems?

# 7. Buggy Code - Car Mileage
# Fix the following code so it works properly:
# class Car
#   attr_accessor :mileage

#   def initialize
#     @mileage = 0
#   end

#   def increment_mileage(miles)
#     total = mileage + miles
#     self.mileage = total
#   end

#   def print_mileage
#     puts mileage
#   end
# end

# car = Car.new
# car.mileage = 5000
# car.increment_mileage(678)
# car.print_mileage  # should print 5678

# 8. Rectangles and Squares
# Given the following class:
# class Rectangle
#   def initialize(height, width)
#     @height = height
#     @width = width
#   end

#   def area
#     @height * @width
#   end
# end

# class Square < Rectangle
#   def initialize(hw)
#     super(hw, hw)
#   end
# end

# Write a class called Square that inherits from Rectangle, and is used like this:
# square = Square.new(5)
# puts "area of square = #{square.area}"

# 9. Complete the Program - Cats!
# Consider the following program.

# class Pet
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# end

# class Cat < Pet
#   def to_s
#     "My cat #{@name} is #{@age} years old and has #{@colors} fur"
#   end
# end

# class Cat < Pet
#   def initialize(name, age, colors)
#     super(name, age)
#     @colors = colors
#   end
  
#   def to_s
#     "My cat #{@name} is #{@age} years old and has #{@colors} fur"
#   end
# end

# pudding = Cat.new('Pudding', 7, 'black and white')
# butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
# puts pudding, butterscotch

# Update this code so that when you run it, you see the following output:
# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

# 10. Refactoring Vehicles
# Consider the following classes:

# class Vehicle
#   attr_reader :make, :model, :wheels

#   def initialize(make, model)
#     @make = make
#     @model = model
#   end
  
#   def to_s
#     "#{make} #{model}"
#   end
# end

# class Car < Vehicle
#   def initialize(make, model)
#     super(make, model)
#     @wheels = 4
#   end
# end

# class Motorcycle < Vehicle
#   def initialize(make, model)
#     super(make, model)
#     @wheels = 4
#   end
# end

# class Truck < Vehicle
#   attr_reader :payload

#   def initialize(make, model, payload)
#     super(make, model)
#     @payload = payload
#     @wheels = 6
#   end
# end

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    4
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
  
  def wheels
    6
  end
end

# Refactor these classes so they all use a common superclass, and inherit behavior as needed.
puts " ", "------------"
car = Car.new("Hyundai", "Elantra")
puts car.wheels
puts car

puts " ", "------------"
motorcycle = Motorcycle.new("Kawasaki", "Z900RS")
puts motorcycle.wheels
puts motorcycle

puts " ", "------------"
truck = Truck.new("Toyota", "Tundra", 1730)
puts truck.payload
puts truck.wheels
puts truck