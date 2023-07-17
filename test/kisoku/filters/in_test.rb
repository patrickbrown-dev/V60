# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "kisoku"

class InTest < MiniTest::Test
  def test_in_filter
    in_filter = Kisoku::Filters::In.new(key: :genre, value: [:horror, :literary_fiction])
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

    result = in_filter.filter(set)

    assert_equal ["Scary Book", "Sad Book"], result.map { |e| e[:title] }
  end
end
