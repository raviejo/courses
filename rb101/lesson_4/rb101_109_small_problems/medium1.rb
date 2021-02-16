## 1. Rotation (Part 1)
# Problem:
# Write a method that rotates an array by moving the first element to the end of the array. The original array should not
# be modified.
# Do not use the method Array#rotate or Array#rotate! for your implementation.
# Examples:
# rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
# rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
# rotate_array(['a']) == ['a']

# x = [1, 2, 3, 4]
# rotate_array(x) == [2, 3, 4, 1]   # => true
# x == [1, 2, 3, 4]                 # => true

def rotate_array(array)
  array[1..-1] + [array[0]]
end

# Further Exploration
def rotate_str(str)
  rotate_array(str.chars).join
end

## 2. Rotation (Part 2)
# Problem:
# Write a method that can rotate the last n digits of a number. For example:
# Note that rotating just 1 digit results in the original number being returned.
# You may use the rotate_array method from the previous exercise if you want. (Recommended!)
# You may assume that n is always a positive integer.
# Examples:
rotate_rightmost_digits(735291, 1) == 735291
rotate_rightmost_digits(735291, 2) == 735219
rotate_rightmost_digits(735291, 3) == 735912
rotate_rightmost_digits(735291, 4) == 732915
rotate_rightmost_digits(735291, 5) == 752913
rotate_rightmost_digits(735291, 6) == 352917

def rotate_rightmost_digits(num, digits)
  (num.to_s[0..-(digits + 1)] + rotate_array(num.to_s[-digits..-1].chars).join).to_i
end

def rotate_rightmost_digits(num, digits)
  (num.to_s[0..-(digits + 1)] + rotate_str(num.to_s[-digits..-1])).to_i
end

def rotate_rightmost_digits(num, digits)
  result = num.to_s.chars
  result[-digits..-1] = rotate_array(result[-digits..-1])
  result.join.to_i
end

##  3. Rotation (Part 3)
# Problem:
# If you take a number like 735291, and rotate it to the left, you get 352917. If you now keep
# the first digit fixed in place, and rotate the remaining digits, you get 329175. Keep the
# first 2 digits fixed in place and rotate again to 321759. Keep the first 3 digits fixed in
# place and rotate again to get 321597. Finally, keep the first 4 digits fixed in place and
# rotate the final 2 digits to get 321579. The resulting number is called the maximum rotation
# of the original number.
# Write a method that takes an integer as argument, and returns the maximum rotation of that
# argument. You can (and probably should) use the rotate_rightmost_digits method from the
# previous exercise.
# Note that you do not have to handle multiple 0s.
# Examples:
max_rotation(735291) == 321579
max_rotation(3) == 3
max_rotation(35) == 53
max_rotation(105) == 15 # the leading zero gets dropped
max_rotation(8_703_529_146) == 7_321_609_845

def max_rotation(num)
  rotations = num.to_s.chars.size
  until rotations == 0
    num = rotate_rightmost_digits(num, rotations)
    rotations -= 1
  end
  num
end

def max_rotation(num)
  result = num.clone
  rotations = num.to_s.chars.size
  rotations.downto(1) {|rotation| result = rotate_rightmost_digits(result, rotation)}
  result
end

## 4. 1000 Lights
# You have a bank of switches before you, numbered from 1 to n. Each switch is connected to
# exactly one light that is initially off. You walk down the row of switches and toggle every
# one of them. You go back to the beginning, and on this second pass, you toggle switches
# 2, 4, 6, and so on. On the third pass, you go back again to the beginning and toggle switches
# 3, 6, 9, and so on. You repeat this process and keep going until you have been through n 
# epetitions.
# Write a method that takes one argument, the total number of switches, and returns an Array
# that identifies which lights are on after n repetitions.
# Example with n = 5 lights:
# round 1: every light is turned on
# round 2: lights 2 and 4 are now off; 1, 3, 5 are on
# round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
# round 4: lights 2 and 3 are now off; 1, 4, and 5 are on
# round 5: lights 2, 3, and 5 are now off; 1 and 4 are on
# The result is that 2 lights are left on, lights 1 and 4. The return value is [1, 4].
# With 10 lights, 3 lights are left on: lights 1, 4, and 9. The return value is [1, 4, 9].

