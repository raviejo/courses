## 1. Short Long Short
# Problem:
# Write a method that takes two strings as arguments, determines the longest of the two strings,
# and then returns the result of concatenating the shorter string, the longer string, and the
# shorter string once again. You may assume that the strings are of different lengths.

# Examples:
# short_long_short('abc', 'defgh') == "abcdefghabc"
# short_long_short('abcde', 'fgh') == "fghabcdefgh"
# short_long_short('', 'xyz') == "xyz"

def short_long_short(str1, str2)
  (str1.size > str2.size) ? str2 + str1 + str2 : str1 + str2 + str1
end

short_long_short('abc', 'defgh') == "abcdefghabc"
short_long_short('abcde', 'fgh') == "fghabcdefgh"
short_long_short('', 'xyz') == "xyz"

## 2. What Century is That?
# Problem:
# Write a method that takes a year as input and returns the century. The return value should be a string that
# begins with the century number, and ends with st, nd, rd, or th as appropriate for that number.
# New centuries begin in years that end with 01. So, the years 1901-2000 comprise the 20th century.

# Examples:
# century(2000) == '20th'
# century(2001) == '21st'
# century(1965) == '20th'
# century(256) == '3rd'
# century(5) == '1st'
# century(10103) == '102nd'
# century(1052) == '11th'
# century(1127) == '12th'
# century(11201) == '113th'

# - round the given number up to the nearest hundred, for example:
#   - rounding 1550 =>  1600
#   - rounding 1601 => 1700
#   - rounding 5 => 100
#   - check the Ingeger#round method
#     - save the last digit to variable `last`
#     - save the rounded up version of `last` to a variable called `rounded`
#     - if `rounded` is less than `last`
#       - add 100 to `number` and save the first two numbers to a variable called century
#     - else
#       - save the first two numbers of `number` to a variable called century  
# - remove all 00s from the rounded number
# - add an ordinal suffix based on the last number of the century
# - Use the following rules for each number:
#   - if 1 add 'st'
#   - if 2 add 'nd'
#   - if 3 add 'rd'
#   - if greater than 4 add 'th'
# - Add an exception rule prior to the last number rule above for
#   11, 12, and 13, which should have 'th'

def century(year)
  century = nil
  year_divmod = year.divmod(100)
  year_divmod.last > 0 ? century = year_divmod.first + 1 : century = year_divmod.first
  ordinal = ""
  century_last = century % 10
  if %w(1 2 3).include?(century_last)
    ordinal << "th" if %(11 12 13).include?(century)
  else
    ordinal << "st" if century_last == 1
    ordinal << "nd" if century_last == 2
    ordinal << "rd" if century_last == 3
    ordinal << "th" if century_last > 4
  end
  "#{century}#{ordinal}"
end

## 3. Leap Years (Part 1)
# Problem:
# In the modern era under the Gregorian Calendar, leap years occur in every year that is evenly 
# divisible by 4, unless the year is also divisible by 100. If the year is evenly divisible by 
# 100, then it is not a leap year unless the year is evenly divisible by 400.
# Assume this rule is good for any year greater than year 0. Write a method that takes any year 
# greater than 0 as input, and returns true if the year is a leap year, or false if it is not 
# a leap year.

# Examples:
# leap_year?(2016) == true
# leap_year?(2015) == false
# leap_year?(2100) == false
# leap_year?(2400) == true
# leap_year?(240000) == true
# leap_year?(240001) == false
# leap_year?(2000) == true
# leap_year?(1900) == false
# leap_year?(1752) == true
# leap_year?(1700) == false
# leap_year?(1) == false
# leap_year?(100) == false
# leap_year?(400) == true

def leap_year?(year)
  return true if (year % 4 == 0) && !(year % 100 == 0)
  return true if (year % 100 == 0) && (year % 400 == 0)
  false
end

leap_year?(2016) == true
leap_year?(2015) == false
leap_year?(2100) == false
leap_year?(2400) == true
leap_year?(240000) == true
leap_year?(240001) == false
leap_year?(2000) == true
leap_year?(1900) == false
leap_year?(1752) == true
leap_year?(1700) == false
leap_year?(1) == false
leap_year?(100) == false
leap_year?(400) == true

