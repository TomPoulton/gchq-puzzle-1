require_relative 'pattern'

module Puzzle
  class PatternCache

    def initialize(grid_size)
      @size = grid_size
      @patterns = {}
    end

    def get(sections)
      pattern_string = sections.to_s
      if @patterns.has_key? pattern_string
        pattern = @patterns[pattern_string]
      else
        pattern = Pattern.new sections, @size
        @patterns[pattern_string] = pattern
      end
      pattern
    end

  end
end