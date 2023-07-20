# frozen_string_literal: true

module V60::Filters
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
