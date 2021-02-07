## 1. Cute Angles
# Problem:
# Write a method that takes a floating point number that represents an angle between 0 and 360 degrees
# and returns a String that represents that angle in degrees, minutes and seconds. You should use a
# degree symbol (°) to represent degrees, a single quote (') to represent minutes, and a double quote
# (") to represent seconds. A degree has 60 minutes, while a minute has 60 seconds.
# Examples:
# dms(30) == %(30°00'00")
# dms(76.73) == %(76°43'48")
# dms(254.6) == %(254°36'00")
# dms(93.034773) == %(93°02'05")
# dms(0) == %(0°00'00")
# dms(360) == %(360°00'00") || dms(360) == %(0°00'00")

MINS_IN_DEGREE, SECONDS_IN_MIN = 60, 60
DEGREE = "\xC2\xB0"
def dms(float)
  dms_seconds = float * MINS_IN_DEGREE * SECONDS_IN_MIN
  remainder, seconds = dms_seconds.divmod(SECONDS_IN_MIN).map(&:to_i)
  degrees, minutes = remainder.divmod(MINS_IN_DEGREE)
  "#{degrees}#{DEGREE}#{format("%0.2d", minutes)}'#{format("%0.2d", seconds)}\""
end

dms(30) == %(30°00'00")
dms(76.73) == %(76°43'48")
dms(254.6) == %(254°36'00")
dms(93.034773) == %(93°02'05")
dms(0) == %(0°00'00")
dms(360) == %(360°00'00") || dms(360) == %(0°00'00")

# Further Exploration
# Since degrees are normally restricted to the range 0-360, can you modify the code so it returns a value
# in the appropriate range when the input is less than 0 or greater than 360?

def dms(float)
  dms_seconds = float * MINS_IN_DEGREE * SECONDS_IN_MIN
  remainder, seconds = dms_seconds.divmod(SECONDS_IN_MIN).map(&:to_i)
  degrees, minutes = remainder.divmod(MINS_IN_DEGREE)
  degrees %= 60 if degrees > 360
  degrees %=360 if degrees < 0
  "#{degrees}#{DEGREE}#{format("%0.2d", minutes)}'#{format("%0.2d", seconds)}\""
end

## 2. Delete Vowels
# Problem:
# Write a method that takes an array of strings, and returns an array of the same string values, except with the
# vowels (a, e, i, o, u) removed.
# Examples:
# remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
# remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
# remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']

def remove_vowels(arr_of_str)
  vowels = "aeiouAEIOU"
  arr_of_str.map {|word| word.delete(vowels)}
end

remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']

## 3. Fibonacci Number Location By Length
# The Fibonacci series is a series of numbers (1, 1, 2, 3, 5, 8, 13, 21, ...) such that the first 2 numbers are 1 by
# definition, and each subsequent number is the sum of the two previous numbers. This series appears throughout the
# natural world.
# Computationally, the Fibonacci series is a very simple series, but the results grow at an incredibly rapid rate.
# For example, the 100th Fibonacci number is 354,224,848,179,261,915,075 -- that's enormous, especially considering
# that it takes 6 iterations before it generates the first 2 digit number.
# Write a method that calculates and returns the index of the first Fibonacci number that has the number of digits
# specified as an argument. (The first Fibonacci number has index 1.)
# Examples:
# find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
# find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
# find_fibonacci_index_by_length(10) == 45
# find_fibonacci_index_by_length(100) == 476
# find_fibonacci_index_by_length(1000) == 4782
# find_fibonacci_index_by_length(10000) == 47847

def find_fibonacci_index_by_length(len)
  fib = 1
  fib_sequence = [1]
  loop do
    fib_sequence << fib
    fib += fib_sequence[-2,1].sum
    break if fib_sequence.last.to_s.size == len
  end
  fib_sequence.size
end

find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
find_fibonacci_index_by_length(10) == 45
find_fibonacci_index_by_length(100) == 476
find_fibonacci_index_by_length(1000) == 4782
find_fibonacci_index_by_length(10000) == 47847

## 4. Reversed Arrays (Part 1)
# Problem:
# Write a method that takes an Array as an argument, and reverses its elements in place; that is, mutate the Array
# passed into this method. The return value should be the same Array object.
# Examples:
list = [1,2,3,4]
result = reverse!(list)
result == [4, 3, 2, 1] # true
list == [4, 3, 2, 1] # true
list.object_id == result.object_id # true

list = %w(a b e d c)
reverse!(list) == ["c", "d", "e", "b", "a"] # true
list == ["c", "d", "e", "b", "a"] # true

list = ['abc']
reverse!(list) == ["abc"] # true
list == ["abc"] # true

list = []
reverse!(list) == [] # true
list == [] # true

def reverse!(list)
  counter = 1
  list.size.times do
    list[list.size] = list[list.size - counter]
    counter += 1
    list.delete_at(list.size - counter)
  end
  list 
end

## 5. Reversed Arrays (Part 2)
# Problem:
# Write a method that takes an Array, and returns a new Array with the elements of the original list in reverse order.
# Do not modify the original list.
# You may not use Array#reverse or Array#reverse!, nor may you use the method you wrote in the previous exercise.
# Examples:
reverse([1,2,3,4]) == [4,3,2,1]          # => true
reverse(%w(a b e d c)) == %w(c d e b a)  # => true
reverse(['abc']) == ['abc']              # => true
reverse([]) == []                        # => true

list = [1, 3, 2]                      # => [1, 3, 2]
new_list = reverse(list)              # => [2, 3, 1]
list.object_id != new_list.object_id  # => true
list == [1, 3, 2]                     # => true
new_list == [2, 3, 1]                 # => true

def reverse(list)
  reversed = []
  reversed << list.pop until list.empty?
  reversed
end

## 6. Combining Arrays
# Problem:
# Write a method that takes two Arrays as arguments, and returns an Array that contains all of the values
# from the argument Arrays. There should be no duplication of values in the returned Array, even if there
# are duplicates in the original Arrays.
# Examples:
merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]
def merge(arr1, arr2)
  result = arr1 + arr2
  result.uniq
end

## 7. Halvsies
# Problem:
# Write a method that takes an Array as an argument, and returns two Arrays (as a pair of nested Arrays) that
# contain the first half and second half of the original Array, respectively. If the original array contains
# an odd number of elements, the middle element should be placed in the first half Array.
# Exaples:
# halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
# halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
# halvsies([5]) == [[5], []]
# halvsies([]) == [[], []]

def halvsies(arr)
  first_half = []
  first_half << arr.shift until first_half.size >= arr.size
  result = []
  result << first_half << arr
end

halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
halvsies([5]) == [[5], []]
halvsies([]) == [[], []]

## 8. Find the duplicate
# Problem:
# Given an unordered array and the information that exactly one value in the array occurs twice (every other value
# occurs exactly once), how would you determine which value occurs twice? Write a method that will find and 
# return the duplicate value that is known to be in the array.
# Examples:
find_dup([1, 5, 3, 1]) == 1
find_dup([18,  9, 36, 96, 31, 19, 54, 75, 42, 15,
          38, 25, 97, 92, 46, 69, 91, 59, 53, 27,
          14, 61, 90, 81,  8, 63, 95, 99, 30, 65,
          78, 76, 48, 16, 93, 77, 52, 49, 37, 29,
          89, 10, 84,  1, 47, 68, 12, 33, 86, 60,
          41, 44, 83, 35, 94, 73, 98,  3, 64, 82,
          55, 79, 80, 21, 39, 72, 13, 50,  6, 70,
          85, 87, 51, 17, 66, 20, 28, 26,  2, 22,
          40, 23, 71, 62, 73, 32, 43, 24,  4, 56,
          7,  34, 57, 74, 45, 11, 88, 67,  5, 58]) == 73

def find_dup(arr)
  arr.sort!
  last = nil
  arr.each do |num|
    return num if last == num
    last = num
  end
end

# Another solution
def find_dup(array)
  array.find { |element| array.count(element) == 2 }
end

## 9. Does My List Include This?
# Problem:
# Write a method named include? that takes an Array and a search value as arguments. This method should return true
# if the search value is in the array, false if it is not. You may not use the Array#include? method in your
# solution.
# Examples:
include?([1,2,3,4,5], 3) == true
include?([1,2,3,4,5], 6) == false
include?([], 3) == false
include?([nil], nil) == true
include?([], nil) == false

def include?(arr, search)
  arr.each {|val| return true if search == val}
  false
end

# Another solution
def include?(arr, search)
  !!arr.find_index(search)
end

## 10. Right Triangles
# Problem:
# Write a method that takes a positive integer, n, as an argument, and displays a right triangle whose sides each
# have n stars. The hypotenuse of the triangle (the diagonal side in the images below) should have one end at the
# lower-left of the triangle, and the other end at the upper-right.
# Examples:
# triangle(5)

#     *
#    **
#   ***
#  ****
# *****

# triangle(9)

#         *
#        **
#       ***
#      ****
#     *****
#    ******
#   *******
#  ********
# *********

Initialize counter = 0
loop puts "*" * counter
break if counter == num

def triangle(num)
  counter = 1
  loop do
    break if num == 0
    puts " " * num + "*" * counter
    counter += 1
    num -= 1
  end
end

def triangle(num)
  counter = 1
  loop do
    break if num == 0
    puts " " * counter + "*" * num
    counter += 1
    num -= 1
  end
end
