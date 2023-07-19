# frozen_string_literal: true

module Kisoku
  class Engine
    def initialize(initial_set, rules)
      @initial_set = initial_set
      @rules = rules
    end

    def run
      sets = @rules.map do |rule|
        rule.filter(@initial_set)
      end

      while sets.length > 1
        threads = []
        sets.each_slice(2) do |tuple|
          threads << async_intersection(tuple[0], tuple[1])
        end

        sets = threads.map(&:value)
      end

      sets[0]
    end

    private

    def async_intersection(set1, set2)
      Thread.new { set1 & set2 }
    end
  end
end
