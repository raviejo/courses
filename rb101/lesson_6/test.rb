# You are given array of integers, your task will be to count all pairs in that array and return their count.

# Notes:

# Array can be empty or contain only one value; in this case return 0
# If there are more pairs of a certain number, count each pair only once. E.g.: for [0, 0, 0, 0] the return value is 2 (= 2 pairs of 0s)
# Random tests: maximum array length is 1000, range of values in array is between 0 and 1000
# Examples
# [1, 2, 5, 6, 5, 2]  -->  2
# ...because there are 2 pairs: 2 and 5

# [1, 2, 2, 20, 6, 20, 2, 6, 2]  -->  4
# ...because there are 4 pairs: 2, 20, 6 and 2 (again)

# Algo
# Iterate through each element of the given array
# Create a dictionary
#  - Make each element a key in the dictionary
#  - Make the value for that key the count of pairs for the number
# Return the keys in which the values are greater than 0

def num_counts(arr)
  result = {}
  arr.each do |num|
    if result.include?(num)
      result[num] += 1
    else
      result[num] = 1
    end
  end
  result
end

def pair_counts(arr)
  num_counts = num_counts(arr)
  pair_counts = {}
  num_counts.each do |num, count|
    pair_counts[num] = count.div(2)
  end
  pair_counts
end

def pairs(arr)
  pair_counts = pair_counts(arr)
  pair_counts.select do |num, pair_count|
    pair_count > 0
  end.keys.count
end

arr = [1, 2, 2, 20, 6, 20, 2, 6, 2]

puts pairs(arr)

# Iterate through all elements in the array
# Keep track of the index of each element
# Call the element at the current index `first`
# Call every other element thereafter `rest`
# Create a placeholder array called `pairs`
# Iterate over `rest`, call each element `rest_elt`
# Add `first` and `rest_elt` to a placeholder array called `rest_pairs`
# Add `rest_pairs` to `pairs`
# Select the pairs that add to more than 3

arr = [1, 2, 3]

def find_pairs(arr)
  pairs = []
  arr.size.times do |idx|
    first = arr[idx]
    rest = arr[idx+1..-1]
    break if rest.nil?
    rest.each do |rest_elt|
      pairs << [first, rest_elt]
    end
  end
  pairs
end

p find_pairs(arr)

# Write a method that takes a string, and then returns a hash that contains 3 entries: one represents the percentage of characters 
# in the string that are lowercase letters, one the percentage of characters that are uppercase letters, and one the 
# percentage of characters that are neither.

# Count the letters on the string, call it `size`
# Find the percentages

def letter_percentages(str)
  percentages = {}
  {lowercase: 'a-z', uppercase: 'A-Z', neither: '^A-za-z'}.each do |key, regex|
    percentages[key] = str.count(regex).fdiv(str.size) * 100
  end
  percentages
end

p letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
p letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
p letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }

