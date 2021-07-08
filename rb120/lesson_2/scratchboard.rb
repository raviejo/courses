def divisible_elts(ary, proc)
  ary.each do |elt|
    proc.call(elt)
  end
end

divisible_by_three = Proc.new do |number|
  puts "#{number} is divisible by three" if number % 3 == 0
end

ary = (1..100).to_a

divisible_elts(ary, divisible_by_three)
