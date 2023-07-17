# frozen_string_literal: true

module Kisoku::Filters
  class GreaterThan < BaseFilter
    def filter(set)
      set.select { |obj| obj[@key] > @value }
    end
  end
end
