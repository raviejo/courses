require 'pry'

INITIAL_MARKER = " "
PLAYER_MARKER = "X"
COMPUTER_MARKER = "O"
# WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
#                 [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
#                 [[1, 5, 9], [3, 5, 7]]              # diagonals
WINNING_LINES = [[1, 2, 3], [2, 3, 4], [3, 4, 5]] +           # rows
                [[6, 7, 8], [7, 8, 9], [8, 9, 10]] +          # rows
                [[11, 12, 13], [12, 13, 14], [13, 14, 15]] +  # rows
                [[16, 17, 18], [17, 18, 19], [18, 19, 20]] +  # rows
                [[21, 22, 23], [22, 23, 24], [23, 24, 25]] +  # rows
                [[1, 6, 11], [6, 11, 16], [11, 16, 21]] +     # cols
                [[2, 7, 12], [7, 12, 17], [12, 17, 22]] +     # cols
                [[3, 8, 13], [8, 13, 18], [13, 18, 23]] +     # cols
                [[4, 9, 14], [9, 14, 19], [14, 19, 24]] +     # cols
                [[5, 10, 15], [10, 15, 20], [15, 20, 25]] +   # cols
                [[1, 7, 13], [7, 13, 19], [13, 19, 25]] +     # diagonals
                [[2, 8, 14], [8, 14, 20], [3, 9, 15]] +       # diagonals
                [[6, 12, 18], [12, 18, 24], [11, 17, 23]] +   # diagonals
                [[5, 9, 13], [9, 13, 17], [13, 17, 21]] +     # diagonals
                [[4, 8, 12], [8, 12, 16], [3, 7, 11]] +       # diagonals
                [[10, 14, 18], [14, 18, 22], [15, 19, 23]]    # diagonals
INFINITY = Float::INFINITY

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
# def display_board(brd)
#   puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
#   puts ""
#   puts "     |     |"
#   puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
#   puts "     |     |"
#   puts "-----+-----+-----"
#   puts "     |     |"
#   puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
#   puts "     |     |"
#   puts "-----+-----+-----"
#   puts "     |     |"
#   puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
#   puts "     |     |"
#   puts ""
# end

def display_board(brd)
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  |  #{brd[4]}  |  #{brd[5]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |"
  puts "  #{brd[6]}  |  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  |  #{brd[10]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |"
  puts "  #{brd[11]}  |  #{brd[12]}  |  #{brd[13]}  |  #{brd[14]}  |  #{brd[15]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |"
  puts "  #{brd[16]}  |  #{brd[17]}  |  #{brd[18]}  |  #{brd[19]}  |  #{brd[20]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |"
  puts "  #{brd[21]}  |  #{brd[22]}  |  #{brd[23]}  |  #{brd[24]}  |  #{brd[25]}"
  puts "     |     |     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

# def initialize_board
#   new_board = {}
#   (1..9).each { |num| new_board[num] = INITIAL_MARKER }
#   new_board
# end

def initialize_board
  new_board = {}
  (1..25).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, str=", ", conjunction="or")
  return arr.first if arr.size == 1
  joined_arr = ""
  arr.each_with_index do |elt, idx|
    break if idx == (arr.size - 1)
    joined_arr << "#{elt}#{str}"
  end
  joined_arr << "#{conjunction} #{arr.last.to_s}" unless arr.size == 1
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

# def player_places_piece!(brd)
#   best_score = INFINITY
#   best_move = nil
#   empty_squares(brd).each do |square|
#     brd[square] = PLAYER_MARKER
#     score = minimax(brd, 3, -INFINITY, INFINITY, true)
#     brd[square] = INITIAL_MARKER
#     if score < best_score
#       best_score = score
#       best_move = square
#     end
#   end
#   brd[best_move] = PLAYER_MARKER
# end

def board_full?(brd)
  empty_squares(brd).empty?
end

def minimax(brd, depth, alpha, beta, maximizing)
  winner = detect_winner(brd)
  if depth.zero? || !winner.nil? || board_full?(brd)
    if winner == "Computer"
      return 1
    elsif winner == "Player"
      return -1
    else
      return 0
    end
  elsif maximizing
    max_score = -INFINITY
    empty_squares(brd).each do |square|
      brd[square] = COMPUTER_MARKER
      score = minimax(brd, depth - 1, alpha, beta, false)
      brd[square] = INITIAL_MARKER
      max_score = [max_score, score].max
      alpha = [max_score, alpha].max
      if beta <= alpha
        break
      end
    end
    return max_score
  else
    min_score = INFINITY
    empty_squares(brd).each do |square|
      brd[square] = PLAYER_MARKER
      score = minimax(brd, depth - 1, alpha, beta, true)
      brd[square] = INITIAL_MARKER
      min_score = [min_score, score].min
      beta = [min_score, beta].min
      if beta <= alpha
        break
      end
    end
    return min_score
  end
end

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

# def computer_places_piece!(brd)
#   square = nil

#   WINNING_LINES.each do |line|
#     square = find_at_risk_square(line, brd, COMPUTER_MARKER)
#     break if square
#   end

#   if !square 
#     WINNING_LINES.each do |line|
#       square = find_at_risk_square(line, brd, PLAYER_MARKER)
#       break if square
#     end
#   end

#   if !square
#     square = 5 if empty_squares(brd).include?(5)
#   end

#   if !square
#     square = empty_squares(brd).sample
#   end

#   brd[square] = COMPUTER_MARKER
# end

def computer_places_piece!(brd)
  best_score = -INFINITY
  best_move = nil
  empty_squares(brd).each do |square|
    brd[square] = COMPUTER_MARKER
    score = minimax(brd, 5, -INFINITY, INFINITY, false)
    brd[square] = INITIAL_MARKER
    if score > best_score
      best_score = score
      best_move = square
    end
  end
  brd[best_move] = COMPUTER_MARKER
end

def place_piece!(brd, player)
  case player
  when "Player" then player_places_piece!(brd)
  when "Computer" then computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  case current_player
  when "Player" then "Computer"
  else "Player"
end
end


def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    board_values = brd.values_at(*line)
    if board_values.count(PLAYER_MARKER) == 3
      return "Player"
    elsif board_values.count(COMPUTER_MARKER) == 3
      return "Computer"
    end
  end
  nil
end

player_score = 0
computer_score = 0
loop do
  prompt "Current Scores:"
  prompt "Player: #{player_score}"
  prompt "Computer: #{computer_score}"
  prompt "First to 5 wins!"

  board = initialize_board

  prompt "Who should go first? (1. player, 2. computer, 3. computer decide?)"
  current_player = gets.chomp
  if current_player == "3"
    current_player = %w(1 2).sample
  end

  current_player = case current_player
                   when "1" then "Player"
                   else "Computer"
                   end

  prompt "#{current_player} goes first"

  counter = 0
  loop do
    system "clear" unless counter == 0
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
    counter += 1
  end

  display_board(board)

  winner = detect_winner(board)  
  
  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  if winner
    player_score += 1 if winner.include?("Player")
    computer_score += 1 if winner.include?("Computer")
  end

  break if player_score == 5 || computer_score == 5
end

prompt "Final Scores:"
prompt "Player: #{player_score}"
prompt "Computer: #{computer_score}"
prompt "Thanks for playing Tic Tac Toe! Good bye!"