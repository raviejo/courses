# Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn and
# marks a square on the board. First player to reach 3 squares in a row, including diagonals,
# wins. If all 9 squares are marked and no player has 3 squares in a row, then the game is a tie.

# 1. Display the initial empty 3x3 board.
# 2. Ask the user to mark a square.
# 3. Computer marks a square.
# 4. Display the updated board state.
# 5. If winner, display winner.
# 6. If board is full, display tie.
# 7. If neither winner nor board is full, go to #2
# 8. Play again?
# 9. If yes, go to #1
# 10. Good bye!

def new_board()
  n = 1
  board = []
  3.times do
    row = []
    3.times do 
      row << n.to_s
      n += 1
    end
    board << row
  end
  board
end

def display_board(board)
  board_strings = []
  board.each_with_index do |row, idx|
    display_row = ""
    row.each_with_index do |space, idx|
      display_row << space
      display_row << " | " unless idx == 2
    end
    board_strings << display_row
    board_strings << "---------" unless idx == 2
  end
  board_strings.each {|row| puts row}
end

def update_board(board, move, player="")
  board.each_with_index do |row, row_idx|
    row.each_with_index do |space, col_idx|
      if space == move
        case player
        when "player" then board[row_idx][col_idx] = "X"
        else board[row_idx][col_idx] = "O"
        end
      end
    end
  end
  board
end

def computer_move(board)
  selection = board.flatten.select {|n| n != "X" && n != "O"}
  move = selection.sample
  update_board(board, move)
end

def score_board(board)
  winner = nil
  draw = board.flatten.all? {|spaces| spaces == "X" || spaces == "O"}

  3.times do |n|
    col = []
    board.each do |row|
      col << row[n]
    end
    winner = col[0] if col.all? {|spaces| col[0] == spaces}
  end

  board.each do |row|
    winner = row[0] if row.all? {|spaces| row[0] == spaces}
  end

  [board, board.reverse].each do |b|
    diagonal = []
    3.times do |n|
      diagonal << b[n][n]
    end
    winner = diagonal[0] if diagonal.all? {|spaces| diagonal[0] == spaces}
  end

  case winner
  when draw then "draw"
  when "O" then "computer"
  when "X" then "player"
  end
end

def tic_tac_toe()
  board = new_board()
  loop do
    display_board(board)
    puts "Please mark a square (input the number of the space you'd like to play)"
    user_input = gets.chomp
    update_board(board, user_input, "player")
    computer_move(board)
    break if score_board(board)
  end
  display_board(board)
  
  winner = score_board(board)
  if winner == "draw"
    puts "it's a draw!" 
  else
    puts "#{winner} is the winner"
  end
  
  puts "Play again? (y/n)"
  user_input = gets.chomp
  tic_tac_toe() if user_input == "y"
end

tic_tac_toe()