# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "kisoku"

class EqualToTest < MiniTest::Test
  def test_equal_to_filter
    equal_to_filter = Kisoku::Filters::EqualTo.new(key: :genre, value: :horror)
    set = Set.new(
      [
        {
          title: "Scary Book",
          genre: :horror
        },
        {
          title: "Sad Book",
          genre: :literary_fiction
        },
        {
          title: "Happy Book",
          genre: :romance
        }
      ]
    )

    result = equal_to_filter.filter(set)

    assert_equal ["Scary Book"], result.map { |e| e[:title] }
  end
end
