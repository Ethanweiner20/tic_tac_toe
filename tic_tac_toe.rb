# Tic Tac Toe
# ============================================================================

require 'pry-byebug'

# BOARD EXAMPLES
# ============================================================================

BOARD_UNFINISHED = [
  ['X', '_', 'O'],
  ['_', '_', '_'],
  ['O', 'X', 'X']
]

BOARD_UNFINISHED_2 = [
  ['_', 'X', 'O'],
  ['X', '_', '_'],
  ['_', '_', 'X']
]

BOARD_WINNING_SQUARE_USER_1 = [
  ['X', '_', 'O'],
  ['_', '_', '_'],
  ['O', 'X', 'X']
]

BOARD_WINNING_SQUARE_USER_2 = [
  ['X', '_', 'O'],
  ['_', 'O', '_'],
  ['_', 'X', 'X']
]

BOARD_WINNING_SQUARE_COMPUTER_1 = [
  ['X', '_', 'O'],
  ['_', 'O', '_'],
  ['_', 'X', 'X']
]

BOARD_ROW_WIN = [
  ['0', 'X', 'O'],
  ['X', 'X', 'X'],
  ['O', '_', '_']
]

BOARD_COL_WIN = [
  ['X', 'O', 'X'],
  ['O', 'O', 'X'],
  ['O', '_', 'X']
]

BOARD_DIAGONAL_WIN = [
  ['X', 'O', 'O'],
  ['O', 'X', 'O'],
  ['O', 'X', 'X']
]

BOARD_TIED = [
  ['X', 'O', 'X'],
  ['O', 'X', 'X'],
  ['O', 'X', 'O']
]

BOARD_EMPTY = [
  ['_', '_', '_'],
  ['_', '_', '_'],
  ['_', '_', '_']
]

# CONSTANTS
# ============================================================================

USER = 'X'
COMPUTER = 'O'
EMPTY_SPOT = '_'
MAX_WINS = 5

DIAGONALS = [
  [[0, 0], [1, 1], [2, 2]],
  [[0, 2], [1, 1], [2, 0]]
]

# HELPER METHODS
# ============================================================================

# Board Setup

def initialize_board
  3.times.map { |_| initialize_row }
end

def initialize_row
  3.times.map { |_| EMPTY_SPOT }
end

# Scoring

def initialize_score
  {
    user: 0,
    computer: 0
  }
end

def update_score(result, score)
  if result == USER
    score[:user] += 1
  elsif result == COMPUTER
    score[:computer] += 1
  end
end

def display_score(score)
  puts "The score is #{score[:user]} (you) to #{score[:computer]} (computer). "\
       "Press any key to continue."
  gets
end

def display_winner(score)
  prompt "#{score[:user] == MAX_WINS ? 'You' : 'The computer'} won the game! "\
         "The final score was #{score[:user]}-#{score[:computer]}."
end

# Display

def display_board(board)
  system('clear')
  board.each { |row| display_row(row) }
  print "\n"
end

def display_row(row)
  print "|"
  row.each { |spot| print spot + "|" }
  print "\n"
end

def display_welcome_message
  system('clear')
  prompt "Welcome to Tic Tac Toe! You're #{USER}. Computer is #{COMPUTER}. "\
         "First player to 5 wins. "\
         "Press any key to continue."
  gets
end

def display_tutorial
  board = (1..3).map do |row|
    (1..3).map { |col| ((row - 1) * 3 + col).to_s }
  end

  display_board(board)
end

def display_result(board, result)
  system('clear')
  display_board(board)
  prompt result_message(result)
end

# Board Updates

def move!(board, player)
  case player
  when USER then user_move!(board)
  when COMPUTER then computer_move!(board)
  end
end

def user_move!(board)
  square = retrieve_square(board)
  update_board!(board, USER, square)
end

def retrieve_square(board)
  square = nil

  loop do
    valid_squares = squares_left(board)
    prompt "Enter a square number (#{joinor(valid_squares)}):"
    square = gets.chomp.to_i
    break if valid_squares.include?(square)
    prompt "'#{square}' is either invalid or already taken."
  end

  square
end

def computer_move!(board)
  square = winning_square(board, COMPUTER) ||
           winning_square(board, USER) ||
           squares_left(board).find { |spot| spot == 5 } ||
           squares_left(board).sample

  update_board!(board, COMPUTER, square)
end

def winning_square(board, player)
  squares_left(board).find do |square|
    next_board = copy_board(board)
    update_board!(next_board, player, square)
    result(next_board) == player
  end
end

def update_board!(board, player, square)
  position = square_to_position(square)
  board[position[0]][position[1]] = player
end

# Board Status

## A Status is one of:
# - nil
# - USER
# - COMPUTER
# - 'tie'

def result(board)
  if winner(board) == USER then USER
  elsif winner(board) == COMPUTER then COMPUTER
  elsif full?(board) then 'tie'
  end
end

def winner(board)
  row_winner(board) ||
    column_winner(board) ||
    diagonal_winner(board)
