## Board Status

# GENERAL IDEAS

- How to determine the status of a board?
- How to determine a winning board?
  - The Xs or Os must match a particular sequence
    - The entire row is a winner 
    - A column is a winner (the same index of each row)
    - Check for the 2 diagonals 0-1-2 or 2-1-0
    - Individual helper methods for each...

# PROBLEM

*Explicit Requirements*:
- **Input**: _board_ and the _player_
- **Output**: 

*Questions*:


*Implicit Requirements*:


*Mental Models*:


# EXAMPLES/TESTS



# DATA STRUCTURES



# ALGORITHM

- Did a player win?
- If not: Is the board a full board (tie)?
- Otherwise, the game is unfinished

*Sub-Problems*:

## Determine the player who won

- Given the _board_:
- Iterate through every row
  - If any row contains all user spots or all computer spots, return that spot
- Iterate through every column
  - If any column contains all user spots or all computer spots, return that spot
- Iterate through every diagonal
  - If any diagonal contains all user spots or all computer spots, return that spot

## Determine if the board is full

Given a _board_:
- If none of the positions are the empty spot ('_'), the board is full


# CODE

*Implementation Details*:
- #any? might come in handy for finding winners...