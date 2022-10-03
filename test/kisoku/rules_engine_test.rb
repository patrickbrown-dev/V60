require "minitest/autorun"
require "kisoku"

class RuleEngineTest < MiniTest::Test
  def setup
    @subject = Kisoku::RulesEngine.new
    @mock_rule = MiniTest::Mock.new
  end

  def test_add_rule
    @subject.add_rule(@mock_rule)

    assert_includes @subject.get_rules, @mock_rule
  end

  def test_run_with_no_rules
    assert_equal :identity, @subject.run(:identity)
  end

  def test_run_with_rules
    @mock_rule.expect(:condition, true, [{}])
    @mock_rule.expect(:action, nil, [nil, {}])
    @subject.add_rule(@mock_rule)

    @subject.run(nil)

    @mock_rule.verify
  end

  def test_rule_should_not_have_action
    @mock_rule.expect(:condition, false, [{}])
    @subject.add_rule(@mock_rule)

    @subject.run(nil)

    @mock_rule.verify
  end
end
