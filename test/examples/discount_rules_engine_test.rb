require "minitest/autorun"
require "kisoku"
require "date"

class DiscountRulesEngineTest < MiniTest::Test
  class ClubMemberRule < Kisoku::Rule
    def condition(params)
      params[:user].club_member?
    end

    def action(acc, params)
      0.9
    end
  end

  class WeekendSaleRule < Kisoku::Rule
    def condition(params)
      params[:date].saturday? || params[:date].sunday?
    end

    def action(acc, params)
      0.85
    end
  end

  class DiscountRulesEngine < Kisoku::RulesEngine
    def run(params)
      super(1.0, params)
    end

    def reduce(results)
      results.inject(1.0) { |acc, result| acc * result }
    end
  end

  def test_end_to_end_all_true
    user = MiniTest::Mock.new
    user.expect(:club_member?, true)
    date = MiniTest::Mock.new
    date.expect(:saturday?, true)

    rules_engine = DiscountRulesEngine.new
    rules_engine.add_rule ClubMemberRule.new
    rules_engine.add_rule WeekendSaleRule.new

    assert_equal 0.765, rules_engine.run({user: user, date: date})
  end

  def test_end_to_end_some_true
    user = MiniTest::Mock.new
    user.expect(:club_member?, false)
    date = MiniTest::Mock.new
    date.expect(:saturday?, true)

    rules_engine = DiscountRulesEngine.new
    rules_engine.add_rule ClubMemberRule.new
    rules_engine.add_rule WeekendSaleRule.new

    assert_equal 0.85, rules_engine.run({user: user, date: date})
  end

  def test_end_to_end_all_false
    user = MiniTest::Mock.new
    user.expect(:club_member?, false)
    date = MiniTest::Mock.new
    date.expect(:saturday?, false)
    date.expect(:sunday?, false)

    rules_engine = DiscountRulesEngine.new
    rules_engine.add_rule ClubMemberRule.new
    rules_engine.add_rule WeekendSaleRule.new

    assert_equal 1.0, rules_engine.run({user: user, date: date})
  end
end
