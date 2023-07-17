# frozen_string_literal: true

module Kisoku
  class IntersectionRule
    def initialize(initial_set, filter)
      @filter = filter.filter
      @initial_set = initial_set
    end

    def compute
      @filter.call(@initial_set)
    end
  end
end
