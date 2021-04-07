## Easy Problem Just For Fun

def anagrams(words)
  anagrams = []
  words.each do |word|
    anagrams << words.select {|anagram| word.count(anagram) == word.size}
  end
  anagrams.each(&:sort).uniq!
  anagrams.each {|loa| p loa}
end

### Advanced 1
## 1. Madlibs Revisited
# Problem:
# Let's build another program using madlibs. We made a program like this in the easy exercises. This time, the requirements are a bit different.
# Make a madlibs program that reads in some text from a text file that you have created, and then plugs in a selection of randomized nouns, verbs,
# adjectives, and adverbs into that text and prints it. You can build your lists of nouns, verbs, adjectives, and adverbs directly into your
# program, but the text data should come from a file or other external source. Your program should read this text, and for each line, it should
# place random words of the appropriate types into the text, and print the result.
# The challenge of this program isn't about writing your program; it's about choosing how to represent your data. Choose the right way to structure
# your data, and this problem becomes a whole lot easier. This is why we don't show you what the input data looks like; the input representation
# is your responsibility.

# Example output:
# The sleepy brown cat noisily
# licks the sleepy yellow
# dog, who lazily licks his
# tail and looks around.

# Example text data:
# The %{adjective} brown %{noun} %{adverb}
# %{verb} the %{adjective} yellow
# %{noun}, who %{adverb} %{verb} his
# %{noun} and looks around.

# Example replacement words
# adjectives: quick lazy sleepy ugly
# nouns: fox dog head leg
# verbs: jumps lifts bites licks
# adverb: easily lazily noisily excitedly

file_path = "/home/ec2-user/environment/courses/rb101/lesson_4/rb101_109_small_problems/text_data.txt"

def madlibs(file_path)
  file_data = File.readlines(file_path).map(&:chomp)
  adjectives = %w(quick lazy sleepy ugly)
  nouns = %w(fox dog head leg)
  verbs = %w(jumps lifts bites licks)
  adverbs = %w(easily lazily noisily excitedly)
  file_data.each do |line|
    line.gsub!("%{adjective}", adjectives.sample)
    line.gsub!("%{noun}", nouns.sample)
    line.gsub!("%{adverb}", adverbs.sample)
    line.gsub!("%{verb}", verbs.sample)
    puts line
  end
end

ADJECTIVES = %w(quick lazy sleepy ugly)
NOUNS = %w(fox dog head leg)
VERBS = %w(jumps lifts bites licks)
ADVERBS = %w(easily lazily noisily excitedly)

def madlibs(file)
  File.open(file) do |file|
    file.each do |line|
      puts format(line, noun: NOUNS.sample,
                        adverb: ADVERBS.sample,
                        verb: VERBS.sample,
                        adjective: ADJECTIVES.sample)
    end
  end
end


## 2. Seeing Stars
# Problem:
# Write a method that displays an 8-pointed star in an nxn grid, where n is an odd integer that is supplied as an argument to the method. The smallest such star you need to handle is a 7x7 grid.
# Examples:
# star(7)

# *  *  *
# * * *
#   ***
# *******
#   ***
# * * *
# *  *  *

# star(9)

# *   *   *
# *  *  *
#   * * *
#   ***
# *********
#   ***
#   * * *
# *  *  *
# *   *   *

# Data Structure:
# Odd integers

# Algorithm:
# save each line to a variable
# first line: space between stars is (n - 3) / 2
# second line until 4th line:
# subtract 1 from space between until space equals zero

def star(num)
  space = (num - 3) / 2
  lines = []
  while space >= 1 do
    spaces = " " * space
    line = Array.new(3, "*").join(spaces)
    lines << line
    space -= 1
  end
  lines.each {|line| puts line.center(num)}
  puts "*" * num
  lines.reverse.each {|line| puts line.center(num)}
end

## 3. Transpose 3x3
# Problem:
# A 3 x 3 matrix can be represented by an Array of Arrays in which the main Array and all of the sub-Arrays has 3 elements. For example:
# 1  5  8
# 4  7  2
# 3  9  6
# can be described by the Array of Arrays:
# matrix = [
#   [1, 5, 8],
#   [4, 7, 2],
#   [3, 9, 6]
# ]
# An Array of Arrays is sometimes called nested arrays because each of the inner Arrays is nested inside an outer Array.
# To access an element in matrix, you use Array#[] with both the row index and column index. So, in this case, matrix[0][2] is 8, and matrix[2][1] is 9. An entire row in
# the matrix can be referenced by just using one index: matrix[1] is the row (an Array) [4, 7, 2]. Unfortunately, there's no convenient notation for accessing an entire column.
# The transpose of a 3 x 3 matrix is the matrix that results from exchanging the columns and rows of the original matrix. For example, the transposition of the array shown above is:
# Copy Code
# 1  4  3
# 5  7  9
# 8  2  6
# Write a method that takes a 3 x 3 matrix in Array of Arrays format and returns the transpose of the original matrix. Note that there is a Array#transpose method that does
# this -- you may not use it for this exercise. You also are not allowed to use the Matrix class from the standard library. Your task is to do this yourself.
# Take care not to modify the original matrix: you must produce a new matrix and leave the original matrix unchanged.

