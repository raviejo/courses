require 'pry'
# Short desription:
# Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
# marking a square. The first player to mark 3 squares in a row wins.

# Extract nouns and verbs:
# Nouns: board, player, square, grid
# Verbs: play, mark

# Associate and organize verbs and nouns
# Board
# Player
# - play
# - mark
# Square
# Grid

# Spike Code:
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals


  def initialize
    # we need a way to model the 3x3 grid. Maybe "squares"?
    # What data structure should we use?
    # - array / hash of Square objects?
    # - array / hash of strings or integers?
    @squares = {}
    reset
  end

  def get_suqare_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  # return the winning marker on nil
  def detect_winner
    WINNING_LINES.each do |line|
      human_won = line.all? { |key| @squares[key].marker == TTTGame::HUMAN_MARKER }
      computer_won = line.all? { |key| @squares[key].marker == TTTGame::COMPUTER_MARKER }

      if human_won
        return TTTGame::HUMAN_MARKER
      elsif computer_won
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    # we need to know if the square is marked or not
    # maybe a status
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    # we need a "marker" to keep track of the player's symbol ('X' or 'O')
    # we need to know whether the player is a human or the computer
    @marker = marker
  end
end

# We need an Orchestration Engine
class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe! Goodbye!"
  end

  def display_board(clear = true)
    system("clear") if clear
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    puts "       |       |"
    puts "   #{board.get_suqare_at(1)}   |   #{board.get_suqare_at(2)}   |   #{board.get_suqare_at(3)}"
    puts "       |       |"
    puts "-------+-------+------"
    puts "       |       |"
    puts "   #{board.get_suqare_at(4)}   |   #{board.get_suqare_at(5)}   |   #{board.get_suqare_at(6)}"
    puts "       |       |"
    puts "-------+-------+------"
    puts "       |       |"
    puts "   #{board.get_suqare_at(7)}   |   #{board.get_suqare_at(8)}   |   #{board.get_suqare_at(9)}"
    puts "       |       |"
    puts ""
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    # binding.pry
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    num = board.unmarked_keys.to_a.sample
    board.set_square_at(num, computer.marker)
  end

  def display_result
    display_board

    if board.detect_winner
      winner = board.detect_winner == HUMAN_MARKER ? "Player" : "Computer"
      puts "#{winner} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == "y"
  end

  def play
    system("clear")
    display_welcome_message

    loop do
      display_board(false)
      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        display_board
        break if board.someone_won? || board.full?
      end
      display_result
      break unless play_again?
      board.reset
      system('clear')
      puts "Let's play again!"
      puts ""
    end
    display_goodbye_message
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play