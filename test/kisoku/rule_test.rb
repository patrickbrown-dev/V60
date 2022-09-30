require "minitest/autorun"
require "kisoku"

class RuleTest < MiniTest::Test
  def setup
    @subject = Kisoku::Rule.new
  end

  def test_condition_raises_exception
    assert_raises Kisoku::RuleConditionNotImplementedError do
      @subject.condition
    end
  end

  def test_action_raises_exception
    assert_raises Kisoku::RuleActionNotImplementedError do
      @subject.action(nil)
    end
  end
end
