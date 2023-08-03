# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "v60"

class GreaterThanOrEqualToTest < MiniTest::Test
  def test_greater_than_or_equal_to_filter
    greater_than_or_equal_to_filter = V60::Filters::GreaterThanOrEqualTo.new(key: :price, value: 10_00)

    ten_dollar_book = {
      price: 10_00
    }
    expensive_book = {
      price: 10_01
    }
    cheap_book = {
      price: 9_99
    }

    assert greater_than_or_equal_to_filter.filter(ten_dollar_book)
    assert greater_than_or_equal_to_filter.filter(expensive_book)
    refute greater_than_or_equal_to_filter.filter(cheap_book)
  end
end
