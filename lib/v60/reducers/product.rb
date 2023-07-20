# frozen_string_literal: true

module V60::Reducers
  class Product
    def initialize(field:)
      @field = field
    end

    def reduce(sets)
      V60::Reducers::Intersection.new.reduce(sets).inject(1) do |product, set|
        product * set[@field]
      end
    end
  end
end
