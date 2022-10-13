module Kisoku
  class NoRulesError < StandardError; end

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

    def run(state, params)
      raise NoRulesError if @rules.empty?
      applicable_rules = compute_conditions(params)
      results = compute_actions(state, applicable_rules, params)
      reduce(results)
    end

    def reduce(results)
      return results
    end

    private

    def compute_conditions(params)
      threads = []
      @rules.each do |rule|
        threads << Thread.new(rule, params) do |rule, params|
          Thread.current[:applicable?] = rule.condition(params)
          Thread.current[:rule] = rule
        end
      end

      applicable_rules = []

      threads.each do |thread|
        thread.join
        if thread[:applicable?]
          applicable_rules << thread[:rule]
        end
      end

      applicable_rules
    end

    def compute_actions(state, rules, params)
      return [state] if rules.empty?

      threads = []

      rules.each do |rule|
        threads << Thread.new(state, rule, params) do |state, rule, params|
          Thread.current[:output] = rule.action(state, params)
        end
      end

      threads.map do |thread|
        thread.join
        thread[:output]
      end
    end
  end
end
