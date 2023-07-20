# frozen_string_literal: true

module Kisoku::Reducers
  class Product
    def initialize(field:)
      @field = field
    end

    def reduce(sets)
      Kisoku::Reducers::Intersection.new.reduce(sets).inject(1) do |product, set|
        product * set[@field]
      end
    end
  end
end
