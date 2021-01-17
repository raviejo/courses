def mortgage(loan_amt, monthly_ir, months)
  loan_amt * (monthly_ir / (1 - (1 + monthly_ir)**(-months)))
end

puts "Welcome to the mortage calculator! Please enter your loan amount:"
loan_amt = gets.chomp.to_i
puts "What is your Annual Percentage Rate?"
monthly_ir = (gets.chomp.to_f / 100) / 12
puts "How many years is your loan (e.g. 30)?"
months = gets.chomp.to_i * 12
monthly_pmt = mortgage(loan_amt, monthly_ir, months)
puts "Your monthly payment is #{format('$%.2f', monthly_pmt)}"