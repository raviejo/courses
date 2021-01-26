VALID_CHOICES = %w(rock paper scissors lizard spock)

def prompt(message)
  Kernel.puts("=> #{message}")
end

rules_table = {
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  rock: ['scissors', 'lizard'],
  lizard: ['spock', 'paper'],
  spock: ['scissors', 'rock']
}

def display_results(player, computer, rules_table)
  if player == computer then prompt("It's a tie!")
  elsif rules_table[player.intern].include?(computer) then prompt("Player wins!")
  else prompt("Computer wins!")
  end
end

def update_score(player, computer, rules_table, scores)
  if player == computer then scores
  elsif rules_table[player.intern].include?(computer) then scores[:player] += 1
  else scores[:computer] += 1
  end
end

def reset_score(scores)
  scores[:player] = 0
  scores[:computer] = 0
end

def display_score(scores)
  scores.each {|k, v| prompt("#{k.capitalize} score: #{v}")}
end

scores = {
  player: 0,
  computer: 0,
}

player_input = nil
player_choice = nil  
loop do
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    player_input = Kernel.gets().chomp()
    player_choice = VALID_CHOICES.select {|choice| choice.start_with?(player_input)}.first

    if player_input == "s"
      prompt("Choose 'sc' for scissors or 'sp' for spock")
    elsif VALID_CHOICES.include?(player_choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{player_choice}; Computer chose: #{computer_choice}")

  display_results(player_choice, computer_choice, rules_table)
  update_score(player_choice, computer_choice, rules_table, scores)
  display_score(scores)
  winner = scores.select { |k, v| k if v == 5 }.keys.first.to_s

  if scores.has_value?(5)
    reset_score(scores)
    prompt("#{winner} is the winner")
    prompt("Do you want to keep playing?")
    answer = Kernel.gets().chomp()
    break if answer.downcase.start_with?('n')
  end

end
prompt('Thank you for playing')
