# Section Exercises
require "pry"


puts "1."
strings = ["laboratory", "experiment", "Pans Labyrinth", "elaborate", "polar bear"]

strings.each do |string|
  puts string if string =~ /lab/
end
puts "---------------"

puts "\n2."
def execute(&block)
  block
end

execute { puts "Hello from inside the execute method" }
