module Kisoku
  class RuleConditionNotImplementedError < StandardError; end

  class RuleActionNotImplementedError < StandardError; end

  class Rule
    def condition
      raise RuleConditionNotImplementedError
    end

    def action(acc)
      raise RuleActionNotImplementedError
    end
  end
end
