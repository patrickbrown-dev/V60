# frozen_string_literal: true

module Kisoku::Filters
  class BaseFilter
    def initialize(key:, value:)
      @key = key
      @value = value
    end

    def filter
      raise NotImplementedError
    end
  end
end
