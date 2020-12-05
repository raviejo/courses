arr = [3, 5, 7, 9, 16]
new_array = arr.map { |n| n ** 2 }
p arr
p new_array
p arr

# Optional Arguments

s = 'abc def ghi,jkl mno pqr,stu vwx yz'
puts s.split.inspect
puts s.split(',').inspect
puts s.split(',', 2).inspect

# Loops
iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1
  break if iterations > 5
end

# loop do
#   puts 'Should I stop looping?'
#   answer = gets.chomp
#   break if answer.downcase == "yes"
# end

say_hello = true

counter = 0

while say_hello
  puts 'Hello!'
  counter += 1
  say_hello = false if counter == 5
end

numbers = []

while numbers.length < 5
  numbers << rand(100)
end

puts numbers

count = 10

until count == 0
  count -= 1
  puts 10 - count
end

numbers = [7, 9, 13, 25, 18]

until numbers.empty?
  puts numbers.first
  numbers.delete(numbers.first)
end

for i in 1..100
  puts i if i.odd?
end


friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends
  puts "Hello, #{friend}"
end

count = 1 

loop do
  puts "#{count} is #{if count.even? then 'even' else 'odd' end}!"
  count += 1
  break if count > 5
end

loop do
  number = rand(100)
  puts number
  break if number.between?(0, 10)
end

process_the_loop = [true, false].sample

if process_the_loop
  puts "The loop was processed!"
else
  puts "The loop wasn't processed!"
end

# loop do
#   puts 'What does 2 + 2 equal?'
#   answer = gets.chomp.to_i
#   if answer == 4
#     puts "that's correct!"
#     break
#   else
#     puts "try again!"
#   end
# end

numbers = []

# loop do
#   puts 'Enter any number:'
#   input = gets.chomp.to_i
#   numbers.push(input)
#   break if numbers.length == 5
# end
# puts numbers

names = ['Sally', 'Joe', 'Lisa', 'Henry']

loop do
  puts names.shift
  break if names.empty?
end

5.times do |index|
  puts index
  break if index == 2
end

number = 0
puts "-----------"
until number == 10
  number += 1
  next if number.odd?
  puts number
end


number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)
  next if number_a > 5 || number_b > 5
  puts "5 was reached!"
  break
end

def greeting
  puts 'Hello!'
end

number_of_greetings = 2

while number_of_greetings > 0
  greeting
  number_of_greetings -= 1
end

# puts "Type something please"
# input = gets.chomp
# puts "This is what you typed: #{input}"

# puts "What is your age?"
# age = gets.chomp
# puts "You are #{age.to_i * 12} months old"

# choice = nil
# loop do
#   puts "Do you want me to print something (y/n)?"
#   choice = gets.chomp.downcase
#   break if %w(y n).include?(choice)
#   puts "Invalid entry, please try again with y or n"
# end
# puts 'something' if choice == 'y'

# loop do
#   puts "How many output lines do you want? Enter a number >= 3:"
#   input = gets.chomp.to_i
#   if input >= 3
#     input.times {puts "LaunchSchool is awesome!"}
#     break
#   else
#     puts "That's not enough lines!"
#   end
# end

# USERNAME = "ricky"
# PASSWORD = "test"
# loop do 
#   puts "What is your username?"
#   username = gets.chomp.downcase
#   puts "What is your password"
#   password = gets.chomp.downcase
#   break if username == USERNAME && password == PASSWORD
#   puts "Wrong username or password, please try again"
# end

# puts "Welcome #{USERNAME}!"

# def valid_number?(number_string)
#   number_string.to_i.to_s == number_string
# end

# numerator = nil
# denominator = nil
# loop do
#   puts ">> Please enter the numerator:"
#   numerator = gets.chomp
#   if valid_number?(numerator)
#     loop do 
#       puts ">> Please enter the denominator"
#       denominator = gets.chomp
#       break if valid_number?(denominator)
#       puts ">> Please enter a valid denominator"
#     end
#   else
#     puts ">> Please enter a valid numerator"
#   end
#   break
# end
# puts "#{numerator} / #{denominator} is #{numerator.to_i / denominator.to_i}"


# number_of_lines = nil
# loop do
#   puts '>> How many output lines do you want? Enter a number >= 3 (Q to quit):'
#   input = gets.chomp
#   if input.to_i && input.to_i >= 3
#     lines = input.to_i
#     lines.times {puts 'Launch School is the best!'}
#     next
#   end
#   break if input.downcase == 'q'
#   puts ">> That's not enough lines."
# end