# Examples:
matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]
# matrix = [
#   [1, 4, 3],
#   [5, 7, 9],
#   [8, 2, 6]
# ]

# new_matrix = transpose(matrix)

# p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
# p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]

def transpose(matrix)
  new_matrix = []
  3.times do |col_num|
   row = []
   3.times { |row_num| row << matrix[row_num][col_num] }
   new_matrix << row
  end
 new_matrix
end

def transpose!(matrix)
  3.times do |col_num|
   row = []
   3.times { |row_num| row << matrix[row_num][col_num] }
   matrix << row
  end
 matrix.slice!(0,3)
 nil
end

# matrix[0][1], matrix[1][0] = matrix[1][0], matrix[0][1]
# matrix[0][2], matrix[2][0] = matrix[2][0], matrix[0][2]
# matrix[1][2], matrix[2][1] = matrix[2][1], matrix[1][2]
    
def transpose!(matrix)
  (0..2).each do |n|
    row = [n - 1, 0].max
    col = [n + 1, 2].min
    matrix[row][col], matrix[col][row] = matrix[col][row], matrix[row][col]
  end
  nil
end


## 4. Transpose MxN
# Problem:
# In the previous exercise, you wrote a method to transpose a 3 x 3 matrix as represented by a ruby Array of Arrays.
# Matrix transposes aren't limited to 3 x 3 matrices, or even square matrices. Any matrix can be transposed by simply switching columns with rows.
# Modify your transpose method from the previous exercise so it works with any matrix with at least 1 row and 1 column.
# Examples:
transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
transpose([[1]]) == [[1]]

def transpose(matrix)
  new_matrix = []
  iterations = matrix.map(&:size).max
  iterations.times do |i|
    row = []
    matrix.size.times do |n|
      row << matrix[n][i]
    end
    new_matrix << row
  end
  new_matrix
end

## 5. Rotating Matrices
# As we saw in the previous exercises, a matrix can be represented in ruby by an Array of Arrays. For example:
# 1  5  8
# 4  7  2
# 3  9  6
# can be described by the Array of Arrays:
# matrix = [
#   [1, 5, 8],
#   [4, 7, 2],
#   [3, 9, 6]
# ]
# A 90-degree rotation of a matrix produces a new matrix in which each side of the matrix is rotated clockwise by
# 90 degrees. For example, the 90-degree rotation of the matrix shown above is:
# 3  4  1
# 9  7  5
# 6  2  8
# A 90 degree rotation of a non-square matrix is similar. For example, the rotation of:
# 3  4  1
# 9  7  5
# is:
# 9  3
# 7  4
# 5  1
# Write a method that takes an arbitrary matrix and rotates it 90 degrees clockwise as shown above.
# Examples:
# matrix1 = [
#   [1, 5, 8],
#   [4, 7, 2],
#   [3, 9, 6]
# ]

# matrix2 = [
#   [3, 7, 4, 2],
#   [5, 1, 0, 8]
# ]

# new_matrix1 = rotate90(matrix1)
# new_matrix2 = rotate90(matrix2)
# new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

# p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
# p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
# p new_matrix3 == matrix2

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix = [
  [3, 9, 6],
  [4, 7, 2],
  [1, 5, 8]
]

def rotate90(matrix)
  new_matrix = []
  iterations = matrix.map(&:size).max
  iterations.times do |i|
    row = []
    matrix.size.times do |n|
      row << matrix.reverse[n][i]
    end
    new_matrix << row
  end
  new_matrix
end

# Further Exploration
def rotate_matrix(matrix, degrees)
  rotations = degrees / 90
  new_matrix = matrix
  rotations.times {new_matrix = rotate90(new_matrix)}
  new_matrix
end

## 6. Fix the Bug
# The following code:

# def my_method(array)
#   if array.empty?
#     []
#   elsif
#     array.map do |value|
#       value * value
#     end
#   else
#     [7 * array.first]
#   end
# end

# p my_method([])
# p my_method([3])
# p my_method([3, 4])
# p my_method([5, 6, 7])

