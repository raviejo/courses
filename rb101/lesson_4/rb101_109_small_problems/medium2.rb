## 1. Longest Sentence
# Problem:
# Write a program that reads the content of a text file and then prints the longest sentence in the file based on number of words. Sentences may end with periods (.), exclamation points (!),
# or question marks (?). Any sequence of characters that are not spaces or sentence-ending characters should be treated as a word. You should also print the number of words in the longest
# sentence.
# Examples:
# Four score and seven years ago our fathers brought forth
# on this continent a new nation, conceived in liberty, and
# dedicated to the proposition that all men are created
# equal.

# Now we are engaged in a great civil war, testing whether
# that nation, or any nation so conceived and so dedicated,
# can long endure. We are met on a great battlefield of that
# war. We have come to dedicate a portion of that field, as
# a final resting place for those who here gave their lives
# that that nation might live. It is altogether fitting and
# proper that we should do this.

# But, in a larger sense, we can not dedicate, we can not
# consecrate, we can not hallow this ground. The brave
# men, living and dead, who struggled here, have
# consecrated it, far above our poor power to add or
# detract. The world will little note, nor long remember
# what we say here, but it can never forget what they
# did here. It is for us the living, rather, to be dedicated
# here to the unfinished work which they who fought
# here have thus far so nobly advanced. It is rather for
# us to be here dedicated to the great task remaining
# before us -- that from these honored dead we take
# increased devotion to that cause for which they gave
# the last full measure of devotion -- that we here highly
# resolve that these dead shall not have died in vain
# -- that this nation, under God, shall have a new birth
# of freedom -- and that government of the people, by
# the people, for the people, shall not perish from the
# earth.
# The longest sentence in the above text is the last sentence; it is 86 words long. (Note that each -- counts as a word.)

# Another Example

# Download the book at http://www.gutenberg.org/cache/epub/84/pg84.txt, and run your program on this file.

# The longest sentence in this book is 157 words long.

# Downloaded the book and saved it as "text.txt"
text = File.read("text.txt")

def longest_sentence(text)
  text = text.split(/[\.\?!]/)
  text = text.map {|sentence| sentence.split.map(&:strip) }
  max_sentence = text.max_by {|sentence| sentence.size }
  puts "The longest sentence has #{max_sentence.size} characters"
  puts max_sentence.join(" ")
end

longest_sentence(text)

## 2. Now I Know My ABCs
# Problem:
# A collection of spelling blocks has two letters per block, as shown in this list:
# B:O   X:K   D:Q   C:P   N:A
# G:T   R:E   F:S   J:W   H:U
# V:I   L:Y   Z:M
# This limits the words you can spell with the blocks to just those words that do not use both letters from any given block. Each block can only be used once.
# Write a method that returns true if the word passed in as an argument can be spelled from this set of blocks, false otherwise.
# Examples:
# block_word?('BATCH') == true
# block_word?('BUTCH') == false
# block_word?('jest') == true


SPELLING_BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM)

def block_word?(word)
  counter = 0
  SPELLING_BLOCKS.each do |block| 
    word.each_char do |letter|
      counter += 1 if block.include?(letter.upcase)
    end
    if counter >= 2
      return false
    else
      counter = 0
    end
  end
  return true
end

def block_word(word)
  blocks = SPELLING_BLOCKS
  !blocks.map do |block|
    word.upcase.count(block) >= 2
  end.include?(true)
end

def block_word?(word)
  blocks = SPELLING_BLOCKS
  blocks.none? {|block| word.upcase.count(block) >= 2}
end

## 3. Lettercase Percentage Ratio
# Problem:
# In the easy exercises, we worked on a problem where we had to count the number of uppercase and lowercase characters, as well as characters that were neither of those two. 
# Now we want to go one step further.
# Write a method that takes a string, and then returns a hash that contains 3 entries: one represents the percentage of characters in the string that are lowercase letters, 
# one the percentage of characters that are uppercase letters, and one the percentage of characters that are neither.
# You may assume that the string will always contain at least one character.
# Examples:
letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }

def letter_percentages(str)
  lower = (str.count("a-z").to_f / str.size) * 100
  upper = (str.count("A-Z").to_f / str.size) * 100
  remainder = 100 - lower - upper
  lower, upper, remainder = [lower, upper, remainder].map do |n|
    if n % 1 == 0 then n.to_i
    else n
    end
  end
  {lowercase: lower, uppercase: upper, neither: remainder}
end

def letter_percentages(str)
  percentages = {lowercase: "a-z", uppercase: "A-Z", neither: "^A-Za-z"}
  percentages.each do |k, v| 
    percentages[k] = (str.count(v).to_f / str.size * 100).round(2)
  end
