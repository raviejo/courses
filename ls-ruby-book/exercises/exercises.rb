# Last Chapter Exercises
array = (1..10).to_a

puts "Exercise 1."
puts "-----------"
array.each do |num|
  puts num
end
puts "----------"

puts "\nExercise 2."
puts "----------"
array.each { |num| puts num if num > 5 }

puts "\nExercise 3."
puts "----------"
odd_numbers = array.select { |num| num % 2 != 0 }
odd_numbers.each { |num| puts num }

puts "\nExercise 4."
puts "----------"
array.append(11) # could also use array.push(11)
array.unshift(0) # could also use array.prepend(0)
puts array

puts "\nExercise 5."
puts "---------"
array.delete(11) # or could do array.pop
array.append(3) # or could also do array << 3
puts array

puts "\nExercise 6."
puts "---------"
array.uniq!
puts array

puts "\nExercise 8."
puts "---------"
my_hash = {:hello => "hello"}
puts my_hash
my_hash = {hello: "hello"}
puts my_hash

puts "\nExercise 9."
puts "---------"
h = {a:1, b:2, c:3, d:4}
puts"9.1\n"
puts h[:b]

puts"9.2\n"
h[:e] = 5
puts h

puts"9.3\n"
h.select! { |k, v| v <= 3.5 }
puts h

puts "\nExercise 10."
puts "---------"
puts "Example of hash with array values"
person_a = { :ricky => ["Ricardo", 25, 163, "hazel"] } # Name, age, weight, eye color
puts person_a
puts "\n"

puts "Example of array with hash values"
people = [person_a]
puts people

puts "\nExercise 11."
puts "---------"
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

# Expected output:
#  {
#    "Joe Smith"=>{:email=>"joe@email.com", :address=>"123 Main st.", :phone=>"555-123-4567"},
#    "Sally Johnson"=>{:email=>"sally@email.com", :address=>"404 Not Found Dr.",  :phone=>"123-234-3454"}
#  }

def to_hash(array)
  {email: array[0], address: array[1], phone: array[2]}
end

contacts["Joe Smith"] = to_hash(contact_data[0])
contacts["Sally Johnson"] = to_hash(contact_data[1])

puts contacts

puts "\nExercise 12."
puts "---------"
puts "Joe's email is #{contacts["Joe Smith"][:email]}"
puts "\nSally's phone number is #{contacts["Sally Johnson"][:phone]}"

puts "\nExercise 13."
puts "---------"
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if { |word| word.start_with?('s') }
puts arr
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if { |word| word.start_with?('s', 'w') }
puts "\n"
puts arr

puts "\nExercise 14."
puts "---------"
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

a.map! { |word| word.split.flatten }
puts a

puts "\nExercise 16."
puts "---------"
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

# Expected output:
#  {
#    "Joe Smith"=>{:email=>"joe@email.com", :address=>"123 Main st.", :phone=>"555-123-4567"},
#    "Sally Johnson"=>{:email=>"sally@email.com", :address=>"404 Not Found Dr.",  :phone=>"123-234-3454"}
#  }

contacts.each do |name, info|
  contact_info = contact_data.shift
  keys = [:email, :address, :phone]
  data = {}
  keys.each { |key| data[key] = contact_info.shift }
  contacts[name] = data
end
puts contacts

