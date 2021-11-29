# Tic Tac Toe Minimax

# Minimiax Notes

- Goal: Minimize the maximum "score" (best strategy) that the next player can get
  - In simple terms: Minimize the best strategy that the next player will have
- Position evaluation function
  - Higher points for states closer to winning
  - Assign a win for COMPUTER to +1 and a win for USER to -1
- The next state the player chooses should be the one that MAXIMIZES 

How does minimax work?

Goal = Make player A win

Assumes that player A and player B play every move optimally

Chooses the path that gives player A the best chances of winning, DESPITE player B playing the path that gives IT the best chances of winning

# PROBLEM

*Explicit Requirements*:
- **Input**: A `board` and a `player` (current turn)
- **Output**: The `square` that `player` should pick

*Questions*:


*Implicit Requirements*:


*Edge Cases*:



*Mental Models*:


# EXAMPLES/TESTS

(Draw on separate sheet)

puts computer_choice(board) # => 7
puts minimax_score(BOARD_ROW_LOSS, COMPUTER) == 1
puts minimax_score(BOARD_ROW_WIN, COMPUTER) == -1
puts minimax_score(BOARD_DIAGONAL_WIN, COMPUTER) == -1
puts minimax_score(BOARD_TIED, COMPUTER) == 0

# DATA STRUCTURES



# ALGORITHM

*Notes*:
- Hardcoded (base case) minimax scores:
  - 1 => win
  - 0 => tie
  - -1 => loss

## Problem 1: Determine which square a player should play
Given a `board` and a `player`:
- Determine the remaining `squares` player can `play`
- Compute the opponent score for every board copy with a square appended to it
- Choose the square w/ the lowest opponent score

## Problem 2: Determine the score for a particular board state

Given a `board` and a `player` whose turn it currently is:
- Determine the remaining `squares` player can `play`
- Initialize an `opponent_scores` hash to keep track of the scores of `squares`
- If the board is a winning board, return 1
- If the board is a losing board, return -1
- If the board is a tied board, return 0
- Otherwise, iterate over each `square` in `squares`:
  - Place the square on a copy of the board `board_copy`
  - [Recursive] Compute the `opponent_score` for that `board_copy` with the alternate `player` 
  - Add the square & its score to the hash
- Return a score w/ the minimum `opponent_score`
  - Randomly select from the minimum scores

## Problem 2: Determine just the score for a given player and board state

Given a `board` and a `player` whose turn it currently is:
- Determine the remaining `squares` player can `play`
- Create a copy of the `board` (`board_copy`)
- Initialize a `scores` array to keep track of the scores of `squares`
- If the board is a winning board, return 1
- If the board is a losing board, return -1
- If the board is a tied board, return 0
- Otherwise, iterate over each `square` in `squares`:
  - Place the square on the `board_copy`
  - [Recursive] Compute the score for that `board_copy`
  - Add the square & its score to the hash
- If the `player` is the COMPUTER, return the maximum opponent score (wants to maximize the score)
- If the `player` is the USER, return the minimum opponent score (wants to minimize the score)


*Sub-Problems*:




# CODE

*Implementation Details*: