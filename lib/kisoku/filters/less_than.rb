# frozen_string_literal: true

module Kisoku::Filters
  class LessThan
    attr_reader :filter

    def initialize(key:, value:)
      @filter = ->(set) { set.select { |obj| obj[key] < value } }
    end
  end
end
