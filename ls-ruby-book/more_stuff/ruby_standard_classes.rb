# Ruby Standard Classes

# Using the Math Class
puts "The constant of pi is #{Math::PI}"
puts "The square root of 2 is #{Math.sqrt(2)}"

# Using the Time Class
day = "Friday" if Time.new(1992, 12, 25).friday? # using the .friday? Time Class method 
puts "Ricky was born on #{day} December 25, 1992!"