## 1. ASCII String Value
# Write a method that determines and returns the ASCII string value of a string that is passed
# in as an argument. The ASCII string value is the sum of the ASCII values of every character
# in the string. (You may use String#ord to determine the ASCII value of a character.)
# Examples: 
# ascii_value('Four score') == 984
# ascii_value('Launch School') == 1251
# ascii_value('a') == 97
# ascii_value('') == 0

def ascii_value(str)
  str.chars.map(&:ord).sum
end

ascii_value('Four score') == 984
ascii_value('Launch School') == 1251
ascii_value('a') == 97
ascii_value('') == 0

# Further exploration
# There is an Integer method such that:
# char.ord.mystery == char
# where mystery is our mystery method. Can you determine what method name should be used in place of mystery?
# What happens if you try this with a longer string instead of a single character?

char = "F"
char.ord.chr(Encoding::ASCII) == char

## 2. After Midnight (Part 1)
# The time of day can be represented as the number of minutes before or after midnight. If the number of minutes
# is positive, the time is after midnight. If the number of minutes is negative, the time is before midnight.
# Write a method that takes a time using this minute-based format and returns the time of day in 24 hour format
# (hh:mm). Your method should work with any integer input.
# You may not use ruby's Date and Time classes.
# Examples:
# time_of_day(0) == "00:00"
# time_of_day(-3) == "23:57"
# time_of_day(35) == "00:35"
# time_of_day(-1437) == "00:03"
# time_of_day(3000) == "02:00"
# time_of_day(800) == "13:20"
# time_of_day(-4231) == "01:29"

# Input: Integer (minutes)
# Output: String (time formatted 'hh:mm')

# Convert Minutes to HH:MM
# minutes.divmod(60) = [hours, minutes]

# if the number of hours or minutes is less than 10
# prepend '0' before the number
# if the number of hours equals 24
# return '00'

def time_of_day(minutes)
  minutes = minutes.divmod(1440).last if minutes.abs > 1440
  h, m = minutes.divmod(60)
  h += 24 if h.negative?
  h, m = [h, m].map(&:to_s)
  [h, m].each do |str|
    str.prepend("0") if str.to_i < 10
  end
  "#{h}:#{m}"
end

time_of_day(0) == "00:00"
time_of_day(-3) == "23:57"
time_of_day(35) == "00:35"
time_of_day(-1437) == "00:03"
time_of_day(3000) == "02:00"
time_of_day(800) == "13:20"
time_of_day(-4231) == "01:29"

# Further Exploration
# How would you approach this problem if you were allowed to use ruby's Date and Time classes? Suppose you also
# needed to consider the day of week? (Assume that delta_minutes is the number of minutes before or after midnight
# between Saturday and Sunday; in such a method, a delta_minutes value of -4231 would need to produce a return
# value of Thursday 01:29.)

RANDOM_SAT = Time.new(2021, 2, 7)
SECONDS_IN_MIN = 60
MINUTES_IN_HOUR = 60
SECONDS_IN_HOUR = MINUTES_IN_HOUR * SECONDS_IN_MIN
HOURS_IN_DAY = 24
MINUTES_IN_DAY = MINUTES_IN_HOUR * HOURS_IN_DAY
SECONDS_IN_DAY = MINUTES_IN_DAY * SECONDS_IN_MIN

def delta_time(delta_minutes)
  days, delta_minutes = delta_minutes.divmod(MINUTES_IN_DAY)
  hours, minutes = delta_minutes.divmod(MINUTES_IN_HOUR)
  delta = RANDOM_SAT + (days * SECONDS_IN_DAY) + (hours * SECONDS_IN_HOUR) + (minutes * SECONDS_IN_MIN)
  delta.strftime("%A %H:%M")
end

## 3. After Midnight (Part 2)
# Problem:
# As seen in the previous exercise, the time of day can be represented as the number of minutes before or after midnight.
# If the number of minutes is positive, the time is after midnight. If the number of minutes is negative, the time is
# before midnight.
# Write two methods that each take a time of day in 24 hour format, and return the number of minutes before and after
# midnight, respectively. Both methods should return a value in the range 0..1439.
# You may not use ruby's Date and Time methods.

# Examples:
# after_midnight('00:00') == 0
# before_midnight('00:00') == 0
# after_midnight('12:34') == 754
# before_midnight('12:34') == 686
# after_midnight('24:00') == 0
# before_midnight('24:00') == 0

MINUTES_IN_HOUR = 60
def after_midnight(str)
  hours, minutes = str.split(':').map(&:to_i)
  hours %= 24
  (hours * MINUTES_IN_HOUR) + minutes
end

def before_midnight(str)
  hours, minutes = str.split(':').map(&:to_i)
  hours %= 24
  (hours * MINUTES_IN_HOUR) - minutes
end

after_midnight('00:00') == 0
before_midnight('00:00') == 0
after_midnight('12:34') == 754
before_midnight('12:34') == 686
after_midnight('24:00') == 0
before_midnight('24:00') == 0

# Further Exploration
# How would these methods change if you were allowed to use the Date and Time classes?
SECONDS_IN_MIN = 60
START_OF_WEEK = Time.at(0).gmtime
def afer_midnight(str)
  hours, minutes = str.split(':').map(&:to_i)
  hours, minutes = [hours * 3600, minutes * 60]
  (START_OF_WEEK + hours + minutes).sec
end

def afer_midnight(str)
  hours, minutes = str.split(':').map(&:to_i)
  hours, minutes = [hours * 3600, minutes * 60]
  (START_OF_WEEK + hours - minutes).sec
