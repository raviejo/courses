
produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

# select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}

def select_fruit(produce_dict)
  selected_fruit = {}
  counter = 0
  produce_list = produce_dict.keys
  
  loop do
    produce = produce_list[counter]
    produce_type = produce_dict[produce]
    
    if produce_type == 'Fruit'
      selected_fruit[produce] = produce_type
    end
    
    counter += 1
    break if counter == produce_list.size
  end
  
  selected_fruit
end

p select_fruit(produce) == {"apple"=>"Fruit", "pear"=>"Fruit"}

def double_numbers(n_list)
  counter = 0
  
  loop do 
    n_list[counter] *= 2
    counter += 1
    break if counter == n_list.size
  end
end

def double_odd_indexes(n_list)
  doubled = []
  counter = 0
  
  loop do 
  current_number = n_list[counter]
  current_number *= 2 if counter.odd?
  doubled << current_number
  
  counter += 1
  break if counter >= n_list.size
  end
  
  doubled
end


# Try coding a method that allows you to multiply every array item by a specified value
def multiply(n_list, multiplier)
  transformed_n_list = []
  counter = 0
  
  loop do
    current_number = n_list[counter]
    current_number *= multiplier
    transformed_n_list << current_number
    
    counter += 1
    break if counter >= n_list.size
  end
  
  transformed_n_list
  
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) == [3, 12, 9, 21, 6, 18]

my_hash = {ricky: 28, peter: 17, michael: 40, bob: 22}
p my_hash.select {|k, v| v > 15}
p my_hash.find_all {|k, v| v > 15}

## Sorting - the classic problem
## But with recursion
numbers = [2, 5, 3, 4, 1]

# Get the max and its index
def my_max(num, num_list)
  current_num = num_list[0]
  if current_num.nil?
    return num
  else
    num > current_num ? (num = num) : (num = current_num)
    my_max(num, num_list[1..-1])
  end
end

p my_max(numbers.first,numbers)

def max_index(num, num_list, counter)
  if num == my_max(num, num_list)
    return counter
  else
    counter += 1
    max_index(num_list[counter], num_list, counter)
  end
end

p max_index(numbers.first, numbers, 0)

def my_sort(result, num_list)
  if num_list.empty?
    return result
  else
    first = num_list.first
    rest = num_list[1..-1]
    max = my_max(first, rest)
    idx = max_index(first, num_list, 0)
    
    result << max
    
    rest = num_list[0...idx] + num_list[idx+1..-1]
    my_sort(result, rest)
  end
end

def sort_desc(num_list)
  my_sort([], num_list)
end

other_numbers = [4, 4, 7, 8]

p numbers
p sort_desc(numbers)
p numbers
p sort_desc(other_numbers)

"A".ord # => 97
"a".ord # => 65

"A" <=> "a" # => 97 <=> 65 => -1

p (['cot', 'bed', 'mat'].sort_by do |word|
  word[1]
end)

p (['rhapsody', 'bee', 'child', 'happy', 'ugly'].sort_by do |word|
  word[1]
end)

p (['will', 'john', 'kevin', 'amy', 'tash'].sort_by do |word|
  word[1]
end)

p (['a b', 'c z', 'f m'].sort_by do |word|
  word[1]
end)

=begin
Given an integer n, find the maximal number you can obtain by deleting exactly one digit of the given number.

Example
For n = 152, the output should be 52;

For n = 1001, the output should be 101.

Input/Output
[input] integer n

Constraints: 10 ≤ n ≤ 1000000.

[output] an integer
=end
# p delete_digit(152) == 52
# p delete_digit(1001) == 101
# p delete_digit(10) == 1

