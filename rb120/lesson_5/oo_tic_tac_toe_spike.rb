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

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # return the winning marker on nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end

  def draw
    puts "       |       |"
    puts "   #{@squares[1]}   |   #{@squares[2]}   |   #{@squares[3]}"
    puts "       |       |"
    puts "-------+-------+------"
    puts "       |       |"
    puts "   #{@squares[4]}   |   #{@squares[5]}   |   #{@squares[6]}"
    puts "       |       |"
    puts "-------+-------+------"
    puts "       |       |"
    puts "   #{@squares[7]}   |   #{@squares[8]}   |   #{@squares[9]}"
    puts "       |       |"
  end

  private
  def three_identical_markers(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
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

  def marked?
    !unmarked?
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
  FIRST_TO_MOVE = HUMAN_MARKER

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear_screen
    display_welcome_message

    loop do
      display_board
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private
  attr_reader :board, :human, :computer

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
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
    board[square] = human.marker
  end

  def computer_moves
    square = board.unmarked_keys.to_a.sample
    board[square] = computer.marker
  end

  def display_result
    clear_screen
    display_board

    if board.winning_marker
      winner = board.winning_marker == HUMAN_MARKER ? "Player" : "Computer"
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

  def clear_screen
    system("clear")
  end

  def reset
    board.reset
    @current_player = FIRST_TO_MOVE
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def alternate_current_marker
    @current_marker = human_turn? ? COMPUTER_MARKER : HUMAN_MARKER
  end

  def current_player_moves
    human_turn? ? human_moves : computer_moves
    alternate_current_marker
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