# round 1: {1=>true, 2=>true, 3=>true, 4=>true, 5=>true}
# round 2: {1=>true, 2=>false, 3=>true, 4=>false, 5=>true}
# round 3: {1=>true, 2=>false, 3=>false, 4=>false, 5=>true}
# round 4: {1=>true, 2=>false, 3=>false, 4=>true, 5=>true}
# round 5: {1=>true, 2=>false, 3=>false, 4=>true, 5=>false}

def lights(switches)
  bank_of_switches = (1..switches).to_a.product([false]).to_h
  1.upto(switches) do |count|
    toggles = [count]
    toggles << toggles.last + count until (toggles.last + count) > switches
    toggles.each {|toggle| bank_of_switches[toggle] = !bank_of_switches[toggle]}
  end
  bank_of_switches.select {|switch, state| state}.keys
end

## 5. Diamonds!
# Problem:
# Write a method that displays a 4-pointed diamond in an n x n grid, where n is an odd integer
# that is supplied as an argument to the method. You may assume that the argument will always
# be an odd integer.
# Examples:
# diamond(1)

# *

# diamond(3)

#  *
# ***
#  *

#  diamond(9)

#     *
#    ***
#   *****
#  *******
# *********
#  *******
#   *****
#    ***
#     *


def diamond(num)
  array = (1..num).to_a.select {|n| n.odd?}
  array.concat(array[0..-2].reverse)
  array.size.times {|index| puts ("*" * array[index]).center(num)}
end


# diamond(5)

#   *
#  * *
# *   *
#  * *
#   *


def diamond_outline(num)
  array = (1...num).to_a.select {|n| n.odd?}
  array.concat(array[0..-2].reverse)
  puts "*".center(num)
  array.each {|space| puts ("*" + " " * space + "*").center(num)}
  puts "*".center(num)
end

## 6. A stack is a list of values that grows and shrinks dynamically. In ruby, a stack is easily implemented as an Array that just uses the #push and #pop methods.

# A stack-and-register programming language is a language that uses a stack of values. Each operation in the language operates
# on a register, which can be thought of as the current value. The register is not part of the stack. Operations that require
# two values pop the topmost item from the stack (that is, the operation removes the most recently pushed value from the stack)
# perform the operation using the popped value and the register value, and then store the result back in the register.

# Consider a MULT operation in a stack-and-register language. It multiplies the stack value with the register value, removes the
# value from the stack, and then stores the result back in the register. Thus, if we start with a stack of 3 6 4 (where 4 is the
# topmost item in the stack), and a register value of 7, then the MULT operation will transform things to 3 6 on the stack
# (the 4 is removed), and the result of the multiplication, 28, is left in the register. If we do another MULT at this point,
# then the stack is transformed to 3, and the register is left with the value 168.

# Write a method that implements a miniature stack-and-register-based programming language that has the following commands:

# n Place a value n in the "register". Do not modify the stack.
# PUSH Push the register value on to the stack. Leave the value in the register.
# ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
# SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
# MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
# DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
# MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
# POP Remove the topmost item from the stack and place in register
# PRINT Print the register value
# All operations are integer operations (which is only important with DIV and MOD).

# Programs will be supplied to your language method via a string passed in as an argument. Your program may assume that all programs are correct programs; that is, they won't do anything like try to pop a non-existent value from the stack, and they won't contain unknown tokens.

# You should initialize the register to 0.

# Examples:
minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
# (nothing printed; no PRINT commands)

def minilang(str)
  instructions = str.split
  register = 0
  stack = []
  instructions.each do |frame|
    case frame
    when /[0-9]/ then register = frame.to_i
    when "PUSH" then stack << register
    when "ADD" then register += stack.pop.to_i
    when "SUB" then register -= stack.pop.to_i
    when "MULT" then register *= stack.pop.to_i
    when "DIV" then register /= stack.pop.to_i
    when "MOD" then register %= stack.pop.to_i
    when "POP" then register = stack.pop.to_i
    when "PRINT" then puts register
    end
  end