end

## 4. Matching Parentheses
# Problem:
# Write a method that takes a string as argument, and returns true if all parentheses in the string are properly balanced, false otherwise. To be properly balanced, parentheses
# must occur in matching '(' and ')' pairs.
# Examples:
# balanced?('What (is) this?') == true
# balanced?('What is) this?') == false
# balanced?('What (is this?') == false
# balanced?('((What) (is this))?') == true
# balanced?('((What)) (is this))?') == false
# balanced?('Hey!') == true
# balanced?(')Hey!(') == false
# balanced?('What ((is))) up(') == false
# Note that balanced pairs must each start with a (, not a ).
def balanced?(str)
  parentheses = str.delete("^()")
  balance = []
  parentheses.each_char do |parenthesis|
    if parenthesis == "("
      balance << parenthesis
    elsif balance.size > 0
      balance.pop
    else
      return false
    end
  end
  balance.size == 0
end

def balanced?(str)
  parens = 0
  str.each_char do |char|
    parens += 1 if char == "("
    parens -= 1 if char == ")"
    break if parens < 0
  end
  parens.zero?
end

# Further Exploration

def balanced_chars?(str, chars)
  count = 0
  str.each_char do |char|
    count += 1 if char == chars[0]
    count -= 1 if char == chars[1]
    break if count < 0
  end
  count.zero?
end

def balanced?(str)
  chars = %w(() {} '' "")
  chars.all? {|char| balanced_chars?(str, char)}
end

## 5. Triangle Sides
# A triangle is classified as follows:
#  - equilateral All 3 sides are of equal length
#  - isosceles 2 sides are of equal length, while the 3rd is different
#  - scalene All 3 sides are of different length
# To be a valid triangle, the sum of the lengths of the two shortest sides must be greater than the length of the longest side, and all sides must have lengths
# greater than 0: if either of these conditions is not satisfied, the triangle is invalid.
# Write a method that takes the lengths of the 3 sides of a triangle as arguments, and returns a symbol :equilateral, :isosceles, :scalene, or :invalid
# depending on whether the triangle is equilateral, isosceles, scalene, or invalid.
# Examples:
# triangle(3, 3, 3) == :equilateral
# triangle(3, 3, 1.5) == :isosceles
# triangle(3, 4, 5) == :scalene
# triangle(0, 3, 3) == :invalid
# triangle(3, 1, 1) == :invalid

def triangle(a, b, c)
  sides = [a, b, c]
  sides.sort.reverse!
  return :invalid if sides.include?(0) || sides[0] > (sides[1,2].sum)
  return :equilateral if (sides.sum / sides.length) == sides[0]
  return :isosceles if sides[0] == sides[1]
  :scalene
end

def triangle(a, b, c)
  sides = [a, b, c]
  sides.sort.reverse!
  triangles = {
    invalid: sides.include?(0) || sides[0] > (sides[1,2].sum),
    equilateral: (sides.sum / sides.length) == sides[0],
    isosceles: sides[0] == sides[1],
    scalene: true
  }
  triangles.key(true)
end

def triangle(a, b, c)
  sides = [a, b, c]
  sides.sort.reverse!
  case
  when sides.include?(0) || sides[0] > (sides[1,2].sum) then :invalid
  when (sides.sum / sides.length) == sides[0] then :equilateral
  when sides[0] == sides[1] then :isosceles
  else :scalene
  end
end

## 6. Tri-Angles
# Problem:
# A triangle is classified as follows:
# right One angle of the triangle is a right angle (90 degrees)
# acute All 3 angles of the triangle are less than 90 degrees
# obtuse One angle is greater than 90 degrees.
# To be a valid triangle, the sum of the angles must be exactly 180 degrees, and all angles must be greater than 0: if either
# of these conditions is not satisfied, the triangle is invalid.
# Write a method that takes the 3 angles of a triangle as arguments, and returns a symbol :right, :acute, :obtuse, or :invalid depending on whether
# the triangle is a right, acute, obtuse, or invalid triangle.
# You may assume integer valued angles so you don't have to worry about floating point errors. You may also assume that the arguments are specified in degrees.

# Examples:
triangle(60, 70, 50) == :acute
triangle(30, 90, 60) == :right
triangle(120, 50, 10) == :obtuse
triangle(0, 90, 90) == :invalid
triangle(50, 50, 50) == :invalid