# Algorithm
# - Split up each number into a collection of its digits
# - Find all possible combinations of the size of the collection minus one
#   - For example, if the collection has 3 items, find all pairs. If it has 4 items, find all triplets.
#   - Iterate through the collection # => Example: [1, 2, 3]
#      - Keep tabs on the first digit of the collection # => [1]
#      - Keep tabs on the rest of the collection # => [2, 3]
#      - Keep tabs on where you are in the iteration (current index) # => 0
#      - Iterate through the rest of the collection # => [2, 3]
#         - Make a range of rest, starting from the current index and extending to the size of the collection minus two
#            - The first range would be [2]
#         - Concatenate the first with the range of rest and add it to a combinations collection 
#         - Keep iterating until the size of the range is less than the size of the collection minus two
#      - Stop iterating if rest is out of bounds or if the size of rest is less than the desired size (collection minus 1)
# - Find the max out of the combinations and return it

def delete_digit(num)
  num_digits = num.to_s.chars
  combo_size = num_digits.size - 1
  combinations = []

  num_digits.each_with_index do |first, current_idx|
    rest = num_digits[current_idx+1..-1]
    
    if !rest.nil?
      rest.size.times do |idx|
        range = rest[idx, combo_size - 1]
        if range.size == combo_size - 1
          combinations << ([first] + range)
        end
      end
    end

  end

  combinations.each_with_index do |combo, idx|
    combinations[idx] = combo.reduce(:+).to_i
  end

  combinations.max
end

p delete_digit(152) == 52
p delete_digit(1001) == 101
p delete_digit(10) == 1

# find all pairs

# find_pairs(["1", "2", "3"]) == [["1", "2"], ["1, 3"], ["2, 3"]]

# Algo
# - Iterate through each element of the collection
#   - Keep tabs on the first of the collection
#   - Keep tabs on the rest of the collection
#   - If rest is not out of bounds
#     - Iterate over the rest of the collection
#       - Create a sub collection with the first and the current number of rest
#       - Add the sub collection to a results collection
#       - Stop iteration when you run out of numbers
#   - Stop the iteration when you run out of numbers
# - Return the results collection

def find_pairs(collection)
  results = []
  collection.each_with_index do |current_num, idx|
    first = current_num
    rest = collection[idx+1..-1]

    if !rest.nil?
      rest.each do |rest_n|
        sub_collection = [first, rest_n]
        results << sub_collection
      end
    end
  
  end
  results
end

find_pairs(["1", "2", "3"]) == [["1", "2"], ["1", "3"], ["2", "3"]]


# Farey Sequence
# The Farey sequence of order n is the set of all fractions with a denominator between 1 and n, 
# reduced and returned in ascending order. Given n, return the Farey sequence as a list, with 
# each fraction being represented by a string in the form "numerator/denominator".

# p farey(1) #== ["0/1", "1/1"]
# p farey(4) #== ["0/1", "1/4", "1/3", "1/2", "2/3", "3/4", "1/1"]
# p farey(5) #== ["0/1", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1"]

# Algo
# - Finding the sequence: 
# - Identify the range 0 through the given number (n)
# - Take each number in the range and create a collection of fractions as strings
# - The fractions will have the current number in the range as the numerator
# - The denominator will change on each iteration and be 0 through the given number n
#   - watch out for divisions by zero
#   - skip instances in which the denominator is less than the numerator

# - Sorting the sequence: 
# - Create a frequency table in which the key is the float value of the fraction
#   and the value is the fraction as a string 
# - Do not add more than one value to a given key, just skip it
# - Sort the table keys and return the values

def farey(num)
  range = (0..num)
  fractions = {}
  range.each do |numerator|
    range.each do |denominator|
      next if denominator.zero? || denominator < numerator
      decimal = numerator.fdiv(denominator)
      if fractions.has_key?(decimal)
        next
      else
        fractions[decimal] = "#{numerator}/#{denominator}"
      end
    end
  end

  fractions.keys.sort.map do |key|
    fractions[key]
  end
end

