# frozen_string_literal: true

require "minitest/autorun"
require "set"
require "v60"

class EngineTest < MiniTest::Test
  def test_readme_example
    set = Set.new(
      [
        {
          title: "Cheap Scary Book",
          genre: :horror,
          price: 9_00
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
        },
        {
          title: "Cheap Thrilling Book",
          genre: :thriller,
          price: 7_00
        }
      ]
    )

    engine = V60::Engine.new(
      filters: [
        V60::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
        V60::Filters::In.new(key: :genre, value: [:horror, :thriller])
      ],
      reducer: V60::Reducers::Sum.new(key: :price)
    )

    result = engine.run(set)

    assert_equal 9_00 + 7_00, result
  end
end
