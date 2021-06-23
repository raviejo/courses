require 'pry'

# => Step 1
# Rock, Paper, Scissors is a two-player game where each player chooses
# one of three possible moves: rock, paper, or scissors. The chosen moves
# will then be compared to see who wins, according to the following rules:

# - rock beats scissors
# - scissors beats paper
# - paper beats rock

# If the players chose the same move, then it's a tie.

# => Step 2
# Nouns: player, move, rule
# Verbs: choose, compare

# => Step 3
# Player
# - choose
# Move
# Rule

# - compare

# => Step 4

class Rule
  def initialize(value)
    @value = value
  end

  def scissors_rule
    { "scissors" => 0,
      "paper" => 1,
      "rock" => -1 }[@value]
  end

  def rock_rule
    { "rock" => 0,
      "scissors" => 1,
      "paper" => -1 }[@value]
  end

  def paper_rule
    { "paper" => 0,
      "rock" => 1,
      "scissors" => -1 }[@value]
  end
end

class Move
  include Comparable
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == "scissors"
  end

  def rock?
    @value == "rock"
  end

  def paper?
    @value == "paper"
  end

  def to_s
    @value
  end

  def <=>(other_move)
    rule = Rule.new(other_move.to_s)
    if rock? then rule.rock_rule
    elsif paper? then rule.paper_rule
    elsif scissors? then rule.scissors_rule
    end
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    name = nil
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
    end
    self.name = name
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# # not sure where "compare" goes yet
# def compare(move1, move2)

# end

# Game Orchestration Engine
# Contains the procedural or imperative code
class RPSGame
  attr_reader :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  def display_welcome_message
    puts "Hi #{human.name}! Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
    check_moves
  end

  def check_moves
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end
end

RPSGame.new.play

# rock = Move.new("rock")
# paper = Move.new("paper")
# scissors = Move.new("scissors")

# binding.pry
