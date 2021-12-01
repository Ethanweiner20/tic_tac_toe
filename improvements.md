# Improvements

- Display the current score along with the board (to gauge where you're at) X
- Input validation X
   - Only whole #s for square #s
   - Play again input validation (be more specific)
- Generally code should speak for itself X
  - But data definitions made sense here
- Be careful with ! operator name: Only on directly destructive methods -- not those that simply call dstructive methods X
- Restructure the "result" data definition:
  - Use symbols to represent results
  - Readability > cleverness

# Notes

- Data definitions are good, but avoid comments. Try to write code that speaks for itself (i.e. good naming).
  - e.g. Instead of needing to use a data definition, if possible, try to create a data structure that speaks for itself
  - Code should ideally be readable at first glance
- Be more explicit w/ input validation in the future.
- Method suffixes (e.g. ! or ?) should only be applied to the methods that directly apply.
- Advantage of using a hash: More explicit than nested arrays

# Main Takeaways (Reponse)

- Try to write code that can be read for itself, w/o the need for clarification, like data definitions. Sometimes, there's no way around this, but if it's possible to be explicit in code, that's better.
  - e.g. I can see how symbols help to give particular names/data more meaning -- as opposed to using strings, which could just be arbitrary, non-unique values, in a meaningful way
- Put me into the perspective of someone reading my code
  - I think my code was understandable
  - But by being more explicit, and structuring it such that clarifications are unnecessary, I can save the reader time and energy, and just write better all-around code