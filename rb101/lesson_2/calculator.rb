require 'pry'
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'es'

def prompt(message)
  Kernel.puts("=> #{MESSAGES[LANGUAGE][message]}")
end

# def integer?(input)
#   /^-?\d+$/.match(input)
# end

def valid_number?(input)
  Integer(input) rescue false || Float(input) rescue false
end

def operation_to_message(op)
  case op
  when '1' then "Adding"
  when '2' then 'Subtracting'
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end

prompt("welcome")

name = nil
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt("invalid_name")
  else
    break
  end
end

prompt("#{["greeting"]} #{name}!")

loop do
  number1 = nil
  loop do
    prompt("first")
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      break
    else
      prompt("invalid_num")
    end
  end
  number2 = nil
  loop do
    prompt("second")
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt("invalid_num")
    end
  end
  prompt("operation")
  operator = nil
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("invalid_op")
    end
  end
  prompt("#{operation_to_message(operator)} #{["computing"]}")
  result = case operator
           when '1' then number1.to_i() + number2.to_i()
           when '2' then number1.to_i() - number2.to_i()
           when '3' then number1.to_i() * number2.to_i()
           when '4' then number1.to_f() / number2.to_f()
           end
  prompt("#{["computed"]} #{result}")
  prompt("restart")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("goodbye")
