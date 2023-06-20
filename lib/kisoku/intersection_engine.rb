# frozen_string_literal: true

module Kisoku
  class IntersectionEngine
    def initialize(initial_set, rules)
      @initial_set = initial_set
      @rules = compile_rules(rules)
    end

    def run
      threads = []
      @rules.each do |rule|
        threads << Thread.new { rule.compute }
      end

      threads.map(&:value).inject(@initial_set, :&)
    end

    private

    def compile_rules(rules)
      rules.map do |rule|
        key = rule[0]
        operation = rule[1][0]
        operand = rule[1][1]

        IntersectionRule.new(@initial_set, operation, operand, key)
      end
    end
  end
end
