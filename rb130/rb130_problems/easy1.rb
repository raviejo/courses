# 1. Enumerable Class Creation

# A binary tree is just one of many forms of collections, such as Arrays, Hashes, Stacks, Sets, and more.
# All of these collection classes include the Enumerable module, which means they have access to an each
# method, as well as many other iterative methods such as map, reduce, select, and more.

# For this exercise, modify the Tree class to support the methods of Enumerable. You do not have to actually
# implement any methods -- just show the methods that you must provide.

class Tree
  include Enumerable

  def each
  end

  def <=>
  end
end

# 2. Optional Blocks
# Write a method that takes an optional block. If the block is specified, the method should execute it, and return
# the value returned by the block. If no block is specified, the method should simply return the String 'Does not compute.'.

def compute
  result = 'Does not compute.'
  result = yield if block_given?
  result
end

def compute
  return 'Does not compute.' unless block_given?
  yield
end

# p compute { 5 + 3 } == 8
# p compute { 'a' + 'b' } == 'ab'
# p compute == 'Does not compute.'

def compute(arg)
  return 'Does not compute.' unless block_given?
  yield(arg)
end

# p compute(2) { |arg| arg + 5 + 3 } == 10
# p compute('c') { |arg| 'a' + 'b' + 'c' } == 'abc'
# p compute(1) == 'Does not compute.'

# 3. Find Missing Numbers
# Write a method that takes a sorted array of integers as an argument, and returns an array that includes all of the missing integers
# (in order) between the first and last elements of the argument.

def missing(ary)
  result = []
  counter = ary.first
  loop do
    result << counter unless ary.include?(counter)
    counter += 1
    break if counter >= ary.last
  end
  result
end

def missing(ary)
  result = (ary.first...ary.last).to_a
  ary.each {|num| result.delete(num)}
  result
end

def range(first, last, container = [])
  container << first
  if first == last
    return container
  end
  range(first + 1, last, container)
end

def missing(ary)
  range(ary.first, ary.last) - ary
end

# p range(-1, 99400891)

# p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
# p missing([1, 2, 3, 4]) == []
# p missing([1, 5]) == [2, 3, 4]
# p missing([6]) == []

# 4. Divisors
# Write a method that returns a list of all of the divisors of the positive integer passed in as an argument.
# The return value can be in any sequence you wish.

# Examples
# divisors(1) == [1]
# divisors(7) == [1, 7]
# divisors(12) == [1, 2, 3, 4, 6, 12]
# divisors(98) == [1, 2, 7, 14, 49, 98]
# divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute

# def divisors(num, result = [], divisor = 1)
#   result << divisor if num % divisor == 0
#   if num == divisor
#     return result
#   end
#   divisors(num, result, divisor + 1)
# end

def divisors(num)
  result = []
  (1..num).each do |divisor|
    result << divisor if num % divisor == 0
  end
  result
end

# p divisors(1) == [1]
# p divisors(7) == [1, 7]
# p divisors(12) == [1, 2, 3, 4, 6, 12]
# p divisors(98) == [1, 2, 7, 14, 49, 98]
# p divisors(99400891) == [1, 9967, 9973, 99400891]

# 5. Encrypted Pioneers
# The following list contains the names of individuals who are pioneers in the field of computing or that have had a significant
# influence on the field. The names are in an encrypted form, though, using a simple (and incredibly weak) form of encryption
# called Rot13.

# names = %(Nqn Ybirynpr
# Tenpr Ubccre
# Nqryr Tbyqfgvar
# Nyna Ghevat
# Puneyrf Onoontr
# Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
# Wbua Ngnanfbss
# Ybvf Unvog
# Pynhqr Funaaba
# Fgrir Wbof
# Ovyy Tngrf
# Gvz Orearef-Yrr
# Fgrir Jbmavnx
# Xbaenq Mhfr
# Fve Nagbal Ubner
# Zneiva Zvafxl
# Lhxvuveb Zngfhzbgb
# Unllvz Fybavzfxv
# Tregehqr Oynapu).split(/\n/)

# def rot13_idx(idx)
#   idx += 13
#   idx -= 26 if idx >= 25
#   idx
# end

# def rot13(word)
#   alphabet = ("a".."z").to_a
#   word.chars.each.reduce('') do |rotated, char|
#     char_idx = alphabet.index(char.downcase)
#     if char_idx
#       rotated_char = alphabet[rot13_idx(char_idx)].dup
#       rotated_char.upcase! unless alphabet.include?(char)
#       rotated + rotated_char
#     else
#       rotated + char
#     end
#   end
# end

