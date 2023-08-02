# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "v60"

class GreaterThanTest < MiniTest::Test
  def test_greater_than_filter
    greater_than_filter = V60::Filters::GreaterThan.new(key: :price, value: 10_00)
    ten_dollar_book = {
      price: 10_00
    }
    expensive_book = {
      price: 10_01
    }
    cheap_book = {
      price: 9_99
    }

    assert greater_than_filter.filter(expensive_book)
    refute greater_than_filter.filter(ten_dollar_book)
    refute greater_than_filter.filter(cheap_book)
  end
end
