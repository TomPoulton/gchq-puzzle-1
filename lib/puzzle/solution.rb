require_relative 'grid'

module Puzzle
  class Solution

    attr_reader :cells

    def initialize(cells)
      @cells = cells
    end

    def size
      @cells.size
    end

    def valid?(existing_cells)
      return false unless @cells.size == existing_cells.size
      @cells.each_with_index { |cell, i|
        if existing_cells[i] != Grid::EMPTY
          return false if existing_cells[i] != cell
        end
      }
      true
    end

  end
end