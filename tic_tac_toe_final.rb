# Tic Tac Toe
# ============================================================================

# DATA DEFINITIONS
# ============================================================================

=begin

# DATA DEFINITIONS

## A Board is an Array of three Rows:

## A Row is an Array of three Players:

*Examples*:
- ['X', ' ', 'O']
- [' ', ' ', ' ']
- ['O', 'X', 'X']

## A Player is one of:
- 'X'
- 'O'
- '_'
A player represents a player spot ('X'), computer spot ('O'), or empty position
('_'). These strings are used throughout the program to represent the players
and their markers.

## A Square is an Integer the range [1, 9]
- It represents a particular square on the board

## A Position is a 2-element Array of the form [row, column]
- `row` and `col` are integers in the range [0, 2], representing their index in
the nested board array

## A Result is one of:
- nil (game is unfinished)
- 'X' (user win)
- 'O' (computer win)
- 'tie' (tie)

=end

# CONSTANTS
# ============================================================================

USER = 'X'
COMPUTER = 'O'
EMPTY_SPOT = '_'
MIDDLE_SQUARE = 5
MAX_WINS = 5
DIAGONALS = [
  [[0, 0], [1, 1], [2, 2]],
  [[0, 2], [1, 1], [2, 0]]
]

FIRST_PLAYER_OPTIONS = {
  1 => "You (the user)",
  2 => "The computer",
  3 => "Let the computer choose"
}

MESSAGES = {
  welcome: "Welcome to Tic Tac Toe!\n"\
  "- You're #{USER}. Computer is #{COMPUTER}.\n"\
  "- First player to 5 wins.\n\n",
  goodbye: "Thanks for playing Tic Tac Toe! Goodbye!",
  continue: "Press any key to continue.",
  pick_first_player: "Who should go first (1, 2, or 3)?\n"\
  "1. #{FIRST_PLAYER_OPTIONS[1]}\n"\
  "2. #{FIRST_PLAYER_OPTIONS[2]}\n"\
  "3. #{FIRST_PLAYER_OPTIONS[3]}\n",
  again: "Would you like to play again (y/n)?",
  invalid_choice: "That choice is invalid. Please enter 1, 2, or 3."
}

# HELPER METHODS
# ============================================================================

# Board Setup

def initialize_board
  3.times.map { |_| initialize_row }
end

def initialize_row
  3.times.map { |_| EMPTY_SPOT }
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
  puts MESSAGES[:welcome]
  prompt MESSAGES[:continue]
  gets
end

def display_tutorial
  board = (1..3).map do |row|
    (1..3).map { |col| ((row - 1) * 3 + col).to_s }
  end

  display_board(board)
end

def display_result(result, score)
  prompt result_message(result) + ' ' + score_message(score)
  prompt MESSAGES[:continue]
  gets
end

def result_message(result)
  case result
  when USER then "You won!"
  when COMPUTER then "You lost!"
  when 'tie' then "You tied!"
  end
end

def score_message(score)
  "The score is #{score[:user]} (you) to #{score[:computer]} (computer)."
end

def display_winner(score)
  prompt "#{score[:user] == MAX_WINS ? 'You' : 'The computer'} won the game! "\
         "The final score was #{score[:user]}-#{score[:computer]}."
end

# Updates to the Board

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

def computer_move!(board)
  choice = winning_square(board, COMPUTER) ||
           winning_square(board, USER) ||
           squares_left(board).find { |square| square == MIDDLE_SQUARE } ||
           squares_left(board).sample

  update_board!(board, COMPUTER, choice)
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

def result(board)
  winner = winner(board)
  if winner == USER then USER
  elsif winner == COMPUTER then COMPUTER
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

# Scoring

def initialize_score
  {
    user: 0,
    computer: 0
  }
end

def update_score!(result, score)
  if result == USER
    score[:user] += 1
  elsif result == COMPUTER
    score[:computer] += 1
  end
end

# Input Retrieval

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

def retrieve_first_player
  system('clear')
  answer = nil
  loop do
    puts MESSAGES[:pick_first_player]
    answer = gets.chomp.to_i
    break if [1, 2, 3].include?(answer)
    prompt MESSAGES[:invalid_choice]
  end

  case answer
  when 1 then USER
  when 2 then COMPUTER
  when 3 then [USER, COMPUTER].sample
  end
end

def play_again?
  prompt MESSAGES[:again]
  answer = gets.chomp.downcase
  !!(answer == 'y' || answer == 'yes')
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

def alternate_player(player)
  player == USER ? COMPUTER : USER
end

def end_game?(score)
  !!(score[:user] == MAX_WINS || score[:computer] == MAX_WINS)
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
      display_board(board)
      break if result

      current_player = alternate_player(current_player)
    end

    update_score!(result, score)
    display_result(result, score)

    break if end_game?(score)
  end

  display_winner(score)

  break unless play_again?
end

prompt MESSAGES[:goodbye]
