a = 5

case a 
  when 5 then puts "a is 5"
  when 6 then puts "a is 6"
  else puts "a is neither5, nor 6"
end
  
def my_range(num)
  case
    when num < 0 then p "no negative numbers please"
    when 0 <= num && num <= 50 then p "#{num} is between 0 and 50"
    when 51 <= num && num <= 100 then p "#{num} is between 51 and 100"
    else p "#{num} is above 100"
  end
end

my_range(30)
my_range(80)
my_range(150)