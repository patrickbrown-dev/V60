# frozen_string_literal: true

module V60::Filters
  class GreaterThan < BaseFilter
    def filter(set)
      set.select { |obj| obj[@key] > @value }
    end
  end
end
