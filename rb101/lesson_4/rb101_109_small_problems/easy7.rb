## 1. Combine Two Lists
# Problem:
# Write a method that combines two Arrays passed in as arguments, and returns a new Array that contains all
# elements from both Array arguments, with the elements taken in alternation.
# You may assume that both input Arrays are non-empty, and that they have the same number of elements.
# Examples:
# interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

def interleave(ary1, ary2)
  result = []
  ary1.size.times {|n| result << ary1[n] << ary2[n] }
  result
end

interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

# Take a few minutes to read about Array#zip. #zip doesn't do the same thing as interleave, but it is very close,
# and more flexible. In fact, interleave can be implemented in terms of zip and one other method from the Array
# class. See if you can rewrite interleave to use zip.

def interleave(ary1, ary2)
  ary1.zip(ary2).flatten
end

## 2. Lettercase Counter
# Problem:
# Write a method that takes a string, and then returns a hash that contains 3 entries: one represents the number of
# characters in the string that are lowercase letters, one the number of characters that are uppercase letters, and
# one the number of characters that are neither.
# Examples:
letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }

def letter_case_count(str)
  result = {lowercase: 0, uppercase: 0, neither: 0}
  lowercase = ("a".."z").to_a
  uppercase = ("A".."Z").to_a
  str.each_char do |char|
    if uppercase.include?(char)
      result[:uppercase] += 1
    elsif lowercase.include?(char)
      result[:lowercase] += 1
    else 
      result[:neither] += 1
    end
  end
  result
end

## 3. Capitalize Words
# Write a method that takes a single String argument and returns a new string that contains the original value of the
# argument with the first character of every word capitalized and all other letters lowercase.
# You may assume that words are any sequence of non-blank characters.

word_cap('four score and seven') == 'Four Score And Seven'
word_cap('the javaScript language') == 'The Javascript Language'
word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'

def word_cap(str)
  str.split.map(&:capitalize).join(" ")
end

# Further Exploration
# Ruby conveniently provides the String#capitalize method to capitalize strings. Without that method, how would you solve
# this problem? Try to come up with at least two solutions.

CAPITALS = ("a".."z").to_a.zip("A".."Z").to_a.to_h

def word_cap(str)
  result = []
  str.split.each do |word| 
    chars = word.chars
    chars[0] = CAPITALS[chars[0]]
    result << chars.join
  end
  result.join(" ")
end

## 4. Swap Case
# Problem:
# Write a method that takes a string as an argument and returns a new string in which every uppercase letter is replaced by
# its lowercase version, and every lowercase letter by its uppercase version. All other characters should be unchanged.
# You may not use String#swapcase; write your own version of this method.
# Examples:
# swapcase('CamelCase') == 'cAMELcASE'
# swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'

def swapcase(str)
  lowercase = ("a".."z").to_a
  uppercase = ("A".."Z").to_a
  str.chars.map do |char|
    if lowercase.include?(char)
      char.upcase!
    elsif uppercase.include?(char)
      char.downcase!
    else
      char
    end
  end.join
end

swapcase('CamelCase') == 'cAMELcASE'
swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'

# Another solution
def swapcase(string)
  characters = string.chars.map do |char|
    if char =~ /[a-z]/
      char.upcase
    elsif char =~ /[A-Z]/
      char.downcase
    else
      char
    end
  end
  characters.join
end

## 5. Staggered Caps (1)
# Problem 
# Write a method that takes a String as an argument, and returns a new String that contains the original value using a
# staggered capitalization scheme in which every other character is capitalized, and the remaining characters are
# lowercase. Characters that are not letters should not be changed, but count as characters when switching between upper
# and lowercase.
# Examples:
# staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
# staggered_case('ALL_CAPS') == 'AlL_CaPs'
# staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

def staggered_case(str)
  str.chars.each_with_index {|char, i| i.even? ? char.upcase! : char.downcase!}.join
end

staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
staggered_case('ALL_CAPS') == 'AlL_CaPs'
staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

