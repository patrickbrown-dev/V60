# frozen_string_literal: true

module V60
  class Engine
    def initialize(filters:, reducer:)
      @filters = filters
      @reducer = reducer
    end

    def run(set)
      filtered_set = async_filter(set)
      @reducer.reduce(filtered_set)
    end

    private

    def async_filter(set)
      set.select do |obj|
        @filters.all? do |filter|
          filter.filter(obj)
        end
      end
    end
  end
end
