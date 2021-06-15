# 1. Create a class called MyCar. When you initialize a new instance or object of the class, allow the 
# user to define some instance variables that tell us the year, color, and model of the car.
# Create an instance variable that is set to 0 during instantiation of the object to track the current
# speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut
# the car off.

# class MyCar
  
#   def initialize(year, color, model)
#     @speed = 0
#     @year = year
#     @color = color
#     @model = model
#   end

#   def speed_up
#     @speed += 1
#   end

#   def break
#     @speed -= 1
#   end

#   def shut_off
#     @speed = 0
#   end

# end

# bmw = MyCar.new(2018, "Red", "3 Series")


# 2. Add an accessor method to your MyCar class to change and view the color of your car.
# Then add an accessor method that allows you to view, but not modify, the year of your car.
module Raceable
  def nos
    puts "You hit the nitrous oxide, rev it up baby!"
    @current_speed += 30
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end


class Vehicle
  @@vehicle_count = 0
  
  attr_accessor :color, :model, :current_speed
  attr_reader :year  

  def self.vehicle_count
    puts "This program has created #{@@vehicle_count} vehicles"
  end

  def initialize(year, color, model)
    @year = year
    self.color = color
    @model = model
    @current_speed = 0
    @@vehicle_count += 1
    @time = Time.now
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph"
  end

  def break(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph"
  end

  def current_speed
    puts "You are now going #{@current_speed} mph"
  end

  def shut_off
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your #{self.model} has been spray painted #{self.color}"
  end

  def age
    puts "Your #{self.model} is #{calculate_age} years old"
  end

  private
  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  include Raceable

  NUMBER_OF_DOORS = 4
  def to_s
    "This car is a #{self.color} #{self.year} #{@model}"
  end
end

class MyTruck < Vehicle
  include Towable
  
  NUMBER_OF_DOORS = 2
  def to_s
    "This truck is a #{self.color} #{self.year} #{@model}"
  end
end

bmw = MyCar.new(2018, "Red", "BMW 3 Series")
puts bmw
bmw.current_speed
5.times do
  bmw.speed_up(12)
  bmw.current_speed
end
bmw.nos
bmw.current_speed
bmw.break(40)
bmw.current_speed
bmw.shut_off
bmw.spray_paint("Magenta")

mercedes = MyTruck.new(2020, "Silver", "SL500 Truck SUV")
puts mercedes
mercedes.current_speed
8.times do
  mercedes.speed_up(7)
  mercedes.current_speed
end
mercedes.break(22)
mercedes.current_speed
mercedes.shut_off
mercedes.can_tow?(1000)
mercedes.spray_paint("Onyx")


puts "-----------------"
puts Vehicle.ancestors
puts "", "-----------------"
puts MyCar.ancestors
puts "", "-----------------"
puts MyTruck.ancestors

Vehicle::gas_mileage(13, 351)
Vehicle::vehicle_count

honda = MyCar.new(2000, "Red", "Honda Civic")
honda.age

# Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error.

class Student 
  attr_accessor :name
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected
  attr_reader :grade
end

joe = Student.new("Joseph", 98)
bob = Student.new("Robert", 95)

# Create a better_grade_than? method, that you can call like so...
puts "Well done!" if joe.better_grade_than?(bob)

puts joe.name

class Person
  def initialize(ssn)
    @ssn = ssn
  end

  def ssn
    "xxx-xx-" + @ssn.split("-").last
  end
end

ricky = Person.new("123-45-6789") # instantiating or creating a Person object

class MyCar

  def self.gas_mileage(gallons, miles)
    puts "You car consumes #{miles / gallons} mile per gallon"
  end

  def to_s
    puts "This is a MyCar class"
  end
end



class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black")      



class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors