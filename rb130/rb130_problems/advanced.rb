# 1. Enumerable
# factorial = Enumerator.new do |yielder|
#   accumulator = 1
#   number = 0
#   loop do
#     accumulator = number.zero? ? 1 : accumulator * number
#     yielder << accumulator
#     number += 1
#   end
# end


# # External Iterators
# 6.times { |number| puts "#{number}! == #{factorial.next}" }
# puts "======================================="
# 6.times { |number| puts "#{number}! == #{factorial.next}" }
# puts "======================================="
# factorial.rewind
# 6.times { |number| puts "#{number}! == #{factorial.next}" }
# puts "======================================="

# # Internal Iterators
# factorial.each_with_index do |value, number|
#   puts "#{number}! == #{value}"
#   break if number >= 5
# end

# 2. Exploring Procs, Lambda, and Blocks: Definition and Arity
# Group 1
# my_proc = proc { |thing| puts "This is a #{thing}." }
# puts my_proc
# puts my_proc.class
# my_proc.call
# my_proc.call('cat')

# Procs have lenient arity, meaning that it doesn't care about the nubmer of arguments that it gets
# It will assign `nil` to any extra arguments that it receives.
# Line 33 will evaluate `nil` as an empty string.

# Group 2
# my_lambda = lambda { |thing| puts "This is a #{thing}." }
# my_second_lambda = -> (thing) { puts "This is a #{thing}." }
# puts my_lambda
# puts my_second_lambda
# puts my_lambda.class
# my_lambda.call('dog')
# my_lambda.call
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }

# Lambdas have strict arity, meaning that it cares about the number of arguments that it gets

# Group 3
# def block_method_1(animal)
#   yield
# end

# block_method_1('seal') { |seal| puts "This is a #{seal}."}
# block_method_1('seal')

# This will raise a LocalJumpError because `block_method_1` is expecting a block when no block was given
# Implicit blocks can be ignored by checking if a block was passed to the method with `block_given?`

# Group 4
# def block_method_2(animal)
#   yield(animal)
# end

# block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
# block_method_2('turtle') do |turtle, seal|
#   puts "This is a #{turtle} and a #{seal}."
# end
# block_method_2('turtle') { puts "This is a #{animal}."}

# Calling yield will create a Simple Proc object, which doesn't care about the number
# or arguments that it gets, so it will assign nil to seal and the result will be an empty string.
# Yielded arguments must be stored to a block local variable by using a block parameter,
# or else they cannot be refereced from within the block