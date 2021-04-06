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