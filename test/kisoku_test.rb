require "minitest/autorun"
require "kisoku"
require "date"

class KisokuTest < MiniTest::Test
  class ClubMemberRule < Kisoku::Rule
    def initialize(user)
      @user = user
    end

    def condition
      @user.club_member?
    end

    def action(acc)
      acc * 0.9
    end
  end

  class WeekendSaleRule < Kisoku::Rule
    def initialize(date)
      @date = date
    end

    def condition
      @date.saturday? || @date.sunday?
    end

    def action(acc)
      acc * 0.85
    end
  end

  class DiscountRulesEngine < Kisoku::RulesEngine
    def run
      super(1.0)
    end
  end

  def test_end_to_end_all_true
    user = MiniTest::Mock.new
    user.expect(:club_member?, true)
    date = MiniTest::Mock.new
    date.expect(:saturday?, true)

    rules_engine = DiscountRulesEngine.new
    rules_engine.add_rule ClubMemberRule.new(user)
    rules_engine.add_rule WeekendSaleRule.new(date)

    assert_equal 0.765, rules_engine.run
  end

  def test_end_to_end_some_true
    user = MiniTest::Mock.new
    user.expect(:club_member?, false)
    date = MiniTest::Mock.new
    date.expect(:saturday?, true)

    rules_engine = DiscountRulesEngine.new
    rules_engine.add_rule ClubMemberRule.new(user)
    rules_engine.add_rule WeekendSaleRule.new(date)

    assert_equal 0.85, rules_engine.run
  end

  def test_end_to_end_all_false
    user = MiniTest::Mock.new
    user.expect(:club_member?, false)
    date = MiniTest::Mock.new
    date.expect(:saturday?, false)
    date.expect(:sunday?, false)

    rules_engine = DiscountRulesEngine.new
    rules_engine.add_rule ClubMemberRule.new(user)
    rules_engine.add_rule WeekendSaleRule.new(date)

    assert_equal 1.0, rules_engine.run
  end
end
