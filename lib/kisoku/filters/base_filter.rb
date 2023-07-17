# frozen_string_literal: true

require "concurrent"

module Kisoku::Filters
  class BaseFilter
    include Concurrent::Async

    def initialize(key:, value:)
      @key = key
      @value = value
    end

    def filter
      raise NotImplementedError
    end
  end
end
