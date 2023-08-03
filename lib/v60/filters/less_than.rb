# frozen_string_literal: true

module V60::Filters
  class LessThan < BaseFilter
    def filter(obj)
      obj[@key] < @value
    end
  end
end
