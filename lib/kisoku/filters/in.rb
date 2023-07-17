# frozen_string_literal: true

module Kisoku::Filters
  class In < BaseFilter
    def filter(set)
      set.select { |obj| @value.any?(obj[@key]) }
    end
  end
end