end

# Further Exploration
# further exploration
# (3 + (4 * 5) - 7) / (5 % 3) => 8
minilang('3 PUSH 5 MOD PUSH 5 PUSH 4 MULT PUSH 7 PUSH 3 SUB ADD DIV PRINT')

# 7. Word to Digit
# Write a method that takes a sentence string as input, and returns the same string with any sequence of the words 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine' converted to a string of digits.
# Example:
word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'

def word_to_digit(str)
  numbers = %w(zero one two three four five six seven eight nine)
  str.split.map do |word| 
    number = numbers.select {|number| word.match?(/\b#{number}\b/)}.first
    number.nil? ? word : word.gsub!(number, numbers.index(number).to_s)
  end.join(" ")
end

def word_to_digit(str)
  numbers = %w(zero one two three four five six seven eight nine)
  numbers.each_with_index do |number, index|
    str.gsub!(/\b#{number}\b/, index.to_s)
  end
  str
end

# 8. Fibonacci Numbers (Recursion)
# The Fibonacci series is a sequence of numbers starting with 1 and 1 where each number is the sum of the two previous numbers: the 3rd Fibonacci number is 1 + 1 = 2, the 4th is 1 + 2 = 3, the 5th is 2 + 3 = 5, and so on. In mathematical terms:
# Write a recursive method that computes the nth Fibonacci number, where nth is an argument to the method.

# F(n - 1) + F(n - 2) where n > 2

def fibonacci(nth)
  return 1 if nth <= 2
  fibonacci(nth - 1) + fibonacci(nth - 2)
end

# tail recursion
def fibonacci_tail(nth, acc1, acc2)
  if nth == 1
    acc1
  elsif nth == 2
    acc2
  else
    fibonacci_tail(nth - 1, acc2, acc2 + acc1)
  end
end

def fibonacci(nth)
  fibonacci_tail(nth, 1, 1)
end

## 9. Fibonacci Numbers (Procedural)
# In the previous exercise, we developed a recursive solution to calculating the nth Fibonacci number. In a language that is not optimized for recursion, some (not all) recursive methods can be extremely slow and require massive quantities of memory and/or stack space.
# Ruby does a reasonably good job of handling recursion, but it isn't designed for heavy recursion; as a result, the Fibonacci solution is only useful up to about fibonacci(40). With higher values of nth, the recursive solution is impractical. (Our tail recursive solution did much better, but even that failed at around fibonacci(8200).)
# Fortunately, every recursive method can be rewritten as a non-recursive (procedural) method.
# Rewrite your recursive fibonacci method so that it computes its results without recursion.
# Examples:
fibonacci(20) == 6765
fibonacci(100) == 354224848179261915075
fibonacci(100_001) # => 4202692702.....8285979669707537501

def fibonacci(nth)
  sequence = []
  1.upto(nth) do |n|
    n <= 2 ? sequence << 1 : sequence << (sequence[-2..-1].sum)
  end
  sequence[-1]
end

# Alternative solution
def fibonacci(nth)
  first, last = [1, 1]
  3.upto(nth) do
    first, last = [last, first + last]
  end
  last
end


# Fibonacci Numbers (Last Digit)
# In the previous exercise, we developed a procedural method for computing the value of the nth Fibonacci numbers. This method was really fast, computing the 20899 digit 100,001st Fibonacci sequence almost instantly.
# In this exercise, you are going to compute a method that returns the last digit of the nth Fibonacci number.
# Examples:
fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
fibonacci_last(123456789) # -> 4
def fibonacci_last(nth)
  first, last = [1, 1]
  3.upto(nth) do
    first, last = [last, first + last]
  end
  last.divmod(10).last
end

# Further exploration 
# After a while, even this method starts to take too long to compute results. Can you provide a solution to this problem that will work no matter how big the number? You should be able to return results almost instantly. For example, the 123,456,789,987,745th Fibonacci number ends in 5.

# Fibonacci numbers repeat themselves every 60 times

"Hello there! My name, is Ricky. How are you doing today?"



