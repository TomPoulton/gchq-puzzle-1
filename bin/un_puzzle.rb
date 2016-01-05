require 'YAML'
require_relative '../lib/puzzle/grid'
require_relative '../lib/puzzle/solver'

puts 'Creating grid ...'
debug = false
puzzle = YAML.load_file File.expand_path('../../puzzle.yml', __FILE__)

row_patterns = puzzle['row-patterns']
column_patterns = puzzle['column-patterns']
filled_cells = puzzle['filled-cells'] || []
grid_size = row_patterns.count

grid = Puzzle::Grid.create(grid_size, row_patterns, column_patterns)
grid.fill(filled_cells)
puts grid.to_s

Puzzle::Solver.new.solve grid, debug