## 4. Leap Years (2)
# Problem:
# The British Empire adopted the Gregorian Calendar in 1752, which was a leap year. Prior to 1752,
# the Julian Calendar was used. Under the Julian Calendar, leap years occur in any year that is 
# evenly divisible by 4.
# Using this information, update the method from the previous exercise to determine leap years both
# before and after 1752.

# Examples:
# leap_year?(2016) == true
# leap_year?(2015) == false
# leap_year?(2100) == false
# leap_year?(2400) == true
# leap_year?(240000) == true
# leap_year?(240001) == false
# leap_year?(2000) == true
# leap_year?(1900) == false
# leap_year?(1752) == true
# leap_year?(1700) == true
# leap_year?(1) == false
# leap_year?(100) == true
# leap_year?(400) == true

def leap_year?(year)
  if year < 1752
    year % 4 == 0
  elsif year % 100 == 0
    year % 400 == 0
  else
    year % 4 == 0 && !(year % 100 == 0)
  end
end

leap_year?(2016) == true
leap_year?(2015) == false
leap_year?(2100) == false
leap_year?(2400) == true
leap_year?(240000) == true
leap_year?(240001) == false
leap_year?(2000) == true
leap_year?(1900) == false
leap_year?(1752) == true
leap_year?(1700) == true
leap_year?(1) == false
leap_year?(100) == true
leap_year?(400) == true

## 5. Multiples of 3 and 5
# Problem: 
# Write a method that searches for all multiples of 3 or 5 that lie between 1 and some other
# number, and then computes the sum of those multiples. For instance, if the supplied number is 20,
# the result should be 98 (3 + 5 + 6 + 9 + 10 + 12 + 15 + 18 + 20).
# You may assume that the number passed in is an integer greater than 1.

# Examples:
# multisum(3) == 3
# multisum(5) == 8
# multisum(10) == 33
# multisum(1000) == 234168



def multisum(num)
  multiple_3_and_5 = Proc.new do |n|
    (n % 3 == 0) || (n % 5 == 0)
  end
  (1..num).to_a.select(&multiple_3_and_5).sum
end

multisum(3) == 3
multisum(5) == 8
multisum(10) == 33
multisum(1000) == 234168

## 6. Running Totals
# Write a method that takes an Array of numbers, and returns an Array with the same number of elements,
# and each element has the running total from the original Array.
# Examples:
# running_total([2, 5, 13]) == [2, 7, 20]
# running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
# running_total([3]) == [3]
# running_total([]) == []


# sum all the elements of the array
# remove the last element of the array
# unshift the sum of all elements to a new array
# return array

def running_total(arr)
  result = []
  while arr.size != 0
    sum = arr.sum
    result.unshift(sum)
    arr.pop
  end
  result
end

running_total([2, 5, 13]) == [2, 7, 20]
running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
running_total([3]) == [3]
running_total([]) == []

def running_total(array)
  sum = 0
  array.map { |value| sum += value }
end

## 7. Convert a String to a Number!
# The String#to_i method converts a string of numeric characters (including an optional plus or minus sign)
# to an Integer. String#to_i and the Integer constructor (Integer()) behave similarly. In this exercise,
# you will create a method that does the same thing.
# Write a method that takes a String of digits, and returns the appropriate number as an integer. You may
# not use any of the methods mentioned above.
# For now, do not worry about leading + or - signs, nor should you worry about invalid characters; assume
# all characters will be numeric.
# You may not use any of the standard conversion methods available in Ruby to convert a string to a number,
# such as String#to_i, Integer(), etc. Your method should do this the old-fashioned way and calculate the 
# result by analyzing the characters in the string.

string_to_integer('4321') == 4321
string_to_integer('570') == 570

def string_to_integer(str)
  answer = 0
  str_arr = ("0"..str).to_a
  until answer == (str_arr.size - 1)
    answer += 1
  end
  answer
end


## Another implementation

def approximate(str)
  exponent = str.size - 1
  iterations = ("0"..str[0]).to_a.size - 1
  int = 0
  iterations.times {int += 1}
  int * (10 ** exponent)
end

puts approximate("765") == 700
puts approximate("7") == 7
puts approximate("86") == 80

def str_to_int(str)
  answer = 0
  chars = str.chars
  while chars.size > 0
    answer += approximate(chars.join)
    chars.shift
  end
  answer