# is expected to print:
# []
# [21]
# [9, 16]
# [25, 36, 49]
# However, it does not. Obviously, there is a bug. Find and fix the bug, then explain why the buggy program printed the results it did.

def my_method(array)
  if array.empty?
    []
  elsif array.size > 1
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

p my_method([])         # => [] 
p my_method([3])        # => [21]
p my_method([3, 4])     # => [9, 16]
p my_method([5, 6, 7])  # => [25, 36, 49]

## 7. Merge Sorted Lists
# Problem:
# Write a method that takes two sorted Arrays as arguments, and returns a new Array that contains all elements from both arguments in sorted order.
# You may not provide any solution that requires you to sort the result array. You must build the result array one element at a time in the proper order.
# Your solution should not mutate the input arrays.
# Examples:
merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
merge([], [1, 4, 5]) == [1, 4, 5]
merge([1, 4, 5], []) == [1, 4, 5]

# Problem
# - input: two integer arrays
# - output: one integer array
# - input arrays are sorted lowest to highest
# - output array needs to be sorted lowest to highest
# - output must include all elements of both arrays, even duplicates

# Examples
# merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
# merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
# merge([], [1, 4, 5]) == [1, 4, 5]
# merge([1, 4, 5], []) == [1, 4, 5]

# - input arrays can be of different sizes
# - if the first input array is empty, the output should be the second output array, and vice versa

# Data Structure
# - arrays
# - integers
# - booleans (comparison)

# merge([1, 4, 5], [2, 2]) == [1, 1, 4, 5]

# merge([2, 2], [1, 1, 3])

# - create an empty results array
# - look at each element of ary1
#   - if results is empty
#     - add the first element to results array
#   - else
#     - look at each element of ary2 in reverse order
#       - add each element before results unless it is larger than the first element
#       - if it is larger add the ary1 element and the ary2 element to the end of results

def merge(ary1, ary2)
  results = []
  ary2_idx = 0
  return ary2 if ary1.empty?
  ary1.each do |ary1_elt|
    ary2.size.times do |idx|
      next if idx != ary2_idx
      if ary2[idx] < ary1_elt
        results << ary2[idx]
        ary2_idx = idx + 1
      end
    end
    results << ary1_elt
  end
  results
end

merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
merge([], [1, 4, 5]) == [1, 4, 5]
merge([1, 4, 5], []) == [1, 4, 5]

def merge(ary1, ary2)
  results = []
  idx_start = 0
  return ary2 if ary1.empty?
  ary1.each do |ary1_elt|
    ary2[idx_start..-1].each do |ary2_elt|
      if ary2_elt < ary1_elt
        results << ary2_elt
        idx_start += 1
      end
    end
    results << ary1_elt
  end
  results
end

## 8. Merge Sort
# Sort an array of passed in values using merge sort. You can assume that this array may contain only one type of data. And that data may be either all numbers or all strings.
# Merge sort is a recursive sorting algorithm that works by breaking down the array elements into nested sub-arrays, then recombining those nested sub-arrays in sorted order.
# It is best shown by example. For instance, let's merge sort the array [9,5,7,1]. Breaking this down into nested sub-arrays, we get:
# [9, 5, 7, 1] ->
# [[9, 5], [7, 1]] ->
# [[[9], [5]], [[7], [1]]]

# We then work our way back to a flat array by merging each pair of nested sub-arrays:
# [[[9], [5]], [[7], [1]]] ->
# [[5, 9], [1, 7]] ->
# [1, 5, 7, 9]

# Examples:
# merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
# merge_sort([5, 3]) == [3, 5]
# merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
# merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
# merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]

[6, 2, 7, 1, 4]
[ [6, 2, 7], [1, 4] ]
[ [[6, 2], [7]], [[1], [4]] ]
[ [[[6], [2]], [7]], [[1], [4]] ]
[ [[2, 6], [7]], [[1, 4]] ]
[ [2, 6, 7], [1, 4] ]

def merge(ary1, ary2)
  results = []
  idx_start = 0
  return ary2 if ary1.empty?
  ary1.each do |ary1_elt|
    ary2[idx_start..-1].each do |ary2_elt|
      if ary2_elt < ary1_elt
        results << ary2_elt
        idx_start += 1
      end
    end
    results << ary1_elt
  end
  results
end

# - find the midpoint of the array (round down)
# - split the array into two arrays, a and b, nested in an new array
# - keep splitting a and b until there's only one item left in each
# - call merge on a and b

def merge_sort(ary)
  result = []
  midpoint = (ary.size / 2).round
  if ary.size == 1
    ary
  else
    result = [[ary[0...midpoint], ary[midpoint..-1]]]
    merge_sort(ary1)
  result
end
