module Kisoku
  class RulesEngine
    def initialize
      @rules = []
    end

    def add_rule(rule)
      @rules << rule
    end

    def get_rules
      @rules
    end

    def run(initial_value, params)
      @rules
        .select { |rule| rule.condition(params) }
        .inject(initial_value) { |acc, rule| rule.action(acc, params) }
    end
  end
end
