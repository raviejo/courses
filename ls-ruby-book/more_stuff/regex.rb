# Regular Expressions
require "pry"

# Checking to see if "powerball" contains the letter "b"
puts "powerball has the letter \"b\"" if "powerball" =~ /b/
puts "------------"

puts "Boolean Regex Example"
puts "------------"
# boolean regex.rb
def has_a_b?(string)
  if string =~ /b/
    puts "#{string.capitalize} has \"b\"" 
  else
    puts "#{string.capitalize} doesn't contain \"b\""
  end
end 

has_a_b?("basketball")
has_a_b?("ricky")
has_a_b?("hockey")
has_a_b?("golf")
puts "---------"

puts "Match method example"
puts "------------"
puts "We have a match!" if "baseball".match(/b/)


puts "---------"

# Changing the variable to a different memory space
a = "hi" # saved to memory space 1
a = b # a and b are saved to memory space 1
a = "hello" # now a is saved to memory space 2

# Mutating the variable and keeping the same memory space
a = "hi" # saved to memory space 1
a = b # a and b are saved to memory space 1
a << ", there" # the value of memory space 1 has been changed to "hi, there"

# Variable and Block as parameters of method 
def take_block(number, &block)
  block.call(number)
end

# Passing the variable and block to the method
take_block(7) { |num| "this is the number seven: #{num}" }

# Passing a proc to a method
def take_proc(proc)
  [1, 2, 3, 4, 5].each do |number|
    proc.call number
  end
end

# Defining the proc
proc = Proc.new do |number|
  puts "This is a Proc printing the number: #{number}, from a method"
end

take_proc(proc)

# Division exception handling
def divide(number, divisor)
  begin
    number / divisor
  rescue ZeroDivisionError => e
    puts e.message.capitalize
  end
end

divide(4, 7)
divide(4, 0)
divide(17, 9)