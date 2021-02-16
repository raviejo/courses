## 1. Welcome Stranger
# Problem:
# Create a method that takes 2 arguments, an array and a hash. The array will contain 2 or more elements that,
# when combined with adjoining spaces, will produce a person's name. The hash will contain two keys, :title
# and :occupation, and the appropriate values. Your method should return a greeting that uses the person's
# full name, and mentions the person's title and occupation.
# Examples: 
# greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })
# => Hello, John Q Doe! Nice to have a Master Plumber around.

def greetings(name, title_occupation)
  "=> Hello, #{name.join(" ")}! Nice to have a #{title_occupation.values.join(" ")} around"
end

greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })

## 2. Double Doubles
# Problem:
# A double number is a number with an even number of digits whose left-side digits are exactly the same as its
# right-side digits. For example, 44, 3333, 103103, 7676 are all double numbers. 444, 334433, and 107 are not.
# Write a method that returns 2 times the number provided as an argument, unless the argument is a double number;
# double numbers should be returned as-is.
# Examples:
twice(37) == 74
twice(44) == 44
twice(334433) == 668866
twice(444) == 888
twice(107) == 214
twice(103103) == 103103
twice(3333) == 3333
twice(7676) == 7676
twice(123_456_789_123_456_789) == 123_456_789_123_456_789
twice(5) == 10

# split into left_side and right_side variables
def twice(num)
  half = num.to_s.size / 2
  left_side = num.to_s[0, half]
  right_side = num.to_s[-half, half]
  return num * 2 if half < 1 || num.to_s.size.odd?
  left_side == right_side ? num : num * 2
end

## 3. Always Return Negative
# Problem:
# Write a method that takes a number as an argument. If the argument is a positive number, return the negative of
# that number. If the number is 0 or negative, return the original number.
# Examples:
# negative(5) == -5
# negative(-3) == -3
# negative(0) == 0      # There's no such thing as -0 in ruby

def negative(num)
  num.negative? ? num : num * -1
end

negative(5) == -5
negative(-3) == -3
negative(0) == 0 

# Another solution
def negative(number)
  number > 0 ? -number : number
end

# And yet one more
def negative(number)
  -number.abs
end

## 4. Counting Up
# Problem:
# Write a method that takes an integer argument, and returns an Array of all integers, in sequence, between 1
# and theargument.
# You may assume that the argument will always be a valid integer that is greater than 0.
# Examples:
# sequence(5) == [1, 2, 3, 4, 5]
# sequence(3) == [1, 2, 3]
# sequence(1) == [1]

def sequence(num)
  result = []
  0.upto(num - 1) do |n|
    result.prepend(num)
    num -= 1
  end
  result
end

# Another solution
def sequence(num)
  (1..num).to_a
end

# Further exploration
# Food for thought: what do you think sequence should return if the argument is not greater than 0. For instance,
# what should you do if the argument is -1? Can you alter your method to handle this case?

def sequence(num)
  num.negative? ? (num..0).to_a : (1..num).to_a
end

## 5. Uppercase Check
# Problem:
# Write a method that takes a string argument, and returns true if all of the alphabetic characters inside the string
# are uppercase, false otherwise. Characters that are not alphabetic should be ignored.
# Examples:
# uppercase?('t') == false
# uppercase?('T') == true
# uppercase?('Four Score') == false
# uppercase?('FOUR SCORE') == true
# uppercase?('4SCORE!') == true
# uppercase?('') == true

def uppercase?(str)
  str.size == 0 ? !!str : str.chars.map {|char| char.match?(/[A-Z||[^A-Za-z]]/)}.reduce(:&)
end

def uppercase?(str)
  str == str.upcase
end

uppercase?('t') == false
uppercase?('T') == true
uppercase?('Four Score') == false
uppercase?('FOUR SCORE') == true
uppercase?('4SCORE!') == true
uppercase?('') == true

## 6. How long are you?
# Problem:
# Write a method that takes a string as an argument, and returns an Array that contains every word from the string,
# to which you have appended a space and the word length.
# You may assume that words in the string are separated by exactly one space, and that any substring of non-space
# characters is a word.
# Examples:
word_lengths("cow sheep chicken") == ["cow 3", "sheep 5", "chicken 7"]

word_lengths("baseball hot dogs and apple pie") ==
  ["baseball 8", "hot 3", "dogs 4", "and 3", "apple 5", "pie 3"]

word_lengths("It ain't easy, is it?") == ["It 2", "ain't 5", "easy, 5", "is 2", "it? 3"]

word_lengths("Supercalifragilisticexpialidocious") ==
  ["Supercalifragilisticexpialidocious 34"]

word_lengths("") == []

def word_lengths(str)
  str.split.map { |word| "#{word} #{word.size}"  }
end 

## 7. Name Swapping
# Problem:
# Write a method that takes a first name, a space, and a last name passed as a single String argument, and returns
# a string that contains the last name, a comma, a space, and the first name.
# Examples:
# swap_name('Joe Roberts') == 'Roberts, Joe'
def swap_name(name)
  first, last = name.split
  "#{last}, #{first}"
end

def swap_name(name)
  name.split.reverse.join(", ")
end

## 8. Sequence Count
# Problem: 
# Create a method that takes two integers as arguments. The first argument is a count, and the second is the first
# number of a sequence that your method will create. The method should return an Array that contains the same
# number of elements as the count argument, while the values of each element will be multiples of the starting
# number.
# You may assume that the count argument will always have a value of 0 or greater, while the starting number can be
# any integer value. If the count is 0, an empty list should be returned.
# Examples: 
sequence(5, 1) == [1, 2, 3, 4, 5]
sequence(4, -7) == [-7, -14, -21, -28]
sequence(3, 0) == [0, 0, 0]
sequence(0, 1000000) == []

def sequence(count, first)
  return [] if count.zero?
  result = [first]
  result << result.last + first until count == result.size
  result
end

def sequence(count, first)
  (1..count).map {|n| n * first}
end

## 9. Grade book
# Problem:
# Write a method that determines the mean (average) of the three scores passed to it, and returns the letter value
# associated with that grade.
# Numerical Score Letter	Grade
# 90 <= score <= 100	'A'
# 80 <= score < 90	'B'
# 70 <= score < 80	'C'
# 60 <= score < 70	'D'
# 0 <= score < 60	'F'
# Tested values are all between 0 and 100. There is no need to check for negative values or values greater than 100.
# Example:
get_grade(95, 90, 93) == "A"
get_grade(50, 50, 95) == "D"

def get_grade(grade1, grade2, grade3)
  mean = [grade1, grade2, grade3].sum / 3
  case
  when mean > 89 then "A" 
  when mean > 79 then "B"
  when mean > 69 then "C"
  when mean > 59 then "D"
  else "F"
  end
end

## 10. Grocery List
# Problem:
# Write a method which takes a grocery list (array) of fruits with quantities and converts it into an array of the correct
# number of each fruit.
# Example:
buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]

def buy_fruit(groceries)
  result = ""
  groceries.each {|fruit| result << ((fruit[0] + " ") * fruit[1])}
  result.split
end

# Another solution:
def buy_fruit(list)
  list.map { |fruit, quantity| [fruit] * quantity }.flatten
end

# Inverse
def buy_fruit(groceries)
  groceries.uniq.map {|fruit| [fruit, groceries.count(fruit)]}
end

