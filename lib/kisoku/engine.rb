# frozen_string_literal: true

module Kisoku
  class Engine
    def initialize(rules, reducer)
      @rules = rules
      @reducer = reducer
    end

    def run(set)
      sets = async_filter(set)
      @reducer.reduce(sets)
    end

    private

    def async_filter(set)
      threads = []
      @rules.each do |rule|
        threads << Thread.new { rule.filter(set) }
      end
      threads.map(&:value)
    end
  end
end