# def valid_number?(number_string)
#   number_string.to_i.to_s == number_string && number_string.to_i != 0
# end

# loop do
#   puts ">> Please enter a positive or negative integer:"
#   number_a = gets.chomp
#   puts ">> Please enter a positive or negative integer:"
#   number_b = gets.chomp
#   valid_entry = valid_number?(number_a) && valid_number?(number_b)
#   pos_and_neg = number_a.to_i * number_b.to_i < 0 
#   if !valid_entry
#     puts "Invalid input. Only non-zero integers are allowed."
#     next
#   elsif valid_entry && pos_and_neg 
#     puts "#{number_a} + #{number_b} = #{number_a.to_i + number_b.to_i}"
#     break
#   end
#   puts ">> Sorry. One integer must be positive, one must be negative."
#   puts ">> Please start over."
# end

def print_me
  "I'm printing the return value!"
end
puts print_me

def hello
  "Hello"
end

def world
  "World"
end

def greet
  "#{hello} #{world}"
end

puts greet

def car(make, model)
  puts "#{make.capitalize} #{model.capitalize}"
end

car('Toyota', 'Corolla')

daylight = [true, false].sample

def time_of_day(daylight)
  if daylight
    puts "It's daytime!"
  else 
    puts "It's nighttime"
  end
end

time_of_day(daylight)

def dog(name)
  return name
end

def cat(name)
  return name
end

puts "The dog's name is #{dog('Spot')}."
puts "The cat's name is #{cat('Ginger')}."

def assign_name(name="Bob")
  name
end

puts assign_name('Kevin') == 'Kevin'
puts assign_name == 'Bob'

def add(a, b)
  a + b
end

def multiply(a, b)
  a * b
end

puts add(2, 2) == 4
puts add(5, 4) == 9
puts multiply(add(2, 2), add(5, 4)) == 36

def name(names)
  names.sample
end

def activity(activities)
  activities.sample
end

def sentence(name, activity)
  "#{name.capitalize} went #{activity} today!"
end

names = ['Dave', 'Sally', 'George', 'Jessica']
activities = ['walking', 'running', 'cycling']

puts sentence(name(names), activity(activities))

sun = ['visible', 'hidden'].sample
puts "The sun is so bright" if sun.include?('visible')
puts "The clouds are blocking the sun" unless sun.include?('visible')

boolean = [true, false].sample
boolean ? puts("I'm true") : puts("I'm false")

stoplight = ['green', 'yellow', 'red'].sample
# Write a case statement that prints "Go!" if stoplight equals 'green', "Slow down!" 
# if stoplight equals 'yellow', and "Stop!" if stoplight equals 'red'.

puts"Go!" if stoplight.include?("green")
puts "Slow Down!" if stoplight.include?("yellow")
puts "Stop!" if stoplight.include?("red")

status = ['awake', 'tired'].sample
what = if status.include?('awake') then 'Be productive!' else 'Go to sleep' end
puts what

number = rand(10)

if number == 5
  puts '5 is a cool number!'
else
  puts 'Other numbers are cool too!'
end


stoplight = ['green', 'yellow', 'red'].sample

string_var = String.new

# Modify the following code so that double-quotes are used instead of single-quotes.

puts "It's now 12 o'clock."
# Expected output:
# Copy Code
# It's now 12 o'clock.

name = 'Roger'
puts name.casecmp?('RoGer')
puts name.casecmp?('DAVE')

name = 'Elizabeth'

puts "Hello, #{name}!"

first_name = 'John'
last_name = 'Doe'
full_name = "#{first_name} #{last_name}"
puts full_name
full_name = first_name + ' ' + last_name
puts full_name


greeting = 'Hello!'
greeting.replace('Goodbye!')
puts greeting


alphabet = 'abcdefghijklmnopqrstuvwxyz'
puts alphabet.split(//)

words = 'car human elephant airplane'
words.split.each {|word| puts word << "s" }

colors = 'blue pink yellow orange'
puts colors.include?('yellow')
puts colors.include?('purple')

pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2,3]
puts "I have a pet #{my_pets.shift} and a pet #{my_pets.shift}"


pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]
my_pets.pop
my_pets.append(pets[1])
puts "I have a pet #{my_pets.shift} and a pet #{my_pets.shift}"

colors = ['red', 'yellow', 'purple', 'green']
colors.each { |color| puts "I'm the color #{color}!"}


