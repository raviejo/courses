require "pry"

module TTTGameRB120
  class Board
    WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                    [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                    [[1, 5, 9], [3, 5, 7]]              # diagonals

    attr_accessor :squares

    def initialize
      @squares = {}
      reset
    end

    def []=(num, marker)
      @squares[num].marker = marker
    end

    def unmarked_keys
      @squares.keys.select { |key| @squares[key].unmarked? }
    end

    def unmarked_keys_joinor(delim=', ', conjunction='or')
      arr = unmarked_keys
      return arr.first if arr.size == 1
      last = arr.last
      first_elts = arr[0..-2]
      "#{first_elts.join(delim)} #{conjunction} #{last}"
    end

    def full?
      unmarked_keys.empty?
    end

    def someone_won?
      !!winning_marker
    end

    def winning_marker
      WINNING_LINES.each do |line|
        squares = @squares.values_at(*line)
        if three_identical_markers?(squares)
          return squares.first.marker
        end
      end
      nil
    end

    def reset
      (1..9).each { |key| @squares[key] = Square.new }
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def draw
      puts "     |     |"
      puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
      puts "     |     |"
      puts "-----+-----+-----"
      puts "     |     |"
      puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
      puts "     |     |"
      puts "-----+-----+-----"
      puts "     |     |"
      puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
      puts "     |     |"
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def middle_empty?
      @squares[middle].unmarked?
    end

    def middle
      @squares.count.fdiv(2).ceil
    end

    def two_identical_markers?(squares)
      markers = squares.select(&:marked?).collect(&:marker)
      return false if markers.size != 2
      markers.count(markers.first) == 2
    end

    private

    def three_identical_markers?(squares)
      markers = squares.select(&:marked?).collect(&:marker)
      return false if markers.size != 3
      markers.min == markers.max
    end
  end

  class Square
    INITIAL_MARKER = " "

    attr_accessor :marker

    def initialize(marker=INITIAL_MARKER)
      @marker = marker
    end

    def to_s
      @marker
    end

    def unmarked?
      marker == INITIAL_MARKER
    end

    def marked?
      marker != INITIAL_MARKER
    end
  end

  class Player
    attr_reader :marker

    def initialize(marker)
      @marker = marker
    end
  end

  class Score
    WINNING_SCORE = 5

    def initialize(human, computer)
      @human = human
      @computer = computer
      reset
    end

    def human
      @score[@human]
    end

    def computer
      @score[@computer]
    end

    def reset
      @score = {@human => 0, @computer => 0}
    end

    def increment_score(player)
      @score[player] += 1
    end

    def winner
      @score.key(WINNING_SCORE)
    end

    def display
      puts "Your score: #{human}"
      puts "Computer score: #{computer}"
    end
  end

  class TTTGame
    HUMAN_MARKER = "X"
    COMPUTER_MARKER = "O"
    FIRST_TO_MOVE = HUMAN_MARKER
    MINIMAX_DEPTH = 5
    SLEEP_TIME_NEXT_MATCH = 5

    attr_reader :board, :human, :computer

    def initialize
      @board = Board.new
      @human = Player.new(HUMAN_MARKER)
      @computer = Player.new(COMPUTER_MARKER)
      @current_marker = FIRST_TO_MOVE
      @first_to_move = nil
      @score = Score.new(@human, @computer)
    end

    def play
      clear
      display_welcome_message
      who_goes_first?
      main_game
      display_game_winner
      display_goodbye_message
    end

    private

    def display_welcome_message
      puts "Welcome to Tic Tac Toe!"
      puts ""
    end

    def display_goodbye_message
      puts "Thanks for playing Tic Tac Toe! Goodbye!"
    end

    def clear_screen_and_display_board
      clear
      display_board
    end

    def human_turn?
      @current_marker == HUMAN_MARKER
    end

    def display_board
      puts "You're a #{human.marker}. Computer is a #{computer.marker}."
      puts ""
      board.draw
      puts ""
    end

    def human_moves
      puts "Choose a square (#{board.unmarked_keys_joinor}): "
      square = nil
      loop do
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)
        puts "Sorry, that's not a valid choice."
      end

      board[square] = human.marker
    end

    def computer_potential_moves
      lines = []
      Board::WINNING_LINES.each do |line|
        squares = board.squares.values_at(*line)
        lines << line if board.two_identical_markers?(squares)
      end
      lines
    end

    def random_marker
      [HUMAN_MARKER, COMPUTER_MARKER].sample
    end

    def set_current_marker(first_to_move)
      @current_marker = case first_to_move.downcase
                        when "p" then HUMAN_MARKER
                        when "c" then COMPUTER_MARKER
                        else random_marker
                        end
    end

    def who_goes_first?
      puts "Who should play first? Player (\"p\"), Computer (\"c\") or Computer decides at random (\"r\")"
      user_input = nil
      loop do
        user_input = gets.chomp
        break if user_input =~ /p|c|r/i
        puts "Sorry, that's not a valid choice. Please select \"p\" for Player, \"c\" for Computer, or \"r\" for the computer to decide at random"
      end
      set_current_marker(user_input)
      @first_to_move = @current_marker
    end

    def computer_best_move(type=:defensive)
      marker = type == :offensive ? COMPUTER_MARKER : HUMAN_MARKER
      lines = computer_potential_moves
      best_move = nil
      lines.each do |line|
        board_line = board.squares.select { |k, v| line.include?(k) }
        key = board_line.select { |k, v| v.marker == Square::INITIAL_MARKER }.keys.first
        board_line_markers = board_line.values.map(&:marker)
        if board_line_markers.include?(marker)
          best_move = key
        end
      end
      best_move
    end

    def score_board(board)
      winning_marker = board.winning_marker
      case winning_marker
      when COMPUTER_MARKER then -1
      when HUMAN_MARKER then 1
      else 0
      end
    end

    def minimax(board, depth, maximizing_player)
      if depth == 0 || board.someone_won? || board.full?
        return score_board(board)
      elsif maximizing_player
        best_score = -Float::INFINITY
        board.unmarked_keys.each do |key|
          board[key] = HUMAN_MARKER
          score = minimax(board, depth - 1, false)
          board[key] = Square::INITIAL_MARKER
          best_score = [score, best_score].max
        end
        return best_score
      else
        best_score = Float::INFINITY
        board.unmarked_keys.each do |key|
          board[key] = COMPUTER_MARKER
          score = minimax(board, depth - 1, true)
          board[key] = Square::INITIAL_MARKER
          best_score = [score, best_score].min
        end
        return best_score
      end
    end

    def scored_moves
      moves = {}
      @board.unmarked_keys.each do |potential_move|
        @board[potential_move] = COMPUTER_MARKER
        score = minimax(@board,MINIMAX_DEPTH,true)
        moves[potential_move] = score
        @board[potential_move] = Square::INITIAL_MARKER
      end
      moves
    end

    def computer_moves_minimax
      moves = scored_moves
      best_move = moves.key(moves.values.min)
      board[best_move] = COMPUTER_MARKER
    end

    def computer_moves
      if computer_potential_moves.empty? && @board.middle_empty?
        board[@board.middle] = computer.marker
      elsif computer_potential_moves.empty?
        board[board.unmarked_keys.sample] = computer.marker
      elsif computer_best_move(:offensive)
        board[computer_best_move(:offensive)] = computer.marker
      elsif computer_best_move
        board[computer_best_move] = computer.marker
      end
    end

    def current_player_moves
      if human_turn?
        human_moves
        @current_marker = COMPUTER_MARKER
      else
        computer_moves
        @current_marker = HUMAN_MARKER
      end
    end

    def display_match_result
      clear_screen_and_display_board

      case match_winner
      when human.marker
        puts "You won the match!"
      when computer.marker
        puts "Computer won the match!"
      else
        puts "It's a tie!"
      end
    end

    def match_winner
      board.winning_marker
    end

    def computer_won?
      match_winner == COMPUTER_MARKER
    end

    def play_again?
      answer = nil
      loop do
        puts "Would you like to play again? (y/n)"
        answer = gets.chomp.downcase
        break if %w(y n).include? answer
        puts "Sorry, must be y or n"
      end

      answer == 'y'
    end

    def clear
      system "clear"
    end

    def reverse_first_to_move
      @first_to_move = @first_to_move == HUMAN_MARKER ? COMPUTER_MARKER : HUMAN_MARKER
    end

    def reset
      board.reset
      reverse_first_to_move
      @current_marker = @first_to_move
      # clear
    end

    def display_play_again_message
      puts "The first to #{Score::WINNING_SCORE} wins the game!"
      puts ""
    end

    def display_score
      @score.display
    end

    def display_final_score_message
      puts "<<--- Final Scores --->>"
    end

    def display_next_match_countdown_message(sleep_time=0)
      puts "Next match starts in: #{SLEEP_TIME_NEXT_MATCH - sleep_time}"
      system "sleep 1s"
    end

    def player_move
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end
    end

    def game_over?
      !!@score.winner
    end

    def display_game_winner
      marker = @score.winner.marker
      message = marker == HUMAN_MARKER ? "You won the game!" : "Computer won the game!"
      puts message
    end

    def update_score
      case match_winner
      when HUMAN_MARKER
        @score.increment_score(@human)
      when COMPUTER_MARKER
        @score.increment_score(@computer)
      end
    end

    def countdown_complete?

    end

    def main_game_display_messages
      starting_count = 0
      loop do
        display_match_result
        display_final_score_message if game_over?
        display_score
        display_play_again_message unless game_over?
        display_next_match_countdown_message(starting_count)
        starting_count += 1
        clear
        break if starting_count == SLEEP_TIME_NEXT_MATCH
      end
    end

    def first_match?
      (@score.human + @score.computer) == 0
    end

    def main_game
      loop do
        display_score unless first_match?
        display_board
        player_move
        update_score
        main_game_display_messages
        break if game_over?
        reset
      end
    end
  end
end

game = TTTGameRB120::TTTGame.new
game.play
