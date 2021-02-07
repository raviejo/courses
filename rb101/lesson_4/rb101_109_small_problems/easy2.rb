## 1. How old is Teddy?
# Problem
# Build a program that randomly generates and prints Teddy's age. 
# To get the age, you should generate a random number between 20 and 200.
def teddys_age()
  puts "Teddy is #{rand(20..200)} years old"
end

teddys_age

# Modify this program to ask for a name, and then print the age for 
# that person. For an extra challenge, use "Teddy" as the name if no name is entered.

def teddys_age(name = "Teddy")
  puts "#{name} is #{rand(20..200)} years old"
end

teddys_age

## 2. How big is the room?
# Problem:
# Build a program that asks a user for the length and width of a room in meters and 
# then displays the area of the room in both square meters and square feet.
# Note: 1 square meter == 10.7639 square feet
# Example:
# => Enter the length of the room in meters:
# 10
# => Enter the width of the room in meters:
# 7
# => The area of the room is 70.0 square meters (753.47 square feet).

def how_big()
  puts "Enter the length of the room in meters:"
  length = gets.chomp.to_i
  puts "Enter the width of the room in meters:"
  width = gets.chomp.to_i
  area_sqr_meters = length * width
  area_sqr_feet = area_sqr_meters * 10.7639
  puts "The area of the room is #{area_sqr_meters} square meters (#{area_sqr_feet.round(2)} square feet)."
end

how_big

# Modify this program to ask for the input measurements in feet, 
# and display the results in square feet, square inches, and 
# square centimeters.

SQFEET_TO_SQINCH = 12
SQFEET_TO_SQCENT = 30.48

def how_big()
  puts "Enter the length of the room in feet:"
  length = gets.chomp.to_f
  puts "Enter the width of the room in feet:"
  width = gets.chomp.to_f
  area_sqr_feet = (length * width).round(2)
  area_sqr_inch = (area_sqr_feet * SQFEET_TO_SQINCH).round(2)
  area_sqr_centimeter = (area_sqr_feet * SQFEET_TO_SQCENT).round(2)
  puts "The area of the room is #{area_sqr_feet} square feet (#{area_sqr_inch} square inches and #{area_sqr_centimeter} square centimeters)."
end

how_big

## 3. Tip Calculator
# Problem:
# Create a simple tip calculator. The program should prompt for a bill amount and 
# a tip rate. The program must compute the tip and then display both the tip and 
# the total amount of the bill.

# Example:
# => What is the bill?
# 200
# => What is the tip percentage?
# 15
# The tip is $30.0
# The total is $230.0

def tip_calculator()
  puts "What is the bill?"
  bill = gets.chomp.to_f
  puts "What is the tip percentage?"
  tip_percent = gets.chomp.to_f / 100
  tip = bill * tip_percent  
  total = bill + tip
  puts "The tip is #{tip}"
  puts "The total is #{total}"
end

# Our solution prints the results as $30.0 and $230.0 instead of the more usual 
# $30.00 and $230.00. Modify your solution so it always prints the results 
# with 2 decimal places.
# Hint: You will likely need Kernel#format for this.
def tip_calculator()
  puts "What is the bill?"
  bill = gets.chomp.to_f
  puts "What is the tip percentage?"
  tip_percent = gets.chomp.to_f / 100
  tip = bill * tip_percent 
  total = (bill + tip).ceil(2)
  total_format = format("%1.2f", total)
  puts "The tip is #{tip}"
  puts "The total is #{total_format}"
end

## 4. When will I retire?
# Problem:
# Build a program that displays when the user will retire and how many years 
# she has to work till retirement.
# Example:
# => What is your age?
# 30
# => At what age would you like to retire?
# 70
# It's 2016. You will retire in 2056.
# You have only 40 years of work to go!

def when_retire()
  puts "What is your age?"
  age = gets.chomp.to_i
  puts "At what age would you like to retire?"
  retirement_age = gets.chomp.to_i
  years_to_retirement = retirement_age - age
  current_year = Date.today.year
  puts "It's #{current_year}. You will retire in #{current_year + years_to_retirement}. You have only #{years_to_retirement} years to go!"
end

## 5. Greet a user
# Problem:
# Write a program that will ask for user's name. The program will then greet the user. 
# If the user writes "name!" then the computer yells back to the user.
# Example:
# => What is your name?
# Bob
# => Hello Bob.
# => What is your name?
# Bob!
# HELLO BOB. WHY ARE WE SCREAMING?

def hello_bob()
  puts "What is your name?"
  name = gets.chomp
  greeting = "Hi #{name}."
  yell = "HELLO #{name.chop}. WHY ARE WE SCREAMING?"
  name =~ /!/ ? (puts yell) : (puts greeting)
end

hello_bob

## 6. Odd Numbers
# Problem:
# Print all odd numbers from 1 to 99, inclusive, to the console, with each
# number on a separate line.

puts (1..99).to_a.select(&:odd?)

## 7. Even Numbers
# Print all even numbers from 1 to 99, inclusive, to the console, with each 
# number on a separate line.

puts (1..99).to_a.select(&:even?)

## 8. Sum or Product of consecutive integers 
# Write a program that asks the user to enter an integer greater than 0,
# then asks if the user wants to determine the sum or product of all 
# numbers between 1 and the entered integer.


# >> Please enter an integer greater than 0:
# 5
# >> Enter 's' to compute the sum, 'p' to compute the product.
# s
# The sum of the integers between 1 and 5 is 15.


# >> Please enter an integer greater than 0:
# 6
# >> Enter 's' to compute the sum, 'p' to compute the product.
# p
# The product of the integers between 1 and 6 is 720.

def consecutive()
  puts "Please enter an interger greater than 0"
  num = gets.chomp.to_i
  range = (1..num).to_a
  puts "Enter 's' to compute the sum, 'p' to compute the product."
  s_or_p = gets.chomp
  operation = s_or_p.match?('s') ? 'sum' : 'product' 
  operator = s_or_p.match?('s') ? :+ : :*
  result = range.reduce(&operator)
  puts "The #{operation} of the integers between 1 and #{num} is #{result}"
end

consecutive

## 9. String Assignment
# Problem:
# What does the following code print out?
name = 'Bob'
save_name = name
name.upcase!
puts name, save_name

# Answer:
"BOB"
"BOB"

# 10. Mutation
# Problem:
# What will the following code print, and why? 
# Don't run the code until you have tried to answer.

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2

# Answer
["Moe", "Larry", "CURLY", "SHEMP", "Harpo", "CHICO", "Groucho", "Zeppo"]
# The `shovel` or `concatenation` operator passes the referenced object
# to array2, not a copy. When we change the value with `upcase!` the
# referenced object is altered.



