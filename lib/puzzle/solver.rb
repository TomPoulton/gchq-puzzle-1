require_relative 'grid'
require_relative 'solution'

module Puzzle
  class Solver

    def solve(grid, debug = false)

      @grid = grid
      @debug = debug
      puts 'Solving grid ...'

      # loop until solved or impossible:
      while true
        found = false
        log 'Start pass'
        log @grid.to_s

        # Find all quick row and column solutions
        # vector can be a Row or a Column
        @grid.unsolved_vectors.each { |vector|
          valid_solutions = vector.valid_solutions
          next unless valid_solutions.count == 1
          vector.solve valid_solutions.first
          found = true
          log "Solved #{vector.name}"
        }
        next if found

        # Insert partial solutions
        @grid.unsolved_vectors.each { |vector|
          partial_solution = vector.partial_solution
          next if partial_solution.nil?
          vector.solve_partial partial_solution
          found = true
          log "Partially solved #{vector.name}"
        }
        next if found

        # The cross test logic isn't used by this specific puzzle,
        # but if you uncomment the 'next if found' line above it will get used
        # Sort rows and columns by likelihood of finding match
        unsolved_vectors = @grid.unsolved_vectors.sort_by! { |vector|
          vector.valid_solutions.count
        }
        unsolved_vectors.each { |vector|
          log "Cross testing solutions for #{vector.name}"
          next unless valid_vector_solutions(vector).count == 1
          vector.solve vector.valid_solutions.first
          found = true
          log "Solved #{vector.name} using cross testing"
          break # don't try and solve them all at once
        }

        if @grid.unsolved_vectors.count == 0
          puts @grid.to_s
          puts 'Solved !!'
          exit 0
        end
        unless found
          puts @grid.to_s
          puts 'Error: no more solutions'
          exit 1
        end

      end

    end

    private

    # The following logic cross tests each potential solution against all vectors in alternate dimension
    # (e.g. insert potential row solution and then test all columns)
    # If any vector in the alternate dimension returns no valid solutions,
    # then the solution being tested can't be valid
    def valid_vector_solutions(vector)
      solutions = []
      vector.valid_solutions.each { |solution|
        test_grid = @grid.copy
        # get row/column by index and solve with solution
        if vector.is_a? Row
          test_vector = test_grid.rows[vector.index]
          alt_vectors = test_grid.columns
        else
          test_vector = test_grid.columns[vector.index]
          alt_vectors = test_grid.rows
        end
        test_vector.solve solution
        valid = true
        alt_vectors.each { |alt_vector|
          next unless alt_vector.valid_solutions.count == 0
          valid = false
          break
        }
        solutions.push solution if valid
      }
      solutions
    end

    def log(message)
      puts message if @debug
    end

  end
end
