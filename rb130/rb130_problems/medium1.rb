# 1. Listening Device
# Below we have a listening device. It lets us record something that is said and store it for later use. In general, this is how the device should be used:

# Listen for something, and if anything is said, record it for later use. If nothing is said, then do not record anything.

class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    record(yield) if block_given?
  end

  def play
    puts @recordings.last
  end
end

# Anything that is said is retrieved by this listening device via a block. If nothing is said, then no block will be passed in. The listening device can also
# output the most recent recording using a Device#play method.

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
# listener.play # Outputs "Hello World!"

# Finish the above program so that the specifications listed above are met.

# 2. Text Analyzer - Sandwich Code
# Fill out the rest of the Ruby code below so it prints output like that shown in "Sample Output." You should read the text from a simple text file that you provide.
# (We also supply some example text below, but try the program with your text as well.)

# This question requires that you read a simple text file. Try searching the Web for information on how to do this, and also take a look at the File class in the Ruby documentation.
# If you can't figure it out on your own, don't worry: just put the data directly into your program; an Array with one element per line would be ideal.

# Read the text file in the #process method and pass the text to the block provided in each call. Everything you need to work on is either part of the #process method or part of
# the blocks. You need no other additions or changes.

# The text you use does not have to produce the same numbers as the sample output but should have the indicated format.

class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r')
    yield(file.read)
    file.close
  end
end

analyzer = TextAnalyzer.new
# analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
# analyzer.process { |text| puts "#{text.split("\n").count} lines" }
# analyzer.process { |text| puts "#{text.split.count} words" }

# p File.read('sample_text.txt').split(/\n/)

# 3. Passing Parameters Part 1
# Modify the method below so that the display/output of items is moved to a block, and its implementation is left up to the user of the gather method.
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Nice selection of food we have gathered!"
end

# gather(items) { |produce| puts produce.join }

# 4. Passing Parameters Part 2
# Ruby gives us a lot of flexibility when assigning arrays to variables. If we want to assign the entire array to a single variable, we can do that:
# birds = %w(raven finch hawk eagle)
# p birds # => ['raven','finch','hawk','eagle']

# If we want to assign every element to a separate variable, we can do that too:
# raven, finch, hawk, eagle = %w(raven finch hawk eagle)
# p raven # => 'raven'
# p finch # => 'finch'
# p hawk # => 'hawk'
# p eagle # => 'eagle'

# Suppose we want to organize our array contents into groups, where variables represent category names. Can we do that without extracting items directly
# from the array based on their indices?

# We can use the splat operator(*) to do something like this:
# raven, finch, *raptors = %w(raven finch hawk eagle)
# p raven # => 'raven'
# p finch # => 'finch'
# p raptors  # => ['hawk','eagle']

# Based on the examples shown above, write a method that takes an array as an argument. The method should yield the contents of the array to a block, which
# should assign your block variables in such a way that it ignores the first two elements, and groups all remaining elements as a raptors array.

def assign(ary)
  yield(ary)
end

# assign(%w(raven finch hawk eagle)) do |_, _, *raptors|
#   puts "Raptors: #{raptors.join(", ")}"
# end

# 5. Passing Parameters Part 3
# Given this code:

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

# Fill out the following method calls for gather so that they produce the corresponding output shown in numbers 1-4 listed below:

# 1)
# gather(items) do |*multiple,single|
#   puts multiple.join(', ')
#   puts single
# end

# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!

# 2)
# gather(items) do |single,*double,second_single|
#   puts single
#   puts double.join(', ')
#   puts second_single
# end

# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!

# 3)
# gather(items) do |single,*multiple|
#   puts single
#   puts multiple.join(', ')
# end

# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!

# 4)
# gather(items) do |one,two,three,four|
#   puts "#{[one, two, three].join(', ')} and #{four}"
# end

# Let's start gathering food.
# apples, corn, cabbage, and wheat
# We've finished gathering!

# 6. Method to Proc
def convert_to_base_8(n)
  n.to_s(8).to_i # replace these two method calls
end

# The correct type of argument must be used below
base8_proc = method(:convert_to_base_8).to_proc

# We'll need a Proc object to make this code work. Replace `a_proc`
# with the correct object
# p [8, 10, 12, 14, 16, 33].map(&base8_proc)

# 7. Bubble sort

# Your task in this assignment is to modify #bubble_sort! so it takes an optional block that determines which of two consecutive
# elements will appear first in the results.
# If you still have a copy of your #bubble_sort! method, you may use that method as the basis for this exercise. Otherwise, you
# can use the above solution.
def bubble_sort!(arr)
  arr_len = arr.size - 1
  loop do
    sorted = true
    1.upto(arr_len) do |n|
      if block_given?
        next if yield(arr[n-1], arr[n])
      else
        next if arr[n] > arr[n-1]
      end
      arr[n-1], arr[n] = arr[n], arr[n-1]
      sorted = false
    end
    break if sorted
    arr_len -= 1
  end
  nil
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

def bubble_sort!(arr)
  arr_len = arr.size - 1
  loop do
    sorted = true
    1.upto(arr_len) do |n|
      next if block_given? && yield(arr[n]) > yield(arr[n-1])
      arr[n-1], arr[n] = arr[n], arr[n-1]
      sorted = false
    end
    break if sorted
    arr_len -= 1
  end
  nil
end

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |value| value.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)