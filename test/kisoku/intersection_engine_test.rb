# frozen_string_literal: true

require "minitest/autorun"
require "kisoku"

class IntersectionEngineTest < MiniTest::Test
  def test_intersection_engine
    rules = {
      genre: [:==, :horror],
      price: [:<=, 10_00]
    }
    set = Set.new(
      [
        {
          title: "Cheap Scary Book",
          genre: :horror,
          price: 9_99
        },
        {
          title: "Expensive Scary Book",
          genre: :horror,
          price: 17_99
        },
        {
          title: "Cheap Sad Book",
          genre: :literary_fiction,
          price: 8_99
        }
      ]
    )
    engine = Kisoku::IntersectionEngine.new(set, rules)

    result = engine.run

    assert_equal ["Cheap Scary Book"], result.map { |e| e[:title] }
  end
end
