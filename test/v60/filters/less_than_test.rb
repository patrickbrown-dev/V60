# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "v60"

class LessThanTest < MiniTest::Test
  def test_less_than_filter
    less_than_filter = V60::Filters::LessThan.new(key: :price, value: 10_00)
    ten_dollar_book = {
      price: 10_00
    }
    expensive_book = {
      price: 10_01
    }
    cheap_book = {
      price: 9_99
    }

    assert less_than_filter.filter(cheap_book)
    refute less_than_filter.filter(ten_dollar_book)
    refute less_than_filter.filter(expensive_book)
  end
end
