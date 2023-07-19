# frozen_string_literal: true

module Kisoku
  class Engine
    def initialize(rules)
      @rules = rules
    end

    def run(set)
      sets = async_filter(set)
      async_reduce(sets)
    end

    private

    def async_filter(set)
      threads = []
      @rules.each do |rule|
        threads << Thread.new { rule.filter(set) }
      end
      threads.map(&:value)
    end

    def async_reduce(sets)
      while sets.length > 1
        threads = []
        sets.each_slice(2) do |tuple|
          threads << if tuple.length == 1
            Thread.new { tuple[0] }
          else
            Thread.new { tuple[0] & tuple[1] }
          end
        end

        sets = threads.map(&:value)
      end

      sets[0]
    end
  end
end
