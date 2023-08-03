# frozen_string_literal: true

module V60::Filters
  class GreaterThanOrEqualTo < BaseFilter
    def filter(obj)
      obj[@key] >= @value
    end
  end
end
