# frozen_string_literal: true

module V60::Filters
  class GreaterThan < BaseFilter
    def filter(obj)
      obj[@key] > @value
    end
  end
end
