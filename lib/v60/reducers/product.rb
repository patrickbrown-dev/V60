# frozen_string_literal: true

module V60::Reducers
  class Product
    def initialize(key:)
      @key = key
    end

    def reduce(sets)
      sets.inject(1) { |product, set| product * set[@key] }
    end
  end
end
