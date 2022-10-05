require "minitest/autorun"
require "kisoku"

class SearchRulesEngineTest < MiniTest::Test
  class RatingGreaterThanRule < Kisoku::Rule
    def initialize
      # This could be a call to a database or a REST API.
      @ratings_service = {
        "0" => 4.5,
        "1" => 3.5,
        "2" => 2.0,
        "3" => 5.0,
        "4" => 1.5,
        "5" => 3.0
      }
    end

    def condition(params)
      params.include?(:rating_greater_than)
    end

    def action(acc, params)
      acc.select do |product_id|
        @ratings_service[product_id] > params[:rating_greater_than]
      end
    end
  end

  class GenreFilterRule < Kisoku::Rule
    def initialize
      # This could be a call to a database or a REST API.
      @ratings_service = {
        "0" => :speculative_fiction,
        "1" => :speculative_fiction,
        "2" => :horror,
        "3" => :horror,
        "4" => :mystery,
        "5" => :mystery
      }
    end

    def condition(params)
      params.include?(:genre)
    end

    def action(acc, params)
      acc.select do |product_id|
        @ratings_service[product_id] == params[:genre]
      end
    end
  end

  def setup
    @product_ids = ["0", "1", "2", "3", "4", "5"]
    @params = {
      rating_greater_than: 3.5,
      genre: :horror
    }
    @subject = Kisoku::RulesEngine.new
  end

  def test_no_rules_filter_nothing
    result = @subject.run(@product_ids, @params)

    assert_equal @product_ids, result
  end

  def test_rule_filter_limits_search_result
    @subject.add_rule(GenreFilterRule.new)

    result = @subject.run(@product_ids, @params)

    assert_equal ["2", "3"], result
  end

  def test_multiple_rules_apply_filters
    @subject.add_rule(RatingGreaterThanRule.new)
    @subject.add_rule(GenreFilterRule.new)

    result = @subject.run(@product_ids, @params)
    expect = ["3"]

    assert_equal expect, result
  end
end
