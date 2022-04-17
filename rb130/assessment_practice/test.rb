# def iterate(arr)
#   for element in arr
#     yield element
#   end
# end

# def count_zeros(arr)
#   counter = 0
#   iterate(arr) do |element|
#     counter += 1 if element == 0
#   end
#   counter
# end

# puts count_zeros([1, 2, 0, 3, 0, 4])


# def iterate(arr)
#   arr.each do |element|
#     counter += 1 if element == 0
#   end
# end

# def count_zeros(arr)
#   counter = 0
#   for element in arr
#     iterate(arr)
#   end
#   counter
# end

# puts count_zeros([1, 2, 0, 3, 0, 4])

# counter = 0

# def increment
#   counter += 1
# end

# puts increment

# require "date"

# def timer
#   raise RuntimeError unless block_given?
#   before = DateTime.now
#   10_000_000.times { yield }
#   after = DateTime.now
#   "#{after - before} seconds"
# end

# # puts timer { |x| i = x.to_s }

# timer

# def log(text1, text2)
#   puts text1
#   puts text2
# end

# log "Hello", "world", "!"

# require 'date'

# def time
#   now = DateTime.now
#   yield
#   after = DateTime.now
# puts "It took #{after - now} seconds to run your explicit block!"
# end

# time { 2 ** 50 }

# strict arity for methods
# def one(str)
#   puts str
# end

# executing the `one` method with more arguments that it expects
# one("hello", "there") # => raises an ArgumentError

# strict arity for lambdas
# one = lambda { |str| puts str }
# one.call("hello", "there") # => also raises an ArgumentError

# # lenient arity for blocks
# def pass_two
#   yield("hello", "there") # => passing two arguments to an implicit block
# end

# pass_two { |str1| puts str1 } # => does not raise any errors, even though we're expecting only one block argument

# pass_two { |str1, str2, str3| puts str3 } # => does not raise any errors, even though we're expecting three block arguments

# # lenient arity for procs
# two = proc { |str1, str2| puts str1, str2 } # => expecting two proc arguments
# two.call("hello", "there", "ricky") # => does not raise any errors, even though the proc is expecting only two arguments

# def foo
#   name = "John"
#   yield
# end

# introduction = { puts "My name is #{name}" }


# def add_one(method)
#   n = 2
#   method(n, 1)
# end

# def increment_by(num_to_increment, increment)
#   num_to_increment += increment
# end

# add_one(increment_by) # => Raises an error.
# # Ruby can't assign the method `increment_by` to the local variable `method` within `add_one`

# def add_one(num)
#   num += 1
# end


# def increment(n)
#   add_one
# end

# increment(7) # => Return the return value of `add_one` not the `add_one` method


# counter = 0

# def increment(counter)
#   counter += 1
# end

# puts increment # => undefined method `+` for nil:NilClass

# require "date"

def timer
  raise RuntimeError, "No block given" unless block_given?
  before = Time.now
  10_000_000.times { yield }
  after = Time.now
  puts "#{after - before} seconds"
end

timer #{ |x| i = x.to_s }