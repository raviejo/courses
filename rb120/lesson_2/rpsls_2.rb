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

class Move
  include Comparable
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
    @move = start_move
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

  def spock?
    @value == "spock"
  end

  def lizard?
    @value == "lizard"
  end

  def to_s
    @value
  end

  def start_move
    if rock? then Rock.new
    elsif paper? then Paper.new
    elsif scissors? then Scissors.new
    elsif spock? then Spock.new
    elsif lizard? then Lizard.new
    end
  end

  def <=>(other_move)
    @move.rule(other_move.to_s)
  end
end

class Rock
  def rule(other_move)
    { "rock" => 0,
      "scissors" => 1,
      "paper" => -1,
      "lizard" => 1,
      "spock" => -1}[other_move]
  end
end

class Paper
  def rule(other_move)
    { "paper" => 0,
      "rock" => 1,
      "scissors" => -1,
      "lizard" => -1,
      "spock" => 1}[other_move]
  end
end

class Scissors
  def rule(other_move)
    { "scissors" => 0,
      "paper" => 1,
      "rock" => -1,
      "lizard" => 1,
      "spock" => -1}[other_move]
  end
end

class Lizard
  def rule(other_move)
    { "paper" => 1,
      "rock" => -1,
      "scissors" => -1,
      "lizard" => 0,
      "spock" => 1}[other_move]
  end
end

class Spock
  def rule(other_move)
    { "paper" => -1,
      "rock" => 1,
      "scissors" => 1,
      "lizard" => -1,
      "spock" => 0}[other_move]
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def increment_score
    @score += 1
  end

  def clear_score
    @score = 0
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
      puts "Please choose rock, paper, scissors, lizard or spock:"
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
    @personality = robot_personalities[self.name]
  end

  def r2d2
    personality = ['rock']
  end

  def hal
    personality = Move::VALUES.reject { |move| move == "paper" }
    10.times { personality << "scissors" }
    3.times { personality << "rock" }
    personality
  end

  def chappie
    personality = Move::VALUES.reject { |move| move == "lizard" }
    10.times { personality << "spock" }
    3.times { personality << "paper" }
    personality
  end

  def sonny
    personality = Move::VALUES.reject { |move| move == "scissors" }
    10.times { personality << "paper" }
    3.times { personality << "lizard" }
    personality
  end

  def number_5
    personality = ["paper"]
  end

  def robot_personalities
    { 'R2D2' => r2d2,
      'Hal' => hal,
      'Chappie' => chappie,
      'Sonny' => sonny,
      'Number 5' => number_5
    }
  end


  def choose
    self.move = Move.new(@personality.sample)
  end
end

# Game Orchestration Engine
# Contains the procedural or imperative code
class RPSGame
  attr_reader :human, :computer, :max_score, :history

  def initialize(max_score=10)
    @human = Human.new
    @computer = Computer.new
    @max_score = max_score
    @history = move_history
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
      loop do
        human.choose
        computer.choose
        display_match_details
        match_winner.increment_score unless match_winner.nil?
        display_running_total
        break if game_winner
      end
      display_winner
      display_running_total
      clear_scores
      break unless play_again?
    end
    display_goodbye_message
  end

  def display_welcome_message
    puts "Hi #{human.name}! Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_match_details
    display_moves
    display_match_winner
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def match_winner
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    end
  end

  def display_match_winner
    if match_winner.nil?
      puts "It's a tie!"
    else
      puts "#{match_winner.name} won the match!"
    end
  end

  def display_running_total
    puts "", "/-----------SCORES-----------/"
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
    puts "", "/---------------------------/"
  end

  def game_winner
    players = [human, computer]
    winner = players.select { |player| player.score == max_score }
    winner.first unless winner.empty?
  end

  def display_winner
    puts "#{game_winner.name} won the game"
  end

  def clear_scores
    players = [human, computer]
    players.each { |player| player.clear_score }
  end
end

RPSGame.new(3).play

# rock = Move.new("rock")
# paper = Move.new("paper")
# scissors = Move.new("scissors")

# binding.pry