def triangle(a, b, c)
  angles = [a, b, c]
  case
  when (angles.sum != 180 || angles.any? {|angle| angle <= 0}) then :invalid
  when angles.include?(90) then :right
  when angles.all? {|angle| angle < 90} then :acute
  else :obtuse
  end
end

## 7. Unlucky Days
# Problem:
# Write a method that returns the number of Friday the 13ths in the year given by an argument. You may assume that the year is greater than
# 1752 (when the United Kingdom adopted the modern Gregorian Calendar) and that it will remain in use for the foreseeable future.
# Examples:
friday_13th(2015) == 3
friday_13th(1986) == 1
friday_13th(2019) == 2

# begin at Time Given Year, Month 1, Day 1.
# increase the day by one until the year is greater than the given year
# every time there is a friday, check if the day is the 13th
# if it is increase a counter
# return the counter

def friday_13th(year)
  counter = 0
  current_month = 1
  while current_month <= 12
    current_day = Time.new(year, current_month, 13)
    counter += 1 if current_day.friday?
    current_month += 1
  end
  counter
end
  
## 8. Next Featured Number Higher than a Given Value
# A featured number (something unique to this exercise) is an odd number that is a multiple of 7, and whose digits occur exactly once each.
# So, for example, 49 is a featured number, but 98 is not (it is not odd), 97 is not (it is not a multiple of 7), and 133 is not
# (the digit 3 appears twice).
# Write a method that takes a single integer as an argument, and returns the next featured number that is greater than the argument.
# Return an error message if there is no next featured number.
# Examples:
# featured(12) == 21
# featured(20) == 21
# featured(21) == 35
# featured(997) == 1029
# featured(1029) == 1043
# featured(999_999) == 1_023_547
# featured(999_999_987) == 1_023_456_987
# featured(9_999_999_999) # -> There is no possible number that fulfills those requirements

def featured(num)
  num += 1
  num += 1 until num.odd? && num % 7 == 0
  loop do
    num_chars = num.to_s.chars
    return num if num_chars.uniq == num_chars
    num += 14
    break if num > 9_876_543_210
  end
  "There is no possible number that fulfills those requirements"
end

## 9. Bubble Sort
# Bubble Sort is one of the simplest sorting algorithms available. It isn't an efficient algorithm, but it's a great exercise for student developers.
# In this exercise, you will write a method that does a bubble sort of an Array.
# A bubble sort works by making multiple passes (iterations) through the Array. On each pass, each pair of consecutive elements is compared. If the
# first of the two elements is greater than the second, then the two elements are swapped. This process is repeated until a complete pass is made
# without performing any swaps; at that point, the Array is completely sorted.
# We can stop iterating the first time we make a pass through the array without making any swaps; at that point, the entire Array is sorted.
# For further information, including pseudo-code that demonstrates the algorithm as well as a minor optimization technique, see the Bubble Sort wikipedia page.
# Write a method that takes an Array as an argument, and sorts that Array using the bubble sort algorithm as just described. Note that your sort will
# be "in-place"; that is, you will mutate the Array passed as an argument. You may assume that the Array contains at least 2 elements.
# Examples
array = [5, 3]
bubble_sort!(array)
array == [3, 5]
array = [6, 2, 7, 1, 4]
bubble_sort!(array)
array == [1, 2, 4, 6, 7]
array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

def bubble_sort!(arr)
  iterations = arr.size - 1
  loop do
    passes = 0
    iterations.times do |n|
      if arr[n] > arr[n+1]
        arr[n], arr[n+1] = arr[n+1], arr[n]
      else
        passes += 1
      end
    end
    break if passes == iterations
  end
  nil
end

def bubble_sort!(arr)
  loop do
    sorted = false
    1.upto(arr.size - 1) do |n|
      next if arr[n] > arr[n-1]
      arr[n-1], arr[n] = arr[n], arr[n-1]
      sorted = true
    end
    break unless sorted
  end
  nil
end

def bubble_sort!(arr)
  arr_len = arr.size - 1
  loop do
    sorted = false
    1.upto(arr_len) do |n|
      next if arr[n] > arr[n-1]
      arr[n-1], arr[n] = arr[n], arr[n-1]
      sorted = true
    end
    break unless sorted
    arr_len -= 1
  end
  nil
end

## 10. Sum Square - Square Sum
# Problem:
# Write a method that computes the difference between the square of the sum of the first n positive integers and the sum of the squares of the first n positive integers.
# Examples:
sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
sum_square_difference(10) == 2640
sum_square_difference(1) == 0
sum_square_difference(100) == 25164150

def sum_square_difference(n)
  result = 1.upto(n).sum ** 2
  result -= 1.upto(n).map {|x| x ** 2}.sum
end

