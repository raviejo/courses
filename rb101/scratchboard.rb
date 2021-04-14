
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
p delete_digit(152) == 52
p delete_digit(1001) == 101
p delete_digit(10) == 1

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

find_pairs(["1", "2", "3"]) == [["1", "2"], ["1, 3"], ["2, 3"]]

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