end

puts str_to_int("78") == 78
puts str_to_int("98763") == 98763
puts str_to_int("7363828364") == 7363828364

# Further Exploration
# Start with the right-most digit of your hex value. Multiply it by 160, that is: multiply
# by 1. In other words, leave it be, but keep that value off to the side.Remember to convert
# alphabetic hex values (A, B, C, D, E, and F) to their decimal equivalent
# (10, 11, 12, 13, 14, and 15). Move one digit to the left. Multiply that digit by 161 
# (i.e. multipy by 16). Remember that product, and keep it to the side. Move another digit left.
# Multiply that digit by 162 (256) and store that product. Continue multiplying each incremental
# digit of the hex value by increasing powers of 16 (4096, 65536, 1048576, ...), and remember
# each product.
# Once you've multiplied each digit of the hex value by the proper power of 16, add them
# all up. That sum is the decimal equivalent of your hex value.

HEX = ("0".."9").to_a + ("A".."F").to_a

def hexadecimal_to_integer(str)
  answer = 0
  exponent = 0
  str.upcase.chars.reverse.each do |char|
    answer += 16 ** exponent + HEX.index(char)
    exponent += 1
  end
end

hexadecimal_to_integer('4D9f') == 19871

## 8. Convert a String to a signed number!
# Problem:
# Write a method that takes a String of digits, and returns the appropriate number as an integer.
# The String may have a leading + or - sign; if the first character is a +, your method should
# return a positive number; if it is a -, your method should return a negative number. If no sign
# is given, you should return a positive number.
# Examples:
# string_to_signed_integer('4321') == 4321
# string_to_signed_integer('-570') == -570
# string_to_signed_integer('+100') == 100


STR_TO_NUM = ("0".."9").to_a.zip((0..9).to_a).to_h
def string_to_signed_integer(signed_str)
  str = signed_str.delete("^0-9")
  answer = 0
  str.each_char.map {|char| aanswer *= 10 += STR_TO_NUM[char]}
  return answer * -1 if signed_str.match("-")
  answer
end

string_to_signed_integer('4321') == 4321
string_to_signed_integer('-570') == -570
string_to_signed_integer('+100') == 100

## 9. Convert a Number to a String!
# Problem:
# In the previous two exercises, you developed methods that convert simple numeric strings to
# signed Integers. In this exercise and the next, you're going to reverse those methods.
# Write a method that takes a positive integer or zero, and converts it to a string representation.
# You may not use any of the standard conversion methods available in Ruby, such as Integer#to_s, 
# String(), Kernel#format, etc. Your method should do this the old-fashioned way and construct the 
# string by analyzing and manipulating the number.

# Examples:
integer_to_string(4321) == '4321'
integer_to_string(0) == '0'
integer_to_string(5000) == '5000'

INT_TO_STR = ((0..9).to_a.zip("0".."9").to_a).to_h
def integer_to_string(int)
  answer = ""
  int_array = []
  div_mod = int.divmod(10)
  loop do
    if div_mod.first == 0
      int_array.unshift(div_mod.last)
      break
    end
    int_array.unshift(div_mod.last)
    div_mod = div_mod.first.divmod(10)
  end
  int_array.each {|int| answer += INT_TO_STR[int]}
  answer
end

# LS Solution
DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

def integer_to_string(number)
  result = ''
  loop do
    number, remainder = number.divmod(10)
    result.prepend(DIGITS[remainder])
    break if number == 0
  end
  result
end

## 10. Convert a Signed Number to a String!
# In the previous exercise, you developed a method that converts non-negative numbers to strings.
# In this exercise, you're going to extend that method by adding the ability to represent negative
# numbers as well.
# Write a method that takes an integer, and converts it to a string representation.
# You may not use any of the standard conversion methods available in Ruby, such as Integer#to_s,
# String(), Kernel#format, etc. You may, however, use integer_to_string from the previous exercise.
# Examples: 
signed_integer_to_string(4321) == '+4321'
signed_integer_to_string(-123) == '-123'
signed_integer_to_string(0) == '0'

def signed_integer_to_string(int)
  return "0" if int == 0
  str_int = integer_to_string(int.abs)
  return "-" + str_int if int.negative?
  "+" + str_int
end



