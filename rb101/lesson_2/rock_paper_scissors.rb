VALID_CHOICES = %w(rock paper scissors)

def prompt(message)
  Kernel.puts("=> #{message}")
end


choice = ''
loop do
  prompt("Choose one: #{VALID_CHOICES.join(', ')}")
  choice = Kernel.gets().chomp()

  if VALID_CHOICES.include?(choice)
    break
  else
    prompt("That's not a valid choice")
  end
end

computer_choice = VALID_CHOICES.sample

Kernel.puts("You cohse: #{choice}; Computer chose: #{computer_choice}")

if (choice == 'rock' && computer_choice == 'scissors') ||
    (choice == 'paper' && computer_choice == 'rock') ||
    (choice == 'scissors' && computer_choice == 'paper')
  prompt('You won!')
elsif (choice == 'rock' && computer_choice == 'paper') ||
  (choice == 'paper' && computer_choice == 'scissors') ||
  (choice == 'scissors' && computer_choice == 'rock')
  prompt("Computer won!")
else
  prompt("It's a tie!")
end
