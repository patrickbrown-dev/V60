# frozen_string_literal: true

module V60::Reducers
  class Sum
    def initialize(field:)
      @field = field
    end

    def reduce(sets)
      V60::Reducers::Intersection.new.reduce(sets).inject(0) do |sum, set|
        sum + set[@field]
      end
    end
  end
end
