module Kisoku
  class RuleConditionNotImplementedError < StandardError; end

  class RuleActionNotImplementedError < StandardError; end

  class Rule
    def condition(params={})
      raise RuleConditionNotImplementedError
    end

    def action(acc, params={})
      raise RuleActionNotImplementedError
    end
  end
end
