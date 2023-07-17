# frozen_string_literal: true

module Kisoku::Filters
  class EqualTo < BaseFilter
    def filter(set)
      set.select { |obj| obj[@key] == @value }
    end
  end
end
