puts "How old are you?"
age = gets.chomp.to_i
decade = 10
5.times do
  age += 10
  puts "In #{decade.to_s} years you will be:"
  puts "#{age}"
  decade += 10
end