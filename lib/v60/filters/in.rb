# frozen_string_literal: true

module V60::Filters
  class In < BaseFilter
    def filter(set)
      set.select { |obj| @value.any?(obj[@key]) }
    end
  end
end
