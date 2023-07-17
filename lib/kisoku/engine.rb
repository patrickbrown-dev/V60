# frozen_string_literal: true

module Kisoku
  class Engine
    def initialize(initial_set, rules)
      @initial_set = initial_set
      @rules = rules
    end

    def run
      @rules.inject(@initial_set) do |set, rule|
        set & rule.async.filter(set).value
      end
    end
  end
end
