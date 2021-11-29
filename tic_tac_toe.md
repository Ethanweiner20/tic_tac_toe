# Tic Tac Toe

# PROBLEM

*Description*

Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn and
marks a square on the board. First player to reach 3 squares in a row, including diagonals,
wins. If all 9 squares are marked and no player has 3 squares in a row, then the game is a tie.

# DATA DEFINITIONS

## A Board is an Array of Rows:

*Examples*:

Empty Board:
[
  [' ', ' ', ' '],
  [' ', ' ', ' '],
  [' ', ' ', ' '],
],

During Game:
[
  ['X', ' ', 'O'],
  [' ', ' ', ' '],
  ['O', 'X', 'X'],
]

User Wins: 
[
  ['X', 'O', 'O'],
  ['O', 'X', 'O'],
  ['O', 'X', 'X'],
]

Tie:
[
  ['X', 'O', 'X'],
  ['O', 'X', 'X'],
  ['O', 'X', 'O'],
]

## A Row is an Array of three Players:

*Examples*:
- ['X', ' ', 'O']
- [' ', ' ', ' ']
- ['O', 'X', 'X']

## A Player is one of:
- 'X'
- 'O'
- '_'
A player represents a player spot ('X'), computer spot ('O'), or empty position ('_'). We use these throughout the program to represent the players.

## A Square is an Integer the range [0, 9]
- It represents a particular square on the board

## A Position is a 2-element Array of the form [row, column]
- `row` and `col` are integers in the range [0, 2], representing their index in the nested board array

## A Result is one of:
- nil (game is unfinished)
- 'X' (user win)
- 'O' (computer win)
- 'tie' (tie)

# ALGORITHM

*Gameplay Sequence*

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full (and there is no winner), display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!

Outer-level algorithm:
- Display a welcome message
- Loop #1
  - Initialize empty board
  - Display empty board
  - Loop #2
    - Ask user to mark square
    - Computer marks square
    - Display updated board
    - Determine results
    - If there is a winner or tie:
      - Exit loop #2
  - Ask the user if they want to play again
    - If not, exit loop #1
- Display a goodbye message


*Sub-Problems*:
- Represent the 3x3 board as data
- Display the board for a given state
- Prompt the user to mark a square
- Update the board given w/ a user move or computer move
- Display the game results: winner/tie

# CODE

*Implementation Details*:
- Should we mutate the board directly or reassign it to a new board?

## Questions

- Is it appropriate to define players as 'X' and 'O'? I felt like that was appropriate, because that was really the only information needed to distinguish between players.
- I chose to use a nested array with positions to represent a board, as opposed to a hash with square numbers, because it felt immediately more intuitive. It helped to condense the board display process, but added an extra layer of conversion between user input (square numbers) and array positions (e.g. [1, 2]). This added some confusion because it meant I was dealing w/ 2 different ways to represent the same thing. Should I have chosen the hash to avoid this confusion altogether?
- Is is overboard or bad practice to create a separate data type to define the result of the game?
- In my `winner` method (and `computer_move!` method), is it good practice to rely on the return value of || (or other Boolean operators)?
  - Should my solution have been:
  ```ruby
    if row_winner(board)
      row_winner(board)
    elsif column_winner(board)
      column_winner(board)
    elsif diagonal_winner(board)
      diagonal_winner(board)
    end
  ```
  - I assume that using || is an appropriate simplifcation.
- Is it acceptable to rely on non-Boolean return values from a method to determine truthiness, or should is it better to only utilize the truthiness of methods that return a Boolean explicitly? For example, my `computer_move!` method relies on the truthiness of `winning_square`, which returns either a square (truthy) or `nil` (falsey).
- In order to experiment with board updates (without actually performing them), I went the route of making board copies (deep to the row level) via a helper method `copy_board`. Instead of needing to copy the board, I could've re-written methods that perform board updates to be nondestructive, and actually return a new, updated instance of the board. Would the latter (a more functional-programming style) be preferable?

## Improvements

- Only scan board once for winner detection X
  - No need to scan board twice
- Refactor multiple occurrences of 'display_board': reduce to only a couple X

## Bonus Features

1. Improved join: Include an 'or' when prompting the user w/ remaining valid squares X
  - Create a `joinor` method to do this
2. Keep score X
  - Don't use global or instance variables
  - Display the score after each game
  - The first player to 5 should win the game
3. Computer ability: Use logic to play
  1. Play available offensive winning move
  2. Play defensive winning move
  3. If square 5 is available, play square 5
  4. Otherwise, pick a random square
4. Player order flexibility: 2 options
  - User chooses who goes first w/ prompt
  - Computer chooses who goes first (random choice)
5. [Related to 4] Create an abstract #move! method that moves based on the current player. Alternate the player after one moves.
6. Other ideas:
  - Minimiax
  - Bigger board
  - More layers