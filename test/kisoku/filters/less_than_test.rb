# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "kisoku"

class LessThanTest < MiniTest::Test
  def test_less_than_filter
    less_than_filter = Kisoku::Filters::LessThan.new(key: :price, value: 10_00)
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

    result = less_than_filter.filter(set)

    assert_equal ["Happy Book"], result.map { |e| e[:title] }
  end
end
