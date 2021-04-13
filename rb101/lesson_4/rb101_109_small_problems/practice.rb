produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(produce)
  result = {}
  counter = 0
  keys = produce.keys
  loop do
    break if counter == produce.size
    key = keys[counter]
    if produce[key] == 'Fruit'
      result[key] = produce[key]
    end
    counter += 1
  end
  result
end

select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}


def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    numbers[counter] = numbers[counter] * 2

    counter += 1
  end
  numbers
end


[1, 2, 3].each_with_object(Hash.new) do |num, hash|
  hash["#{num}"] = num
end