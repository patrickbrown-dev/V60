# frozen_string_literal: true

module V60::Reducers
  class Sum
    def initialize(key:)
      @key = key
    end

    def reduce(sets)
      sets.sum { |set| set[@key] }
    end
  end
end
