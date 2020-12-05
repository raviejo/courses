a = [1, 2, 3].each_with_index { |val, idx| p "Hello #{idx}. Your value is #{val}" }
p "It's as easy as #{a}"

p "map example"
a.map { |x| puts x**2}

p "each example"
a.each { |x| puts x**2}