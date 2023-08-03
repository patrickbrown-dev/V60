# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "v60"

class LessThanOrEqualToTest < MiniTest::Test
  def test_lesss_than_or_equal_to_filter
    less_than_or_equal_to_filter = V60::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00)
    ten_dollar_book = {
      price: 10_00
    }
    expensive_book = {
      price: 10_01
    }
    cheap_book = {
      price: 9_99
    }

    assert less_than_or_equal_to_filter.filter(ten_dollar_book)
    assert less_than_or_equal_to_filter.filter(cheap_book)
    refute less_than_or_equal_to_filter.filter(expensive_book)
  end
end
