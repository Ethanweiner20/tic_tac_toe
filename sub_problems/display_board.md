# Display Board

# PROBLEM

*Explicit Requirements*:
- **Input**: A Board _board_
- **Output**: A display of the board, with rows and lines separated by horizontal bars, and borders

*Questions*:


*Implicit Requirements*:


*Mental Models*:


# EXAMPLES/TESTS

display_board(EMPTY_BOARD) ==>

|_|_|_|
|_|_|_|
|_|_|_|

display_board(BOARD_UNFINISHED) ==>

|X|_|O|
|_|_|_|
|O|X|X|

# DATA STRUCTURES



# ALGORITHM
- Iterate over the rows in the board
  - Display each row


*Sub-Problems*:

## Display a row

Given a Row _row_:
- Display a leading pipe |
- Iterate over the spots in the row
  - Display each spot in the row, followed by a pipe |
- Print a newline


# CODE

*Implementation Details*: