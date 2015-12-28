require_relative 'solution'

module Puzzle
  class Pattern

    attr_reader :solutions

    def initialize(sections, grid_size)
      @sections = sections
      @grid_size = grid_size
      @solutions = generate_solutions
    end

    def valid_solutions(existing_cells)
      valid_solutions = []
      @solutions.each { |solution|
        valid_solutions.push solution if solution.valid? existing_cells
      }
      valid_solutions
    end

    def partial_solution(existing_cells)
      solutions = valid_solutions(existing_cells)
      partial_solution = solutions.first.cells.clone
      solutions.each { |solution|
        solution.cells.each_with_index { |cell, i|
          partial_solution[i] = nil unless partial_solution[i] == cell
        }
        # if the solution only contains nils then there's no partial solution, return nil
        return nil if partial_solution.compact.empty?
      }
      Solution.new partial_solution
    end

    def generate_solutions
      remaining_spaces = calculate_remaining_spaces
      if remaining_spaces == 0
        # only one possible solution
        combination = ints_from_zero(@sections.count)
        solutions = [combination_to_solution(combination, combination)]
      else
        # convert them all to solutions
        solutions = generate_all_solutions remaining_spaces
      end
      solutions
    end

    def calculate_remaining_spaces
      # Somehow sum all integers in array using #RubyVoodoo
      filled_cell_count = @sections.inject(:+)
      # At least one space is needed between sections
      implied_spaces_count = @sections.count - 1
      # return count of remaining spaces
      @grid_size - (filled_cell_count + implied_spaces_count)
    end

    def generate_all_solutions(remaining_spaces)
      solutions = []
      total_positions = remaining_spaces + @sections.count
      positions = ints_from_zero total_positions
      # combinations will contain all possible ways of arranging filled sections and empty cells
      combinations = positions.combination(@sections.count).to_a
      combinations.each { |combination|
        solutions.push combination_to_solution positions, combination
      }
      solutions
    end

    def combination_to_solution(positions, section_positions)
      cells = []
      positions.each { |position|
        section_index = section_positions.index position
        if section_index.nil?
          cells.push Grid::SPACE
        else
          filled_cells_count = @sections[section_index]
          filled_cells_count.times {
            cells.push Grid::FILLED
          }
          unless section_index == @sections.count - 1 # unless last section
            cells.push Grid::SPACE # add the implied space between sections
          end
        end
      }
      Solution.new cells
    end

    # e.g:
    # ints_from_zero(1) => [0]
    # ints_from_zero(2) => [0, 1]
    # ints_from_zero(3) => [0, 1, 2]
    def ints_from_zero(count)
      (0..count - 1).to_a
    end

    def to_s
      @sections.join ','
    end

  end
end