require "minitest/autorun"
require "kisoku"

class RuleEngineTest < MiniTest::Test
  def setup
    @subject = Kisoku::RulesEngine.new
    @mock_rule = MiniTest::Mock.new
    @params = {shirt: "t-shirt", pants: "jeans"}
  end

  def test_add_rule
    @subject.add_rule(@mock_rule)

    assert_includes @subject.get_rules, @mock_rule
  end

  def test_run_with_no_rules
    assert_raises(Kisoku::NoRulesError) do
      @subject.run(:identity, @params)
    end
  end

  def test_run_with_rules
    @mock_rule.expect(:condition?, true) { |params| params == @params }
    @mock_rule.expect(:action, 2) do |state, params|
      state == :foo && params == @params
    end
    @subject.add_rule(@mock_rule)

    result = @subject.run(:foo, @params)

    @mock_rule.verify
    assert_equal [2], result
  end

  def test_rule_should_not_have_action
    @mock_rule.expect(:condition?, false) { |params| params == @params }
    @subject.add_rule(@mock_rule)

    result = @subject.run(nil, @params)

    @mock_rule.verify
    assert_equal [nil], result
  end
end
