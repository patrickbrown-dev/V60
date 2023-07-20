# frozen_string_literal: true

module V60::Filters
  class LessThanOrEqualTo < BaseFilter
    def filter(set)
      set.select { |obj| obj[@key] <= @value }
    end
  end
end