def staggered_case(str, downcase=false)
  if downcase
    str.chars.each_with_index {|char, i| i.even? ? char.downcase! : char.upcase!}.join
  else
    str.chars.each_with_index {|char, i| i.even? ? char.upcase! : char.downcase!}.join
  end
end

## 6. Staggered Caps (Part 2)
# Problem:
# Modify the method from the previous exercise so it ignores non-alphabetic characters when determining whether it should
# uppercase or lowercase each letter. The non-alphabetic characters should still be included in the return value; they
# just don't count when toggling the desired case.
# Examples:
staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
staggered_case('ALL CAPS') == 'AlL cApS'
staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'


def staggered_case(str)
  counter = 0
  result = []
  str.each_char do |char|
    if char.match?(/[^a-z]/i)
      result << char
    elsif char.match?(/[a-z]/i) && counter.even?
      result << char.upcase
      counter += 1
    else
      result << char.downcase
      counter += 1
    end
  end
  result.join
end


if char.match?(/[^a-z]/i)
  char
elsif char.match?(/[a-z]/i) && counter.even?
  char.upcase
  counter += 1
else
  char.downcase
  counter += 1
end

## 7. Multiplicative Average
# Problem:
# Write a method that takes an Array of integers as input, multiplies all the numbers together, divides the result by
# the number of entries in the Array, and then prints the result rounded to 3 decimal places. Assume the array is
# non-empty.
# Examples:
show_multiplicative_average([3, 5])                # => The result is 7.500
show_multiplicative_average([6])                   # => The result is 6.000
show_multiplicative_average([2, 5, 7, 11, 13, 17]) # => The result is 28361.667

def show_multiplicative_average(ary_of_num)
  (ary_of_num.reduce(&:*).to_f / ary_of_num.count).round(3)
end

## 8. Multiply Lists
# Problem:
# Write a method that takes two Array arguments in which each Array contains a list of numbers, and returns a new Array
# that contains the product of each pair of numbers from the arguments that have the same index. You may assume that
# the arguments contain the same number of elements.
# Examples:
multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]

def multiply_list(ary1, ary2)
  result = []
  ary1.each_with_index {|elt, i| result << (elt * ary2[i])}
  result
end

# Further Exploration
# The Array#zip method can be used to produce an extremely compact solution to this method. Read the documentation for zip,
# and see if you can come up with a one line solution (not counting the def and end lines).

def multiply_list(ary1, ary2)
  ary1.zip(ary2).map {|char| char.reduce(&:*)}
end

## 9. Multiply All Pairs
# Problem:
# Write a method that takes two Array arguments in which each Array contains a list of numbers, and returns a new Array that
# contains the product of every pair of numbers that can be formed between the elements of the two Arrays. The results
# should be sorted by increasing value.
# You may assume that neither argument is an empty Array.
# Examples:
multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]

def multiply_all_pairs(ary1, ary2)
  ary1.product(ary2).map {|pair| pair.reduce(&:*)}.sort
end

def multiply_all_pairs(ary1, ary2)
  result = []
  ary1.each do |elt|
    ary2.each do |elt2|
      result << (elt * elt2)
    end
  end
  result.sort
end

## 10. The End Is Near But Not Here
# Write a method that returns the next to last word in the String passed to it as an argument.
# Words are any sequence of non-blank characters.
# You may assume that the input String will always contain at least two words.
# Examples:
penultimate('last word') == 'last'
penultimate('Launch School is great!') == 'is'

def penultimate(phrase)
  phrase.split[-2]
end

# Further Exploration
# Suppose we need a method that retrieves the middle word of a phrase/sentence. What edge cases
# need to be considered? How would you handle those edge cases without ignoring them? Write a
# method that returns the middle word of a phrase or sentence. It should handle all of the edge
# cases you thought of.
# Edge Cases:
# What if a sentence has an odd number of words?
# What if a sentence has less than three words?
# Should it ignore non-alphanumeric characters?
# Should it ignore spaces?






