# Winning Square

# PROBLEM

*Explicit Requirements*:
- **Input**: A `board` and a `player`
- **Output**:
  - If `player` has a winning square, then return the winning square #
  - Otherwise, return nil

*Questions*:


*Implicit Requirements*:


*Edge Cases*:



*Mental Models*:
1. Test all moves in empty squares with `player`. If that move would result in a winning square, immediately return that square.

# EXAMPLES/TESTS

puts winning_square(BOARD_EMPTY, COMPUTER).nil?
puts winning_square(BOARD_UNFINISHED_2, USER).nil?
puts winning_square(BOARD_WINNING_SQUARE_USER_1, USER) == 5
puts winning_square(BOARD_WINNING_SQUARE_USER_1, USER) == 7
puts winning_square(BOARD_WINNING_SQUARE_COMPUTER_1, COMPUTER) == 7


# DATA STRUCTURES



# ALGORITHM

# Best Solution

Given a `board` and a `player`:
- For each leftover `square` in `board`:
  - Create a new board `next_board` with that leftover `square` filled in with `player`
  - Determine the result of `next_board`
  - If the result of `next_board` is `player` (meaning that `player` would win), then return that `square`
  - Otherwise, continue iterating
- If no leftover `squares` could produce a winner for `player`, don't return anything

# Other Solution

Given a `board` and a `player`:
- Iterate over all the possible winning lines (rows, columns, & diagonals)
  - For each line, check if that player already has 2 spots
  - If so, then return the spot that is empty

*Sub-Problems*:

### Creata a new board and update it with a square.

*Note*: We need to do this WITHOUT affecting the original board. This is difficult because we have a 2-d array, so a shallow copy is not enough.
Options:
- We could write a method to copy the board. (not ideal, but easiest)
- We could rewrite our methods such that board mutation doesn't occur. (too difficult)
- We could look at the problem in a different way that doesn't involve mutating the board. (too difficult -- requires too many conditionals & new methods)


# CODE

*Implementation Details*: