# frozen_string_literal: true

module Kisoku::Filters
  class LessThan < BaseFilter
    def filter(set)
      set.select { |obj| obj[@key] < @value }
    end
  end
end
