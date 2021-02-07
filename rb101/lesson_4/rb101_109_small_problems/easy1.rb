## 1. Repeat Yourself

# Problem:
# Write a method that takes two arguments, a string and a positive integer, 
# and prints the string as many times as the integer indicates.
# Input: string and positive integer
# Output: print string

# Rules:
#     Explicit Requirements:
#      - the string must be printed as many times as the integer indicates
#     Implicit Requirements:
#      - output should be nil

## Examples:
# repeat('Hello, 3') # => 'Hello'
#                    # => 'Hello'
#                    # => 'Hello'

## Data Structure:
# string

## Algorithm:
# - Create a repeat method that takes in two parameters: str (String) and num (Integer)
#   - Initialize a num_times variable and set it to num
#   - While num_times is greater than zero
#     - Print str
#     - Reduce num_times by one
#   - End while loop
# - End method

## Code:
# This one returns nil
def repeat(str, num)
  num_times = num
  while num_times > 0
    puts str
    num_times -= 1
  end
end

repeat('Hello', 3)

# This one returns 3 not nil
def repeat(str,  num)
  num.times {puts str}
end

## 2. Odd
## Problem:
# Write a method that takes one integer argument, which may be positive, negative,
# or zero. This method returns true if the number's absolute value is odd.
# You may assume that the argument is a valid integer value.
# Keep in mind that you're not allowed to use #odd? or #even? in your solution.

# Input: Integer
# Output: Boolean
# Rules:
#     - Implicit Requirements:
#       - Return true if the absolute value of the given number is odd
#       - not allowed to use #odd? or #even?
#     - Explicit Requirements:
#       - Only take integers and no floats

## Examples:
# puts is_odd?(2)    # => false
# puts is_odd?(5)    # => true
# puts is_odd?(-17)  # => true
# puts is_odd?(-8)   # => false
# puts is_odd?(0)    # => false
# puts is_odd?(7)    # => true

## Data Structure:
# Boolean

## Algorithm:
# - Create a method called is_odd? that takes in one parameter called num (Integer)
#   - Convert num to it's absolute value
#     - Use Numeric#abs
#   - Check if num#abs modulo 2 > 0
# - End method

def is_odd?(num)
  (num.abs % 2) > 0
end

puts is_odd?(2) == false
puts is_odd?(5) ==  true
puts is_odd?(-17) == true
puts is_odd?(-8) == false
puts is_odd?(0) == false
puts is_odd?(7) == true

## 3. List of Digits
# Write a method that takes one argument, a positive integer, and returns a list of the digits in the number.

puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true

def digit_list(num)
  counter = num.to_s.size - 1
  result = []
  while counter >= 0
    result.unshift(num.to_s[counter].to_i)
    counter -= 1
  end
  result
end

# - Create a method digit_list that takes in a single parameter called num (Interger)
#   - Create variable `num_str_len` and set it to the length of the string of `num`
#   - Create an empty list called `result`
#   - Iterate from 0 to `num_str_len` and in each iteration
#     - Create variable `num_str` and set it to the character of current range number index
#     - Make num an interger
#     - Append `num` to `result`
#   - End iteration
#   - Output result
#  - End method


def digit_list(num)
  num_str = num.inspect
  result = []
  (0...num_str.length).each do |n|
    num = num_str[n].to_i
    result << num
  end
  result
end

## 4. How many?
# Write a method that counts the number of occurrences of each element in a given array.

def count_occurrences(cars)
  result = {}
  cars.each do |car|
    if result.key?(car)
      result[car] += 1
    else
      result[car] = 1
    end
  end
  result.each {|k, v| puts "#{k} => #{v}"}
end

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

count_occurrences(vehicles)

def count_occurrences(cars)
  result = {}
  cars.each do |car|
    car_downcase = car.downcase
    if result.key?(car_downcase)
      result[car_downcase] += 1
    else
      result[car_downcase] = 1
    end
  end
  result.each {|k, v| puts "#{k} => #{v}"}
end

## 5. Reverse It
# Write a method that takes one argument, a string, and returns a new string with the words in reverse order.
# Examples
# puts reverse_sentence('') == ''
# puts reverse_sentence('Hello World') == 'World Hello'
# puts reverse_sentence('Reverse these words') == 'words these Reverse'

def reverse_sentence(str)
  str.split.reverse.join(" ")
end

puts reverse_sentence('') == ''
puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'

## 6. Revertse It (Part 2)
# Write a method that takes one argument, a string containing one or more words, and returns the given string 
# with words that contain five or more characters reversed. Each string will consist of only letters and 
# spaces. Spaces should be included only when more than one word is present.

def reverse_words(str)
  str_array = str.split
  str_array.map {|word| word.reverse! if word.size >= 5}
  str_array.join(" ")
end

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS

## 7. Stringy Strings
# Write a method that takes one argument, a positive integer, and returns a string of alternating 1s and 0s, 
# always starting with 1. The length of the string should match the given integer.
# Examples
# puts stringy(6) == '101010'
# puts stringy(9) == '101010101'
# puts stringy(4) == '1010'
# puts stringy(7) == '1010101'

# - Create a method called stringy that takes in a `num` (Integer) parameter
#   - Create a `result` (String) variable and set it to ""
#   - Iterate `num` times and in each iteration:
#     - If `result` is "" or the last character of `result` is equal to "0"
#       - Append "1" to `result`
#     - Else append "0" to `result`
#   - End iteration
#   - Return `result`
# - End method

def stringy(num)
  result = ""
  num.times do
    if (result == "") || (result[-1] == "0")
      result << "1"
    else
      result << "0"
    end
  end
  result
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'

def stringy(num)
  result = ""
  num.times do |n|
    n.even? ? result << "1" : result << "0"
  end
  result
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'

# Modify stringy so it takes an additional optional argument that defaults to 1. If the method is called
# with this argument set to 0, the method should return a String of alternating 0s and 1s, but starting 
# with 0 instead of 1.

def stringy(size, start=1)
  numbers = []

  size.times do |index|
    number = index.even? ? 1 : 0
    numbers << number
  end
  start == 0 ? numbers.join.reverse! : numbers.join
end

puts stringy(6, 0) == '010101'
puts stringy(9) == '101010101'
puts stringy(4, 0) == '0101'
puts stringy(7) == '1010101'

## 8. Array Average
# Problem:
# Write a method that takes one argument, an array containing integers, and returns the average of all 
# numbers in the array. The array will never be empty and the numbers will always be positive integers. 
# Your result should also be an integer.
# Examples:

# - Create method `average` that takes in `nums` (Array of Integers)
#   - Set `result` to equal the addition of all Integers in `nums`
#   - Set `result` to equal the division of `result` by nums.size
#   - Return `result`
# - End method

def average(nums)
  nums.sum / nums.size
end

puts average([1, 6]) == 3 # integer division: (1 + 6) / 2 -> 3
puts average([1, 5, 87, 45, 8, 8]) == 25.0
puts average([9, 47, 23, 95, 16, 52]) == 40.0


# Enumerable#reduce
nums = [1, 2, 3, 4]
nums.reduce(&:+) # -> 10
nums.reduce(&:*) # -> 24

# Enumerable#inject
nums = [1, 2, 3, 4]
nums.inject(&:+) # -> 10
nums.inject(&:*) # -> 24

def average(nums)
  nums.sum.to_f / nums.size
end

puts average([1, 6]) == 3.5 # integer division: (1 + 6) / 2 -> 3
puts average([1, 5, 87, 45, 8, 8]) == 25.666666666666668

## 9. Sum of digits
# Problem:
# Write a method that takes one argument, a positive integer, and returns the sum of its digits.
# Examples:
# puts sum(23) == 5
# puts sum(496) == 19
# puts sum(123_456_789) == 45

def sum(num)
  num.to_s.chars.map(&:to_i).sum
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45

## 10. What's my bonus?
# Problem:
# Write a method that takes two arguments, a positive integer and a boolean, and calculates the 
# bonus for a given salary. If the boolean is true, the bonus should be half of the salary. 
# If the boolean is false, the bonus should be 0.
# Examples:
# puts calculate_bonus(2800, true) == 1400
# puts calculate_bonus(1000, false) == 0
# puts calculate_bonus(50000, true) == 25000

def calculate_bonus(salary, bool)
  bool ? (salary * 0.5) : 0
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000