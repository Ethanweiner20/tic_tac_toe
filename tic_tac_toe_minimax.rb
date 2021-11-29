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
BOARD_SIZE = 3

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
  board_size: "Please enter a board size between 2 and 10.",
  again: "Would you like to play again (y/n)?",
  invalid_choice: "Your input is invalid. Please try again."
}

# HELPER METHODS
# ============================================================================

# Board Setup

def initialize_board(board_size)
  board_size.times.map { |_| initialize_row(board_size) }
end

def initialize_row(board_size)
  board_size.times.map { |_| EMPTY_SPOT }
end

# Display

def display_turn(board)
  display_tutorial(board.size)
  display_board(board)
end

def display_board(board)
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

def display_tutorial(board_size)
  system('clear')

  square_width = (board_size**2).to_s.length
  board = (1..board_size).map do |row|
    (1..board_size).map do |col|
      ((row - 1) * board_size + col).to_s.ljust(square_width)
    end
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
  update_board!(board, COMPUTER, computer_choice(board))
end

# Choose the square that, when played, will minimize the opponent's best
# strategy; i.e. choose the maximum score (favors computer) from the opponent's
# moves
def computer_choice(board)
  score_groups = squares_left(board).group_by do |square|
    next_board = copy_board(board)
    update_board!(next_board, COMPUTER, square)
    minimax_score(next_board, USER)
  end

  # If multiple squares produce the maximum score, randomly select one
  score_groups.max.last.sample
end

# Determine the score of a particular board for the given player
def minimax_score(board, player)
  case result(board)
  when COMPUTER then 1
  when USER then -1
  when 'tie' then 0
  else
    opponent = alternate_player(player)

    opponent_scores = squares_left(board).map do |square|
      next_board = copy_board(board)
      update_board!(next_board, player, square)
      minimax_score(next_board, opponent)
    end

    # COMPUTER wants to maximize score, USER wants to minimize score
    player == COMPUTER ? opponent_scores.max : opponent_scores.min
  end
end

def winning_square(board, player)
  squares_left(board).find do |square|
    next_board = copy_board(board)
    update_board!(next_board, player, square)
    result(next_board) == player
  end
end

def update_board!(board, player, square)
  position = square_to_position(square, board.size)
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
  (0...board.size).each do |column|
    return USER if won_column?(column, USER, board)
    return COMPUTER if won_column?(column, COMPUTER, board)
  end
  false
end

def won_column?(column, player, board)
  board.all? { |row| row[column] == player }
end

def diagonal_winner(board)
  diagonals(board.size).each do |diagonal|
    return USER if won_diagonal?(diagonal, USER, board)
    return COMPUTER if won_diagonal?(diagonal, COMPUTER, board)
  end
  false
end

def diagonals(board_size)
  diagonals = [[], []]
  (0...board_size).each do |row|
    diagonals[0] << [row, row]
    diagonals[1] << [row, board_size - row - 1]
  end
  diagonals
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

def choose_board_size
  answer = nil
  loop do
    prompt MESSAGES[:board_size]
    answer = gets.chomp.to_i
    break if (2..10).to_a.include?(answer)
    prompt MESSAGES[:invalid_choice]
  end
  answer
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

def square_to_position(square, board_size)
  (square - 1).divmod(board_size)
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
  (0...board.size).each_with_object(Array.new) do |row_index, new_board|
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
  board_size = BOARD_SIZE

  # Match Loop
  loop do
    board = initialize_board(board_size)
    current_player = retrieve_first_player
    result = nil

    # Move Loop
    loop do
      display_turn(board)
      move!(board, current_player)
      result = result(board)
      break if result

      current_player = alternate_player(current_player)
    end

    update_score!(result, score)
    display_turn(board)
    display_result(result, score)

    break if end_game?(score)
  end

  display_winner(score)

  break unless play_again?
end

prompt MESSAGES[:goodbye]
