# frozen_string_literal: true

require "minitest/autorun"
require "set"
require "kisoku"

class EngineTest < MiniTest::Test
  def test_engine
    rules = [
      Kisoku::Filters::EqualTo.new(key: :author, value: "Stephen King"),
      Kisoku::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
      Kisoku::Filters::In.new(key: :genre, value: [:horror, :thriller])
    ]
    set = Set.new(
      [
        {
          title: "Cheap Scary Book",
          genre: :horror,
          author: "Stephen King",
          price: 9_99
        },
        {
          title: "Expensive Scary Book",
          genre: :horror,
          author: "Stephen King",
          price: 17_99
        },
        {
          title: "Cheap Sad Book",
          genre: :literary_fiction,
          author: "Stephen King",
          price: 8_99
        },
        {
          title: "Cheap Thrilling Book",
          genre: :thriller,
          author: "Stephen King",
          price: 9_99
        },
        {
          title: "Alternate Cheap Thrilling Book",
          genre: :thriller,
          author: "Not Stephen King",
          price: 9_99
        }
      ]
    )
    engine = Kisoku::Engine.new(rules)

    result = engine.run(set)

    assert_equal ["Cheap Scary Book", "Cheap Thrilling Book"], result.map { |e| e[:title] }
  end
end
