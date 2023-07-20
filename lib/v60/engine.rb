# frozen_string_literal: true

module V60
  class Engine
    def initialize(filters, reducer)
      @filters = filters
      @reducer = reducer
    end

    def run(set)
      sets = async_filter(set)
      @reducer.reduce(sets)
    end

    private

    def async_filter(set)
      threads = []
      @filters.each do |filter|
        threads << Thread.new { filter.filter(set) }
      end
      threads.map(&:value)
    end
  end
end
