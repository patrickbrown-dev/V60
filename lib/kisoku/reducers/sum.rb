# frozen_string_literal: true

module Kisoku::Reducers
  class Sum
    def initialize(field:)
      @field = field
    end

    def reduce(sets)
      Kisoku::Reducers::Intersection.new.reduce(sets).inject(0) do |sum, set|
        sum + set[@field]
      end
    end
  end
end
