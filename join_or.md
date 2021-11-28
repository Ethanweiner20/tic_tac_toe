# Join Or

# PROBLEM

*Explicit Requirements*:
- **Input**: An array of `numbers`, an optional `delimiter` (default = ', '), and an optional `joining_word` (default = 'or')
- **Output**: A string joining the `numbers` using the `delimter` and `joining_word`

*Questions*:


*Implicit Requirements*:
- [1 element] Just print the element
- [2 elements] Join w/ joining word
- [3 elements] Join w/ delimiter AND joining word

*Edge Cases*:
Look above


*Mental Models*:


# EXAMPLES/TESTS

joinor([1]) == "1"
joinor([1, 2])                   # => "1 or 2"
joinor([1, 2, 3])                # => "1, 2, or 3"
joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"

# DATA STRUCTURES



# ALGORITHM



*Sub-Problems*:




# CODE

*Implementation Details*: