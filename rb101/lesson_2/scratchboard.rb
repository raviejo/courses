### Displaying Output
def say_greeting(name)
  puts "Hi #{name}!"
end

### Passing control from method to block
def pass_control()
  yield
  name = "ricky"
end

# pass_control { puts name } # => Error Undefined Local Variable

name_two = "ricky"

def pass_control_two(str)
  yield
end

pass_control_two('hello') { puts name_two }

# ZeroDivisionError
def divide(number, divisor)
  begin 
    puts number / divisor
  rescue ZeroDivisionError => e
    puts e.message
  end
end

divide(4, 2) #=> 2
divide(4, 0) #=> ZeroDivisionError 
divide(4, 1) #=> 4
    
#Before
johhny = "Johnny Gonzalez is my friend"

#Expected output
# => jOHNNY gONZALEZ IS MY FRIEND


#Before
hash_one = {"barbas" => "schnauzer", "milo" => "schnauzer"}
hash_two = {"simon" => "schnauzer", "blue" => "blue heeler"}

# Expected
puts hash_one # => {"barbas" => "schnauzer", "milo" => "schnauzer", "simon" => "schnauzer", "blue" => "blue heeler"


# Girlfriend's Name
arr = "My girlfriend's name is Maria Alejandra"


# Title
title = "Mako's incredible escape"

# Expected Output
# => "             Mako's incredible escape             "