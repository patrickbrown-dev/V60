# frozen_string_literal: true

module V60::Filters
  class EqualTo < BaseFilter
    def filter(obj)
      obj[@key] == @value
    end
  end
end