end

## 4. Letter Swap
# Given a string of words separated by spaces, write a method that takes this string of words
# and returns a string in which the first and last letters of every word are swapped.
# You may assume that every word contains at least one letter, and that the string will always
# contain at least one word. You may also assume that each string contains nothing but words
# and spaces

# Input: "ricky"
# Output: "yickr"
# Remove the first and last characters from the string
#   - middle = "ick"
# Append the removed characters into a new string
#   - first_last = "ry"
# Reverse the first and last strings
#   - fisrt_last = "yr"
# Return the first of first last + middle + last of first_last

# swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
# swap('Abcde') == 'ebcdA'
# swap('a') == 'a'

def swap_word(word)
  return word.reverse if word.size <= 2
  chars = word.chars
  swapped = ""
  swapped << chars.pop + chars.shift
  swapped[0] + chars.join + swapped[1]
end

def swap(str)
  str.split.map{|word| swap_word(word)}.join(" ")
end

swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
swap('Abcde') == 'ebcdA'
swap('a') == 'a'

## 5. Clean up the words
# Given a string that consists of some words (all lowercased) and an assortment of non-alphabetic characters,
# write a method that returns that string with all of the non-alphabetic characters replaced by spaces.
# If one or more non-alphabetic characters occur in a row, you should only have one space in the result (the
# result should never have consecutive spaces).

cleanup("---what's my +*& line?") == ' what s my line '

# non_alphanum_to_space
# check whether a given character is alphanumeric
#   create an array of all alphanumeric characters
#   check if the current character is in the list
#   if the character is not in the list, change it to a space
#   else return the character

ALPHANUMS = (0..9).to_a + ("A".."Z").to_a + ("a".."z").to_a
def non_alphanum_to_space(char)
  return " " unless ALPHANUMS.include?(char)
  char
end

"---what's my +*& line?".each_char.map {|char| non_alphanum_to_space(char)}.join == "   what s my     line "

# remove_space
# check if two or more spaces occur in succession
#   loop through the list of characters 
#   if the character is a space
#   check if there is another space after it
#   if there is, delete the current space

# remove_space("  hello") == " hello"
def remove_space(str)
  chars = str.chars
  chars.size.times do |num|
    if chars[num] == " " && chars[num + 1] == " "
      chars.delete_at(num)
    end
  end
  chars.join
end

def remove_spaces(str)
  loop do
    break if str == remove_space(str)
    str = remove_space(str)
  end
  str
end

remove_spaces("  hello") == " hello"

def cleanup(str)
  str = str.each_char.map {|char| non_alphanum_to_space(char)}.join
  remove_spaces(str)
end

# cleaner solution

def cleanup(str)
  clean = []
  alphabetics = ("a".."z").to_a
  str.chars.each do |char|
    if alphabetics.include?(char)
      clean << char
    else
      clean << " " unless clean.last == " "
    end
  end
  clean.join
end

## 6. Letter Counter (Part 1)
# Problem:
# Write a method that takes a string with one or more space separated words and returns a hash that shows the
# number of words of different sizes.
# Words consist of any string of characters that do not include a space.
# Examples:
# word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
# word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
# word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
# word_sizes('') == {}

def word_sizes(str)
  frequency = Hash.new(0)
  str.split.each do |char|
    frequency[char.size] += 1
  end
  frequency
end

word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
word_sizes('') == {}

## 7. Letter Counter (Part 2)
# Problem:
# Modify the word_sizes method from the previous exercise to exclude non-letters when determining word size.
# For instance, the length of "it's" is 3, not 4.
# Examples:
# word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
# word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
# word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
# word_sizes('') == {}

def word_sizes(str)
  frequency = Hash.new(0)
  str.split.each do |char|
    char.delete!("^a-zA-Z")
    frequency[char.size] += 1
  end
  frequency
end

word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
word_sizes('') == {}

## 8. 
# Problem:
# Write a method that takes an Array of Integers between 0 and 19, and returns an Array of those Integers sorted based
# on the English words for each number:
# zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen
# Examples:
alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]

ENGLISH_NUMS = %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
def alphabetic_number_sort(arr)
  sorted = []
  arr.each {|num| sorted << ENGLISH_NUMS[num]}
  sorted.sort!
  sorted.map {|str| ENGLISH_NUMS.index(str)}
end

# simpler solution with sort_by
def alphabetic_number_sort(numbers)
  numbers.sort_by { |number| NUMBER_WORDS[number] }
end


## 9. ddaaiillyy ddoouubbllee
# Write a method that takes a string argument and returns a new string that contains the value of the original string
# with all consecutive duplicate characters collapsed into a single character. 
# You may not use String#squeeze or String#squeeze!.

def crunch(str)
  crunched = []
  str.split.each do |word|
    word_chars = []
    word.each_char {|char| word_chars << char unless word_chars.last == char}
    crunched << word_chars.join
  end
  crunched.join(" ")
end

# With regular expressions
def crunch_regexp(phrase)
  phrase.gsub(/(.)\1+/, '\1')
end

## 10. Bannerize
# Problem:
# Write a method that will take a short line of text, and print it within a box.
# print_in_box('To boldly go where no one has gone before.')
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

def print_in_box(str)
  char_count = str.size + 2
  cross = "#{"+" + "-" * char_count + "+"}"
  spacer = "#{"|" + " " * char_count + "|"}"
  message = "#{"| " + str + " |"}"
  puts cross
  puts spacer
  puts message
  puts spacer
  puts cross
end




