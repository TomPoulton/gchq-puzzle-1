require_relative 'pattern'
require_relative 'pattern_cache'
require_relative 'vectors'

module Puzzle
   class Grid

     FILLED = 1
     SPACE  = 0
     EMPTY  = nil

     attr_reader :size, :rows, :columns, :cells

     # @cells is a 2D array with columns within rows:
     # @cells[row_index][column_index]

     def get(column, row)
       @cells[row][column]
     end

     def set(column, row, value)
       @cells[row][column] = value
     end

     # squares is an array of x,y co-ords
     def fill(squares)
       squares.each { |square|
         set(square[0], square[1], FILLED)
       }
     end

     def unsolved_vectors
       unsolved_rows.concat(unsolved_columns)
     end

     def unsolved_rows
       @rows.select { |row| !row.solved? }
     end

     def unsolved_columns
       @columns.select { |column| !column.solved? }
     end

     def print
       rows = @cells.map { |row|
         row_symbols = row.map { |cell|
           case cell
             when FILLED then '@ '
             when SPACE then  '  '
             when EMPTY then  '. '
             else abort "Invalid cell value: #{cell}"
           end
         }
         row_symbols.join('')
       }
       "\n#{rows.join("\n")}\n"
     end

     def copy
       # Don't recreate Pattern objects, but create new Row/Column objects
       cells = @size.times.map { |r|
         @cells[r].clone
       }
       Grid.new(@size, cells, @row_patterns, @column_patterns)
     end

     def self.create(size, row_patterns, column_patterns)
       cells = size.times.map {
         Array.new(size, EMPTY)
       }
       pattern_cache = PatternCache.new size
       r_patterns = row_patterns.map {|pattern| pattern_cache.get pattern }
       c_patterns = column_patterns.map {|pattern| pattern_cache.get pattern }
       Grid.new(size, cells, r_patterns, c_patterns)
     end

     private

     def initialize(size, cells, row_patterns, column_patterns)
       # ToDo: validate row_patterns and column_patterns size
       @size = size
       @cells = cells
       @row_patterns = row_patterns
       @column_patterns = column_patterns
       @rows = row_patterns.map.with_index { |pattern, i| Row.new self, i, pattern }
       @columns = column_patterns.map.with_index { |pattern, i| Column.new self, i, pattern }
     end

   end
end
