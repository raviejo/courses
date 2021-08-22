# 1. Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly
# when trying to set an instance variable within the class? Give an example.

# By calling the _setter_ method, we make sure that we are using any built in validations and protections for the instance variable.
# value of the instance variable it's setting.

# For example, say we have a `Teenager` class with an `age` attribute. We can assume by the name of the class that the `age` of a Teenager object should be limited to
# integers between 13 and 19 (inclusive). Say that we define our class as follows:

class InvalidAgeError < StandardError; end

class Teenager
  attr_reader :age

  def initialize(age)
    self.age = age
  end

  def age=(age)
    raise InvalidAgeError, "Invalid Age #{age} for teenager range 13-19" unless (13...19).cover?(age)
    @age = age
  end

  def to_s
    "I'm a #{age} year old teenager"
  end
end

# Notice that inside the constructor, we're using the `age=` setter method. This setter raises an exception if an age outside the 13..19 range is passed
# during object instantiation. This data validation error ensures that all Teenager objects have a valid age. For example:

fifteen = Teenager.new(15) # here we instantiate a 15 year old teenager
puts fifteen # => "I'm a 15 year old teenager"

twenty = Teenager.new(20) # => "Invalid Age 20 for teenager range 13-19 (InvalidAgeError)"
puts twenty

# Now let's assume that we change the constructor to reference the `@age` instance variable directly.

class Teenager
  # rest of code ommitted

  def initialize(age)
    @age = age
  end

  # rest of code ommitted
end

twenty = Teenager.new(20) # here we instantiate a 20 year old teenager
puts twenty # => "I'm a 20 year old teenager"

# This demonstrates that by setting the value of the instance variable directly, we're bypassing any data integrity validations provided by the setter.


# >>>>>> Topics of Interest <<<<<<< #

# What is a Class?
# A class is a template or a basic outline of an object. It defines the attributes and behaviors of the object, in other words what it should be made of
# and what it is capable of doing.

# What is an object?
# An object is an instance of a class. It is similar to other objects of the class in that they share the same behaviors, but different in that the states of the object,
# meaning it's attributes at a particular point in time, may be different.

# Use attr_* to create setter and getter methods

# In ruby we can use the attr_accessor method to automatically create getters and setters. It takes a symbol as an argument and uses it as the name for the getter and setter.
# attr_accessor
class Bird
  attr_accessor :name # creating both a getter and a setter

  def initialize(name)
    @name = name
  end
end

clayton = Bird.new("Clayton")
puts clayton.name # => "Clayton"
clayton.name = "Charlie"
puts clayton.name # => "Charlie"

class Bird
  attr_reader :name # create only a getter method

  def initialize(name)
    @name = name
  end
end

sam = Bird.new("Sam", "Toucan")
puts clayton.name # => "Clayton"
clayton.name = "Charlie"
puts clayton.name # => "Charlie"

class Person
  attr_reader :name

  def initialize(name, ssn)
    @name = name
    @ssn = ssn
  end

  def ssn
    get_ssn
  end

  private
  def get_ssn
    "XXX-XX-" + @ssn.split("-").last
  end
end