p farey(1) == ["0/1", "1/1"]
p farey(4) == ["0/1", "1/4", "1/3", "1/2", "2/3", "3/4", "1/1"]
p farey(5) == ["0/1", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1"]


def farey(number)
  range = (1..number).to_a.combination(2).to_a
  range.unshift([0,1])
  range << [1,1]

  result = []
  decimals = []
  range.each do |fraction|
    decimal = fraction[0].fdiv(fraction[1])
    if !decimals.include?(decimal) # skip the duplicate decimals
      decimals << decimal
      result << fraction
    end
  end

  result.sort_by! do |fraction|
    fraction[0].fdiv(fraction[1])
  end

  result.map {|fraction| "#{fraction[0]}/#{fraction[1]}"}
end

p farey(1) == ["0/1", "1/1"]
p farey(4) == ["0/1", "1/4", "1/3", "1/2", "2/3", "3/4", "1/1"]
p farey(5) == ["0/1", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1"]

=begin
Given a 3x3 matrix of a completed tic-tac-toe game, create a function that returns whether the game is 
a win for "X", "O", or a "Draw", where "X" and "O" represent themselves on the matrix, and "E" 
represents an empty spot.

Examples
tic_tac_toe([
  ["X", "O", "X"],
  ["O", "X",  "O"],
  ["O", "X",  "X"]
]) == "X"

tic_tac_toe([
  ["O", "O", "O"],
  ["O", "X", "X"],
  ["E", "X", "X"]
]) == "O"

tic_tac_toe([
  ["X", "X", "O"],
  ["O", "O", "X"],
  ["X", "X", "O"]
]) == "Draw"

Notes
Make sure that if O wins, you return the letter "O" and not the integer 0 (zero) and if it's a draw, 
make sure you return the capitalised word "Draw". If you return "X" or "O", make sure they're capitalised too.
=end

# Problem
# - Input => 3x3 matrix of nested arrays of strings
#            - Each string represents the "X", "O", or "E" (empty) in a tic tac toe game
# - Output => String representing the result
# - Outputs must be Capitalized

# Examples

# Data Structures
# - Strings
# - Arrays

# Algo
# - Check each row and check each column
#   - If all the strings in a row or column are the same, the first string is the winner
# - Otherwise we have to check for diagonal winners
#   - Take the first of row 1, the middle of row 2, and the last of row 3
#     - If all the strings match, return the first string
#   - Otherwise take the last of row 1, the middle of row 2, and the last of row 3
#     - If all the strings match, return the last string
# - If there are no winners, return "Draw"

def winner?(arr)
  arr.uniq.size == 1
end

def tic_tac_toe(game)
  winner = nil
  # check the rows
  game.each {|row| winner = row[0] if winner?(row)}
  # check the columns
  game.size.times do |idx|
    row = game.map {|col| col[idx]}
    winner = row[0] if winner?(row)
  end
  # check diagonals
  diagonal_one = [game[0][0], game[1][1], game[2][2]]
  diagonal_two = [game[0][2], game[1][1], game[2][0]]
  [diagonal_one, diagonal_two].each {|diagonal| winner = diagonal[0] if winner?(diagonal)}
  # return the result
  return winner unless winner.nil?
  "Draw"
end

def tic_tac_toe(game)
  # diagonals
  diagonals = []
  [0.upto(2),2.downto(0)].each do |diagonal|
    placeholder = []
    diagonal.each do |idx|
      p idx
      p game[idx][idx]
      placeholder << game[idx][idx]
    end
    diagonals << placeholder
  end
  diagonals
end

p tic_tac_toe([
  ["X", "O", "X"],
  ["O", "X",  "O"],
  ["O", "X",  "X"]
]) == "X"

p tic_tac_toe([
  ["O", "O", "O"],
  ["O", "X", "X"],
  ["E", "X", "X"]
]) == "O"

p tic_tac_toe([
  ["X", "X", "O"],
  ["O", "O", "X"],
  ["X", "X", "O"]
]) == "Draw"

=begin
1. Ones and Zeroes
Write a function that returns True if every consecutive sequence of ones is followed by a consecutive sequence of zeroes of the same length.

Examples
=end
# same_length("110011100010") == true

# same_length("101010110") == false

# same_length("111100001100") == true

# same_length("111") == false

# Algo
# - Count the ones
# - Retrieve the numbers following the ones
#   - Only retrieve an amount equal to the count of ones
#   - Count the zeros in the range
# - Compare the count of ones to zeros
# - Repeat for the entire string

def same_length(str)
  ones = 0
  # count the first set of ones
  str.chars.each do |char|
    break if char == "0"
    ones += 1
  end
  # base condition
  return true if ones.zero?
  
  # count the first set of zeros
  zeros = ones if str.chars[ones,ones].uniq.size == 1 && str.chars[ones,ones].size == ones
  ones == zeros && same_length(str[(ones * 2)..-1])
end

p "same length:"

p same_length("110011100010") == true

p same_length("101010110") == false

p same_length("111100001100") == true

p same_length("111") == false

p same_length("000")

=begin
A password is considered strong if the below conditions are all met:

It has at least 6 characters and at most 20 characters.
It contains at least one lowercase letter, at least one uppercase letter, and at least one digit.
It does not contain three repeating characters in a row (i.e., "...aaa..." is weak, but "...aa...a..." is strong, assuming other conditions are met).
Given a string password, return the minimum number of steps required to make password strong. if password is already strong, return 0.

In one step, you can:

Insert one character to password,
Delete one character from password, or
Replace one character of password with another character.
 

Example 1:

Input: password = "a"
Output: 5
Example 2:

Input: password = "aA1"
Output: 3
Example 3:

Input: password = "1337C0d3"
Output: 0
 

Constraints:

1 <= password.length <= 50
password consists of letters, digits, dot '.' or exclamation mark '!'.

=end

# Algo
# Create a result counter

# Character Count:
# - Check if the given password contains 6 characters
# - If it doesn't, add the difference to a character counter

# Check if the word includes at least one lowercase, uppercase, or digit:
# - If it doesn't, add one to a validation counter for each check

# Update the result counter:
# - Assign the max between the character counter and the validation counter to the result counter

# Check consecutive characters:
# - Create a consecutive character collection
# - Create a consecutive character counter (start at one)
# - Take the first character
# - Compare it to the next character
#   - Keep comparing it to each subsequent character until they are different
# - If they are the same add one to the consecutive counter
# - Select the instances that are greater than or equal to 3 from the consecutive character collection
# - Subtract 2 from each instance and return the sum of all instances
# - Add the sum to the results counter

# Return the result counter


# def steps_to_strong(pass)
#   chars = pass.chars
#   result = 0

#   # max character count
#   max_character_counter = 0
#   if pass.size > 20
#     max_character_counter = pass.size - 20
#   end

#   # min character count
#   min_character_counter = 0
#   if pass.size < 6
#     min_character_counter = 6 - pass.size
#   end

#   # validation count
#   validation_counter = 0
#   ranges = [("0".."9"), ("a".."z"), ("A".."Z")]
#   ranges.each do |range|
#     chars.each do |char|
#       if range.include?(char)
#         validation_counter += 1
#         break
#       end
#     end
#   end

#   validation_counter -= 3
#   validation_counter = validation_counter.abs

#   # consecutive characters


#   consecutives = 0
#   if !consecutive_chars_coll.empty?
#     consecutive_chars_coll.each {|count| p count.divmod(3)[0]}
#     consecutives = consecutive_chars_coll.map {|count| count.divmod(3)[0]}.sum
#   end

#   # update result counter
#   result = [min_character_counter, validation_counter, consecutives].max
#   result += max_character_counter
# end


# p steps_to_strong("a") #== 5
# p steps_to_strong("aA1") #== 3
# p steps_to_strong("1337C0d3") #== 0
# p steps_to_strong("aaa123") #== 1
# p steps_to_strong("1111111111")
# p steps_to_strong("ABABABABABABABABABAB1")
# p steps_to_strong("bbaaaaaaaaaaaaaaacccccc")
