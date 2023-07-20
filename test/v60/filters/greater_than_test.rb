# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "v60"

class GreaterThanTest < MiniTest::Test
  def test_greater_than_filter
    greater_than_filter = V60::Filters::GreaterThan.new(key: :price, value: 10_00)
    set = Set.new(
      [
        {
          title: "Scary Book",
          price: 10_00
        },
        {
          title: "Sad Book",
          price: 10_01
        },
        {
          title: "Happy Book",
          price: 9_99
        }
      ]
    )

    result = greater_than_filter.filter(set)

    assert_equal ["Sad Book"], result.map { |e| e[:title] }
  end
end
