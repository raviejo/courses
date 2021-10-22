# 1. From-To-Step Sequence Generator
# The Range#step method lets you iterate over a range of values where each value in the iteration is the previous value
# plus a "step" value. It returns the original range.

# Write a method that does the same thing as Range#step, but does not operate on a range. Instead, your method should take
# 3 arguments: the starting value, the ending value, and the step value to be applied to each iteration. Your method should
# also take a block to which it will yield (or call) successive iteration values.

def step(from, to, step)
  loop do
    yield(from)
    break if from >= to
    from += step
  end
end

# step(1, 10, 3) { |value| puts "value = #{value}" }

# 2. Zipper
# The Array#zip method takes two arrays, and combines them into a single array in which each element is a two-element array where
# the first element is a value from one array, and the second element is a value from the second array, in order. For example:

# Copy Code
# [1, 2, 3].zip([4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]
# Write your own version of zip that does the same type of operation. It should take two Arrays as arguments, and return a new
# Array (the original Arrays should not be changed). Do not use the built-in Array#zip method. You may assume that both input
# arrays have the same number of elements.

def zip(ary_one, ary_two)
  result = []
  ary_one.size.times do |idx|
    result << [ary_one[idx], ary_two[idx]]
  end
  result
end

# p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

# 3. Map
def map(collection, idx = 0, result = [], &block)
  return result if idx == collection.size || collection.empty?
  result << block.call(collection[idx])
  map(collection, idx + 1, result, &block)
end

# p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
# p map([]) { |value| true } == []
# p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
# p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
# p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]

# 4. Count
def count(*arg)
  counter = 0
  arg.each { |elt| counter += 1 if yield(elt) }
  counter
end

# p count(1, 3, 6) { |value| value.odd? } == 2
# p count(1, 3, 6) { |value| value.even? } == 1
# p count(1, 3, 6) { |value| value > 6 } == 0
# p count(1, 3, 6) { |value| true } == 3
# p count() { |value| true } == 0
# p count(1, 3, 6) { |value| value - 6 } == 3

# 5. drop while
def drop_while(ary)
  ary.each.with_object([]) do |elt, result|
    return ary[ary.index(elt)..-1] unless yield(elt)
  end
end

# p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
# p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
# p drop_while([1, 3, 5, 6]) { |value| true } == []
# p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
# p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
# p drop_while([]) { |value| true } == []

# 6. each with index
def each_with_index(ary)
  idx = 0
  ary.each { |elt| yield(elt, idx); idx += 1 }
end

# result = each_with_index([1, 3, 6]) do |value, index|
#   puts "#{index} -> #{value**index}"
# end

# puts result == [1, 3, 6]

# 7. each with object
def each_with_object(ary, obj)
  ary.each { |elt| yield(elt, obj)}
  obj
end

# result = each_with_object([1, 3, 5], []) do |value, list|
#   list << value**2
# end
# p result == [1, 9, 25]

# result = each_with_object([1, 3, 5], []) do |value, list|
#   list << (1..value).to_a
# end
# p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

# result = each_with_object([1, 3, 5], {}) do |value, hash|
#   hash[value] = value**2
# end
# p result == { 1 => 1, 3 => 9, 5 => 25 }

# result = each_with_object([], {}) do |value, hash|
#   hash[value] = value * 2
# end
# p result == {}

# 8. max by
def max_by(ary)
  max_idx = 0
  max = nil
  ary.each_with_index do |elt, idx|
    val = yield(elt)
    if max.nil?
      max = val
    elsif val > max
      max = val
      max_idx = idx
    end
  end
  ary[max_idx]
end

# p max_by([1, 5, 3]) { |value| value + 2 } == 5
# p max_by([1, 5, 3]) { |value| 9 - value } == 1
# p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
# p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
# p max_by([-7]) { |value| value * 3 } == -7
# p max_by([]) { |value| value + 5 } == nil

# 9. Each cons
def each_cons(ary)
  ary.each_with_index do |elt, idx|
    yield(elt, ary[idx+1]) if idx+1 < ary.size
  end
  nil
end

# hash = {}
# result = each_cons([1, 3, 6, 10]) do |value1, value2|
#   hash[value1] = value2
# end
# p result == nil
# p hash == { 1 => 3, 3 => 6, 6 => 10 }

# hash = {}
# result = each_cons([]) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == {}
# p result == nil

# hash = {}
# result = each_cons(['a', 'b']) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == {'a' => 'b'}
# p result == nil

# 10. Each cons 2
def each_cons(ary, n)
  ary.each_with_index do |elt, idx|
    if idx+n <= ary.size
      args = []
      n.times { |n| args << ary[idx+n] }
      yield(*args)
    else
      break
    end
  end
  nil
end

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
p hash == {}