# names.each do |name|
#   puts rot13(name)
# end

# 6. Iterators: True for Any?
# A great way to learn about blocks is to implement some of the core ruby methods that use blocks using your own code.
# Over this exercise and the next several exercises, we will do this for a variety of different standard methods.

# The Enumerable#any? method processes elements in a collection by passing each element value to a block that is provided
# in the method call. If the block returns a value of true for any element, then #any? returns true.
# Otherwise, #any? returns false. Note in particular that #any? will stop searching the collection the first time the block
# returns true.

# Write a method called any? that behaves similarly for Arrays. It should take an Array as an argument, and a block.
# It should return true if the block returns true for any of the element values. Otherwise, it should return false.

# Your method should stop processing elements of the Array as soon as the block returns true.

# If the Array is empty, any? should return false, regardless of how the block is defined.

# Your method may not use any standard ruby method that is named all?, any?, none?, or one?.

def any(ary)
  result = false
  return result if ary.empty?
  counter = 0
  loop do
    current = ary[counter]
    result = yield(current)
    counter += 1
    break if result || counter == ary.size
  end
  result
end

def any(ary)
  ary.each { |elt| return true if yield(elt) }
  false
end

p any([1, 3, 5, 6]) { |value| value.even? } == true
p any([1, 3, 5, 7]) { |value| value.even? } == false
p any([2, 4, 6, 8]) { |value| value.odd? } == false
p any([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any([1, 3, 5, 7]) { |value| true } == true
p any([1, 3, 5, 7]) { |value| false } == false
p any([]) { |value| true } == false

# 7. Iterators: True for All?
# In the previous exercise, you developed a method called any? that is similar to the standard Enumerable#any? method for Arrays
# (our actual solution works with any Enumerable collection). In this exercise, you will develop its companion, all?.

# Enumerable#all? processes elements in a collection by passing each element value to a block that is provided in the method call.
# If the block returns a value of true for every element, then #all? returns true. Otherwise, #all? returns false. Note in
# particular that #all? will stop searching the collection the first time the block returns false.

# Write a method called all? that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should
# return true if the block returns true for all of the element values. Otherwise, it should return false.

# Your method should stop processing elements of the Array as soon as the block returns false.

# If the Array is empty, all? should return true, regardless of how the block is defined.

# Your method may not use any standard ruby method that is named all?, any?, none?, or one?.

def all?(ary)
  ary.each { |elt| return false unless yield(elt) }
  true
end

p all?([1, 3, 5, 6]) { |value| value.odd? } == false
p all?([1, 3, 5, 7]) { |value| value.odd? } == true
p all?([2, 4, 6, 8]) { |value| value.even? } == true
p all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p all?([1, 3, 5, 7]) { |value| true } == true
p all?([1, 3, 5, 7]) { |value| false } == false
p all?([]) { |value| false } == true

# 8. None
def none?(ary)
  ary.each { |elt| return false if yield(elt) }
  true
end

p none?([1, 3, 5, 6]) { |value| value.even? } == false
p none?([1, 3, 5, 7]) { |value| value.even? } == true
p none?([2, 4, 6, 8]) { |value| value.odd? } == true
p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p none?([1, 3, 5, 7]) { |value| true } == false
p none?([1, 3, 5, 7]) { |value| false } == true
p none?([]) { |value| true } == true

# 9. One?
def one?(ary)
  ary.each.with_object(0) do |elt, counter|
    counter += 1 if yield(elt)
    return false if counter == 2
  end == 1
end

one?([1, 3, 5, 6]) { |value| value.even? } == true   # -> true
one?([1, 3, 5, 7]) { |value| value.odd? } == false    # -> false
one?([2, 4, 6, 8]) { |value| value.even? } == false   # -> false
one?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true # -> true
one?([1, 3, 5, 7]) { |value| true } == false          # -> false
one?([1, 3, 5, 7]) { |value| false } == false         # -> false
one?([]) { |value| true } == false                    # -> false

# 10. Count Items
# Write a method that takes an array as an argument, and a block that returns true or false depending on the value
# of the array element passed to it. The method should return a count of the number of times the block returns true.

# You may not use Array#count or Enumerable#count in your solution.

def count(ary)
  ary.each.with_object(0) do |elt, count|
    count += 1 if yield(elt)
  end
end

count([1,2,3,4,5]) { |value| value.odd? } == 3
count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
count([1,2,3,4,5]) { |value| true } == 5
count([1,2,3,4,5]) { |value| false } == 0
count([]) { |value| value.even? } == 0
count(%w(Four score and seven)) { |value| value.size == 5 } == 2