end

def row_winner(board)
  board.each do |row|
    return USER if won_row?(row, USER)
    return COMPUTER if won_row?(row, COMPUTER)
  end
  false
end

def won_row?(row, player)
  row.all?(player)
end

def column_winner(board)
  [0, 1, 2].each do |column|
    return USER if won_column?(column, USER, board)
    return COMPUTER if won_column?(column, COMPUTER, board)
  end
  false
end

def won_column?(column, player, board)
  board.all? { |row| row[column] == player }
end

def diagonal_winner(board)
  DIAGONALS.each do |diagonal|
    return USER if won_diagonal?(diagonal, USER, board)
    return COMPUTER if won_diagonal?(diagonal, COMPUTER, board)
  end
  false
end

def won_diagonal?(diagonal, player, board)
  diagonal.all? { |spot| board[spot[0]][spot[1]] == player }
end

def full?(board)
  squares_left(board).empty?
end

# Auxiliary Methods

def prompt(message)
  puts "==> #{message}"
end

def square_to_position(square)
  (square - 1).divmod(3)
end

def squares_left(board)
  board.flatten.each_with_object([]).with_index do |(spot, squares), index|
    squares << index + 1 if spot == EMPTY_SPOT
  end
end

def result_message(result)
  case result
  when USER then "You won!"
  when COMPUTER then "You lost!"
  when 'tie' then "You tied!"
  end
end

def joinor(nums, delimiter=', ', joining_word='or')
  case nums.length
  when 0 then ''
  when 1 then nums.first.to_s
  when 2 then nums.join(" #{joining_word} ")
  else "#{nums[0..-2].join(delimiter)}#{delimiter}#{joining_word} #{nums.last}"
  end
end

def copy_board(board)
  (0..2).each_with_object(Array.new) do |row_index, new_board|
    new_board[row_index] = board[row_index].dup
  end
end

def retrieve_first_player
  system('clear')
  answer = nil
  loop do
    prompt "Who should go first (#{joinor([1, 2, 3])})?\n"\
          "1. You (the user)\n"\
          "2. The computer\n"\
          "3. Let the computer choose"
    answer = gets.chomp.to_i
    break if [1, 2, 3].include?(answer)
  end

  case answer
  when 1 then USER
  when 2 then COMPUTER
  when 3 then [USER, COMPUTER].sample
  end
end

def alternate_player(player)
  player == USER ? COMPUTER : USER
end

# MAIN PROGRAM
# ============================================================================

# Full Game Loop
loop do
  display_welcome_message
  score = initialize_score

  # Match Loop
  loop do
    board = initialize_board
    current_player = retrieve_first_player
    display_tutorial
    result = nil

    # Move Loop
    loop do
      move!(board, current_player)
      result = result(board)
      break if result

      current_player = alternate_player(current_player)
      display_board(board)
    end

    display_result(board, result)
    update_score(result, score)

    break if score[:user] == MAX_WINS || score[:computer] == MAX_WINS
    display_score(score)
  end

  display_winner(score)
  prompt "Would you like to play again (y/n)?"
  answer = gets.chomp.downcase
  break unless answer == 'y' || answer == 'yes'
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"

# TESTS

# display_board(BOARD_EMPTY)
# display_board(BOARD_UNFINISHED)

# board = BOARD_EMPTY
# update_board!(board, 'X', [1, 1])
# display_board(board)

# board = BOARD_EMPTY
# user_move!(board)
# display_board(board)

# puts valid_square?(2, BOARD_EMPTY)
# puts valid_square?(1, BOARD_UNFINISHED)
# puts valid_square?(2, BOARD_UNFINISHED)

# p squares_left(BOARD_UNFINISHED)

# board = BOARD_UNFINISHED
# display_board(board)
# user_move!(board)
# computer_move!(board)
# display_board(board)

# puts winner?(BOARD_UNFINISHED, 'X') == false
# puts winner?(BOARD_TIED, 'X') == false
# puts winner?(BOARD_ROW_WIN, 'X') == true
# puts winner?(BOARD_COL_WIN, 'X') == true
# puts winner?(BOARD_DIAGONAL_WIN, 'X') == true

# puts joinor([1]) == "1"
# puts joinor([1, 2]) == "1 or 2"
# puts joinor([1, 2, 3]) == "1, 2, or 3"
# puts joinor([1, 2, 3], '; ') == "1; 2; or 3"
# puts joinor([1, 2, 3], ', ', 'and') == "1, 2, and 3"

# puts winning_square(BOARD_EMPTY, COMPUTER).nil?
# puts winning_square(BOARD_UNFINISHED_2, USER).nil?
# puts winning_square(BOARD_WINNING_SQUARE_USER_1, USER) == 5
# puts winning_square(BOARD_WINNING_SQUARE_USER_2, USER) == 7
# puts winning_square(BOARD_WINNING_SQUARE_COMPUTER_1, COMPUTER) == 7
