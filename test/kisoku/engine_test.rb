# frozen_string_literal: true

require "minitest/autorun"
require "set"
require "kisoku"

class EngineTest < MiniTest::Test
  def test_intersection
    engine = Kisoku::Engine.new(
      [
        Kisoku::Filters::EqualTo.new(key: :author, value: "Stephen King"),
        Kisoku::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
        Kisoku::Filters::In.new(key: :genre, value: [:horror, :thriller])
      ],
      Kisoku::Reducers::Intersection.new
    )
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

    result = engine.run(set)

    assert_equal ["Cheap Scary Book", "Cheap Thrilling Book"], result.map { |e| e[:title] }
  end

  def test_sum
    engine = Kisoku::Engine.new(
      [
        Kisoku::Filters::EqualTo.new(key: :author, value: "Stephen King"),
        Kisoku::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
        Kisoku::Filters::In.new(key: :genre, value: [:horror, :thriller])
      ],
      Kisoku::Reducers::Sum.new(field: :price)
    )
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
          price: 6_99
        },
        {
          title: "Alternate Cheap Thrilling Book",
          genre: :thriller,
          author: "Not Stephen King",
          price: 7_99
        }
      ]
    )

    result = engine.run(set)

    assert_equal 6_99 + 9_99, result
  end

  def test_product
    engine = Kisoku::Engine.new(
      [
        Kisoku::Filters::EqualTo.new(key: :author, value: "Stephen King"),
        Kisoku::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
        Kisoku::Filters::In.new(key: :genre, value: [:horror, :thriller])
      ],
      Kisoku::Reducers::Product.new(field: :price)
    )
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
          price: 6_99
        },
        {
          title: "Alternate Cheap Thrilling Book",
          genre: :thriller,
          author: "Not Stephen King",
          price: 7_99
        }
      ]
    )

    result = engine.run(set)

    assert_equal 6_99 * 9_99, result
  end
end
