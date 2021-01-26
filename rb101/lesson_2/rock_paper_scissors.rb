VALID_CHOICES = %w(rock paper scissors)

def prompt(message)
  Kernel.puts("=> #{message}")
end

winner = {
  paper: 'rock',
  scissors: 'paper',
  rock: 'scissors'
}

def display_results(player, computer, winner)
  if player == computer then prompt("It's a tie!")
  elsif winner[player.intern] == computer then prompt("Player wins!")
  else prompt("Computer wins!")
  end
end

choice = ''
loop do
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

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice, winner)

  prompt('Do you want to play again? (y/n)')
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt('Thank you for playing')
