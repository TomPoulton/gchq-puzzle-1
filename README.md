# GCHQ Puzzle 1

This is a ruby project to solve the first 2015 GCHQ Christmas puzzle

The image in `puzzle.png` shows the starting grid and patterns

To run the solution:
 * clone the project
 * cd into project directory
 * run `ruby bin/un_puzzle.rb`

Output should look like this:

```
@ @ @ @ @ @ @   @ @ @       @   @   @ @ @ @ @ @ @ 
@           @   @ @   @ @           @           @ 
@   @ @ @   @           @ @ @   @   @   @ @ @   @ 
@   @ @ @   @   @     @ @ @ @ @ @   @   @ @ @   @ 
@   @ @ @   @     @ @ @ @ @   @ @   @   @ @ @   @ 
@           @     @ @               @           @ 
@ @ @ @ @ @ @   @   @   @   @   @   @ @ @ @ @ @ @ 
                @ @ @       @ @ @                 
@   @ @   @ @ @     @   @   @ @ @   @     @   @ @ 
@   @             @ @ @   @ @         @       @   
  @ @ @ @   @   @ @ @ @   @ @   @         @ @     
  @   @       @       @   @   @ @ @ @   @   @ @ @ 
    @ @     @   @   @             @ @   @ @ @ @ @ 
      @ @ @   @ @   @ @   @ @ @ @ @ @   @ @ @   @ 
@   @ @ @ @ @ @ @ @ @   @   @     @ @         @   
  @ @   @     @ @       @ @   @ @ @           @   
@ @ @   @   @   @     @         @ @ @ @ @   @     
                @       @ @   @ @       @ @ @ @ @ 
@ @ @ @ @ @ @   @     @ @       @   @   @   @ @ @ 
@           @   @ @     @     @ @       @ @   @   
@   @ @ @   @       @ @ @ @     @ @ @ @ @     @   
@   @ @ @   @   @ @ @   @ @ @ @ @ @ @ @ @ @   @ @ 
@   @ @ @   @   @     @ @ @ @ @ @   @ @ @ @ @ @   
@           @     @ @             @   @   @ @     
@ @ @ @ @ @ @   @ @       @   @ @       @ @ @ @ @ 

Solved !!
```

If you want to see more output, set `debug` to `true` in `bin/un_puzzle.rb`

## Issues

Update: Fixed partial solution loop

The code isn't multi-threaded, and there are probably a whole bunch of optimisations to be made, but it solves this particular puzzle in ~4 seconds

The error handling isn't bulletproof 

## Other Grids

The code should be able to solve any grid of any size (given enough time :)) as long as the grid is encoded in the same way (i.e. using the patterns of filled-in sections)

The patterns and pre-filled cells are all stored in `puzzle.yml` so feel free to play

## Future

This code won't solve the puzzle if you omit the pre-filled cells and just start with an empty grid. In order to solve the puzzle in this case (and therefore be a complete solution for all puzzles), the code would need to create and traverse some kind of solutions tree, where it guesses a solution and tries to solve the puzzle, pruning all branches that result in an invalid solution