numbers = [1, 2, 3, 4, 5]
doubled_numbers = numbers.map { |num| num * 2 }
p doubled_numbers

numbers = [5, 9, 21, 26, 39]
divisible_by_three = numbers.select { |num| num if num % 3 == 0 }
p divisible_by_three

car = {
  :type => 'sedan',
  :color => 'blue',
  :mileage => 80_000
}

car[:year] = 2003

puts car

car.delete(:mileage)

puts car

puts car[:color]

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

numbers.each { |k, v| puts "A #{k} number is #{v}." }

half_numbers = numbers.map { |k, v| v / 2 }
p half_numbers

low_numbers = numbers.select { |k, v| v < 25 }
p low_numbers


numbers = {
  high:   100,
  medium: 50,
  low:    10
}

low_numbers = numbers.select! do |key, value|
                 value < 25
               end

p low_numbers
p numbers

nested_hash = {
  car: {type: 'sedan', color: 'blue', year: 2003},
  truck: {type: 'pickup', color: 'red', year: 1998}
}

car = [[:type, 'sedan'], [:color, 'blue'], [:year, 2003]]

def predict_weather
  sunshine = [true, false].sample

  if sunshine
    puts "Today's weather will be sunny!"
  else
    puts "Today's weather will be cloudy!"
  end
end

def multiply_by_five(n)
  n * 5
end

# puts "Hello! Which number would you like to multiply by 5?"
# number = gets.chomp.to_i

# puts "The result is #{multiply_by_five(number)}!"


pets = { cat: 'fluffy', dog: ['sparky', 'fido'], fish: 'oscar' }

pets[:dog].append('bowser')
p pets

numbers = [5, 2, 9, 6, 3, 1, 8]

even_numbers = numbers.select do |n|
  n.even?
end

p even_numbers # expected output: [2, 6, 8]


def get_quote(person)
  if person == 'Yoda'
    'Do. Or do not. There is no try.'
  elsif person == 'Confucius'
    'I hear and I forget. I see and I remember. I do and I understand.'
  elsif person == 'Einstein'
    'Do not worry about your difficulties in Mathematics. I can assure you mine are still greater.'
  end
end

puts 'Confucius says:'
puts '"' + get_quote('Confucius') + '"'

# Financially, you started the year with a clean slate.

balance = 0

# Here's what you earned and spent during the first three months.

january = {
  income: [ 1200, 75 ],
  expenses: [ 650, 140, 33.2, 100, 26.9, 78 ]
}

february = {
  income: [ 1200 ],
  expenses: [ 650, 140, 320, 46.7, 122.5 ]
}

march = {
  income: [ 1200, 10, 75 ],
  expenses: [ 650, 140, 350, 12, 59.9, 2.5 ]
}

# Let's see how much you've got now...

def calculate_balance(month)
  plus  = month[:income].sum
  minus = month[:expenses].sum

  plus - minus
end

[january, february, march].each do |month|
  balance += calculate_balance(month)
end

puts balance

colors = ['red', 'yellow', 'purple', 'green', 'dark blue', 'turquoise', 'silver', 'black']
things = ['pen', 'mouse pad', 'coffee mug', 'sofa', 'surf board', 'training mat', 'notebook']

colors.shuffle!
things.shuffle!

i = 0
loop do
  break if i > things.length - 1

  if i == 0
    puts 'I have a ' + colors[i] + ' ' + things[i] + '.'
  else
    puts 'And a ' + colors[i] + ' ' + things[i] + '.'
  end

  i += 1
end

def digit_product(str_num)
  digits = str_num.chars.map { |n| n.to_i }
  product = 1

  digits.each do |digit|
    product *= digit
  end

  product
end


p digit_product('12345')
# expected return value: 120
# actual return value: 0

# Each player starts with the same basic stats.

# player = { strength: 10, dexterity: 10, charisma: 10, stamina: 10 }

# # Then the player picks a character class and gets an upgrade accordingly.

# character_classes = {
#   warrior: { strength:  20 },
#   thief:   { dexterity: 20 },
#   scout:   { stamina:   20 },
#   mage:    { charisma:  20 }
# }

# puts 'Please type your class (warrior, thief, scout, mage):'
# input = gets.chomp.downcase.intern

# player.merge(character_classes[input])

# puts 'Your character stats:'
# puts player

CONSTANT = 1
var = 1

def add_const(num)
  num + CONSTANT
end

def add_var(num)
  num + var
end

puts add_const(7)
puts add_var(7)