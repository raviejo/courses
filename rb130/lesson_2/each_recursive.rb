def my_each(ary, counter = 0, &block)
  if counter < ary.size
    block.call(ary[counter])
    my_each(ary, counter + 1, &block)
  end
end

ary = [1, 2, 3, 4]
my_each(ary) do |num|
  puts num
end
