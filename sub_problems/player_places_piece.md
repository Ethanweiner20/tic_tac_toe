# Player Places Piece

# PROBLEM

*Explicit Requirements*:
- **Input**: The board
- **Side Effects**: The board is updated with the players move
- The player should only be able to place a piece that is not already filled in the board

*Questions*:
- What should the input format be for specifiying a square? A square #, or a row/column? (I went w/ square #)

*Implicit Requirements*:


*Mental Models*:


# ALGORITHM

- Retrieve the Square from the user
- Convert the Square to a Position on the board
- Update the board with the position

*Sub-Problems*:

## Retrieve a square from the user

- Initialize a square
- Loop
  - Prompt for a square #
  - Retrieve a square # as a string, & convert to an integer
  - Break from the loop if the square is a valid # & untaken
  - Otherwise, prompt for a square again
- Return the square

### Check if the square is valid

- Given a _square_ number and _board_:
- Determine if the following 2 conditions are true:
  - The square # is an Integer in the range [0, 9]
  - That position is unfilled in the board

#### Determine if a position is unfilled
- Given a _position_ and _board_
- Check to see if indexing into the board at that position gives a '_'

## Convert the square to a position on the board

Given a _square_:
- Divide the _square_ minus 1 by 3, and take note of the quotient and remainder
- The quotient represents the row #
- The remainder represents the column #
- Return the quotient and remainder as a 2-element array (Position format)

## Update the board with the position

Given a _board_, _position_, and _player_:
- Index into the board at the row and column specified by _position_
- Assign that index to the symbol for _player_ at that position

# CODE

*Implementation Details*: