## 1. Searching 101
# Problem:
# Write a program that solicits 6 numbers from the user, then prints 
# a message that describes whether or not the 6th number appears amongst 
# the first 5 numbers.

# - Create variable `numbers` (empty Array)
# - While the length of numbers is less than or equal to 6
#   - Print a message asking the user for the nth number
#     - If n is 1 add "st"
#     - If n is 2 add "nd"
#     - If n is 3 add "th"

# Example
# ==> Enter the 1st number:
# 25
# ==> Enter the 2nd number:
# 15
# ==> Enter the 3rd number:
# 20
# ==> Enter the 4th number:
# 17
# ==> Enter the 5th number:
# 23
# ==> Enter the last number:
# 17
# The number 17 appears in [25, 15, 20, 17, 23].


# ==> Enter the 1st number:
# 25
# ==> Enter the 2nd number:
# 15
# ==> Enter the 3rd number:
# 20
# ==> Enter the 4th number:
# 17
# ==> Enter the 5th number:
# 23
# ==> Enter the last number:
# 18
# The number 18 does not appear in [25, 15, 20, 17, 23].

ordinals = %w(1st 2nd 3rd 4th 5th last)
numbers = []
ordinals.each do |ordinal|
  puts "==> Enter the #{ordinal} number:"
  number = gets.chomp.to_i
  numbers << number
end
last = numbers.pop
appears = (numbers.include?(last)) ? "appears" : "does not appear"
puts "The number #{last} #{appears} in #{numbers}"

## 2. Arithmetic Integer
# Problem:
# Write a program that prompts the user for two positive integers, and then 
# prints the results of the following operations on those two numbers: 
# addition, subtraction, product, quotient, remainder, and power. 
# Do not worry about validating the input.

# Examples:
# ==> Enter the first number:
# 23
# ==> Enter the second number:
# 17
# ==> 23 + 17 = 40
# ==> 23 - 17 = 6
# ==> 23 * 17 = 391
# ==> 23 / 17 = 1
# ==> 23 % 17 = 6
# ==> 23 ** 17 = 141050039560662968926103

operators = %i(+ - * / % **)
puts "Enter the first number"
first = gets.chomp.to_i
puts "Enter the second number"
second = gets.chomp.to_i
numbers = [first, second]
for operator in operators
  puts "==> #{first} #{operator} #{second} = #{numbers.reduce(&operator)}"
end

## 3. Counting the Number of Characters
# Problem:
# Write a program that will ask a user for an input of a word or multiple words 
# and give back the number of characters. Spaces should not be counted as 
# a character.

# Examples:
# => Please write word or multiple words: 
# walk
# ==> There are 4 characters in "walk".

# ==> Please write word or multiple words:
# walk, don't run
# ==> There are 13 characters in "walk, don't run".


puts "Please write word or multiple words:"
words = gets.chomp
characters = words.split.reduce(&:+).size
puts "There are #{characters} characters in \"#{words}\""

# another solution

print 'Please write word or multiple words: '
input = gets.chomp
number_of_characters = input.delete(' ').size
puts "There are #{number_of_characters} characters in \"#{input}\"."

## 4. Multiplying two numbers
# Problem:
# Create a method that takes two arguments, multiplies them together, and returns the result
# Example:
# multiply(5, 3) == 15

def multiply(n1, n2)
  n1 * n2
end

## 5. Squaring an argument
# Problem:
# Using the multiply method from the "Multiplying Two Numbers" problem, write a method that computes
# the square of its argument (the square is the result of multiplying a number by itself).
# Examples:
# square(5) == 25
# square(-8) == 64

def square(n)
  multiply(n, n)
end

# What if we wanted to generalize this method to a "power to the n" type method: cubed, to the 4th power, 
# to the 5th, etc. How would we go about doing so while still using the multiply method?
def power_of_n(n, power)
  result = 0
  if power == 1
    return n
  else 
    result = multiply(n, power_of_n(n, power -1))
  end
  result
end

power_of_n(2, power_of_n(2, power_of_n(2, 4)))

def power_of_n(n, power)
  result = 1
  power.times {result = multiply(n, result)}
  result
end

## 6. Exclusive Or
# Problem:
# write a function named xor that takes two arguments, and returns true if exactly one of its arguments 
# is truthy, false otherwise. Note that we are looking for a boolean result instead of a truthy/falsy 
# value as returned by || and &&.

def xor?(bool1, bool2)
  (bool1 || bool2) && !(bool1 && bool2)
end

xor?(5.even?, 4.even?) == true
xor?(5.odd?, 4.odd?) == true
xor?(5.odd?, 4.even?) == false
xor?(5.even?, 4.odd?) == false

## 7. Odd Lists
# Problem:
# Write a method that returns an Array that contains every other element of an Array that is passed in as
# an argument. The values in the returned list should be those values that are in the 1st, 3rd, 5th, and
# so on elements of the argument Array.

oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
oddities(['abc', 'def']) == ['abc']
oddities([123]) == [123]
oddities([]) == []

def oddities(arr)
  counter = 0
  result = []
  while counter != arr.size
    if (counter.even?) || (counter == 0)
      result << arr[counter]
    end
    counter += 1
  end
  result
end

oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
oddities(['abc', 'def']) == ['abc']
oddities([123]) == [123]
oddities([]) == []

def oddities(arr)
  result = []
  arr.size.times {|n| result << arr[n] if n.even?}
  result
end

## 8. Palindromic Strings (Part 1)
# Problem:
# Write a method that returns true if the string passed as an argument is a palindrome, 
# false otherwise. A palindrome reads the same forward and backward. For this exercise, 
# case matters as does punctuation and spaces.

# Examples:
# palindrome?('madam') == true
# palindrome?('Madam') == false          # (case matters)
# palindrome?("madam i'm adam") == false # (all characters matter)
# palindrome?('356653') == true

def palindrome?(str)
  str == str.reverse
end

palindrome?('madam') == true
palindrome?('Madam') == false          # (case matters)
palindrome?("madam i'm adam") == false # (all characters matter)
palindrome?('356653') == true

## 9. Palindromic Strings (Part 2)
# Problem:
# Write another method that returns true if the string passed as an argument is a palindrome, 
# false otherwise. This time, however, your method should be case-insensitive, and it should 
# ignore all non-alphanumeric characters. If you wish, you may simplify things by calling the
# palindrome? method you wrote in the previous exercise.

# Alphanumeric
# A-Z, a-z, 0-9

def real_palindrome?(str)
  alphanumerics = ("A".."Z").to_a + ("a".."z").to_a + (0..9).to_a
  str.each_char {|char| str.delete!(char) unless alphanumerics.include?(char)}
  palindrome?(str.downcase)
end

# Removes all characters from `str`
# that fall between a-z, A-Z, and 0-9
str.delete("^a-zA-Z0-9")




## 10. Palindromic Numbers
# Write a method that returns true if its integer argument is palindromic, false otherwise. 
# A palindromic number reads the same forwards and backwards.

# Examples:
# palindromic_number?(34543) == true
# palindromic_number?(123210) == false
# palindromic_number?(22) == true
# palindromic_number?(5) == true

def palindromic_number?(num)
  palindrome?(num.to_s)
end

palindromic_number?(34543) == true
palindromic_number?(123210) == false
palindromic_number?(22) == true
palindromic_number?(5) == true