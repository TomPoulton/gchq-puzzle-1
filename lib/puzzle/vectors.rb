require_relative 'grid'
require_relative 'pattern'
require_relative 'solution'

module Puzzle

  class Vector

    attr_reader :index, :pattern

    def initialize(grid, index, pattern)
      @grid = grid
      @index = index
      @pattern = pattern
      @solved = false
    end

    def name
      "#{self.class.name.split('::').last} #{@index}"
    end

    def valid_solutions
      @pattern.valid_solutions cells
    end

    def partial_solution
      @pattern.partial_solution cells
    end

    def cells
      raise StandardError, 'Not implemented, Dimension is an abstract class'
    end

    def solve(solution)
      validate_cells solution.cells
      abort "Solution for #{name} contains empty cells" if solution.cells.include? Grid::EMPTY
      set_cells solution.cells
      @solved = true
    end

    def solve_partial(solution)
      validate_cells solution.cells
      set_cells solution.cells
    end

    def validate_cells(cells)
      abort "Solution for #{name} size does not match grid size" unless cells.size == @grid.size
    end

    def set_cells(cells)
      raise StandardError, 'Not implemented, Dimension is an abstract class'
    end

    def solved?
      @solved
    end

  end

  class Row < Vector
    def initialize(grid, index, pattern)
      super(grid, index, pattern)
    end

    def cells
      @grid.cells[@index]
    end

    def set_cells(cells)
      cells.each_with_index { |cell, i|
        @grid.set(i, @index, cell) unless cell.nil?
      }
    end
  end

  class Column < Vector
    def initialize(grid, index, pattern)
      super(grid, index, pattern)
    end

    def cells
      @grid.cells.map { |row|
        row[index]
      }
    end

    def set_cells(cells)
      cells.each_with_index { |cell, i|
        @grid.set(@index, i, cell) unless cell.nil?
      }
    end
  end

end