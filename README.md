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

There are some issues with the code. For example if you provide an empty array for the pre-filled cells then the code will just loop, always finding the same partial solution for the same set of rows and columns. Something to work on later

The code isn't multi-threaded, and there are probably a whole bunch of optimisations to be made, but it solves this particular puzzle in ~4 seconds

The error handling also isn't bulletproof

## Other Grids

The code should be able to solve any grid of any size (given enough time :)) as long as the grid is encoded in the same way using the patterns of filled-in sections

The patterns and pre-filled cells are all stored in `puzzle.yml` so feel free to play (although bear in mind caveat above)
