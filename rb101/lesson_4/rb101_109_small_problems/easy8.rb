## 1. Sum of Sums
# Problem:
# Write a method that takes an Array of numbers and then returns the sum of the sums of each leading subsequence
# for that Array. You may assume that the Array always contains at least one number.
# Examples: 
sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
sum_of_sums([4]) == 4
sum_of_sums([1, 2, 3, 4, 5]) == 35

def sum_of_sums(ary)
  counter = 0
  result = 0
  loop do
    result += ary[0,counter].sum
    counter += 1
    break if counter > ary.size
  end
  result
end

## 2. Madlibs
# Problem:
# Mad libs are a simple game where you create a story template with blanks for words. You, or another player, then
# construct a list of words and place them into the story, creating an often silly or funny story as a result.
# Create a simple mad-lib program that prompts for a noun, a verb, an adverb, and an adjective and injects those
# into a story that you create.
# Examples:
# Enter a noun: dog
# Enter a verb: walk
# Enter an adjective: blue
# Enter an adverb: quickly
# Do you walk your blue dog quickly? That's hilarious!

puts "Enter a noun:"
noun = gets.chomp
puts "Enter a verb:"
verb = gets.chomp
puts "Enter an adjetive"
adjetive = gets.chomp
puts "Enter an adverb:"
adverb = gets.chomp
puts "Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!"

## 3. Leading Substrings
# Problem:
# Write a method that returns a list of all substrings of a string that start at the beginning of the original
# string. The return value should be arranged in order from shortest to longest substring.
# Examples:
leading_substrings('abc') == ['a', 'ab', 'abc']
leading_substrings('a') == ['a']
leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']

def leading_substrings(str)
  result = []
  str.chars.each { |char|
    result.empty? ? result << char : result << result.last + char
  }
  result
end

## 4. All Substrings
# Problem:
# Write a method that returns a list of all substrings of a string. The returned list should be ordered by where
# in the string the substring begins. This means that all substrings that start at position 0 should come first,
# then all substrings that start at position 1, and so on. Since multiple substrings will occur at each position,
# the substrings at a given position should be returned in order from shortest to longest.
# You may (and should) use the leading_substrings method you wrote in the previous exercise:
# Examples:
substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]

def substrings(str)
  result = []
  0.upto(str.size) do |n|
    result << leading_substrings(str[n..-1])
  end
  result.flatten
end

## 5. Palindromic Substrings
# Problem:
# Write a method that returns a list of all substrings of a string that are palindromic. That is, each substring must
# consist of the same sequence of characters forwards as it does backwards. The return value should be arranged in the
# same sequence as the substrings appear in the string. Duplicate palindromes should be included multiple times.
# You may (and should) use the substrings method you wrote in the previous exercise.
# For the purposes of this exercise, you should consider all characters and pay attention to case; that is, "AbcbA" is
# a palindrome, but neither "Abcba" nor "Abc-bA" are. In addition, assume that single characters are not palindromes.
# Examples:
palindromes('abcd') == []
palindromes('madam') == ['madam', 'ada']
palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]

def palindromes(str)
  substrings(str).select {|word| word.size > 1 && word == word.reverse}
end

## 6. fizzbuzz
# Problem: 
# Write a method that takes two arguments: the first is the starting number, and the second is the ending number.
# Print out all numbers between the two numbers, except if a number is divisible by 3, print "Fizz", if a number
# is divisible by 5, print "Buzz", and finally if a number is divisible by 3 and 5, print "FizzBuzz".
# Examples: 
fizzbuzz(1, 15) # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz

def fizbuzz(first, last)
  range = (first..last).to_a
  puts (range.map do |n|
    case
    when (n % 3 + n % 5) == 0 then "FizzBuzz"
    when n % 3 == 0 then "Fizz"
    when n % 5 == 0 then "Buzz"
    else n
    end
  end)
end

## 7. Double Char (Part 1)
# Write a method that takes a string, and returns a new string in which every character is doubled.
# Examples:
repeater('Hello') == "HHeelllloo"
repeater("Good job!") == "GGoooodd  jjoobb!!"
repeater('') == ''

def repeater(str)
  result = ''
  str.chars.each {|char| result << char * 2}
  result
end

## 7. Double Char (Part 1)
# Problem:
# Write a method that takes a string, and returns a new string in which every consonant character is
# doubled. Vowels (a,e,i,o,u), digits, punctuation, and whitespace should not be doubled.
# Examples:
double_consonants('String') == "SSttrrinngg"
double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
double_consonants("July 4th") == "JJullyy 4tthh"
double_consonants('') == ""

def double_consonants(str)
  consonants = ("a".."z").to_a - %w(a e i o u)
  result = ''
  str.chars.each {|char| result << (consonants.include?(char.downcase) ? char * 2 : char)}
  result
end

def double_consonants(str)
  result = ''
  str.chars.each {|char| result << (char.match?(/[^aeiou&&[a-z]]/i) ? char * 2 : char)}
  result
end


## 8. Reverse the Digits In a Number
# Problem:
# Write a method that takes a positive integer as an argument and returns that number with its digits reversed.
# Examples:
reversed_number(12345) == 54321
reversed_number(12213) == 31221
reversed_number(456) == 654
reversed_number(12000) == 21 # No leading zeros in return value!
reversed_number(12003) == 30021
reversed_number(1) == 1

def reversed_number(num)
  reversed = num.to_s.reverse.chars
  reversed.delete_at(0) until reversed[0].to_i > 0
  reversed.join.to_i
end

## 10. Get The Middle Character
# Problem: 
# Write a method that takes a non-empty string argument, and returns the middle character or characters of the argument.
# If the argument has an odd length, you should return exactly one character. If the argument has an even length, you
# should return exactly two characters.
# Examples:
center_of('I love ruby') == 'e'
center_of('Launch School') == ' '
center_of('Launch') == 'un'
center_of('Launchschool') == 'hs'
center_of('x') == 'x'

def center_of(str)
  middle = str.size / 2
  str.size.odd? ? str[middle] : str[middle - 1,2]
end