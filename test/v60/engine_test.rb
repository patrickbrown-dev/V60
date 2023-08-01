# frozen_string_literal: true

require "minitest/autorun"
require "set"
require "v60"

class EngineTest < MiniTest::Test
  def test_intersection
    engine = V60::Engine.new(
      filters: [
        V60::Filters::EqualTo.new(key: :author, value: "Stephen King"),
        V60::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
        V60::Filters::In.new(key: :genre, value: [:horror, :thriller])
      ],
      reducer: V60::Reducers::Intersection.new
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
    engine = V60::Engine.new(
      filters: [
        V60::Filters::EqualTo.new(key: :author, value: "Stephen King"),
        V60::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
        V60::Filters::In.new(key: :genre, value: [:horror, :thriller])
      ],
      reducer: V60::Reducers::Sum.new(field: :price)
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
    engine = V60::Engine.new(
      filters: [
        V60::Filters::EqualTo.new(key: :author, value: "Stephen King"),
        V60::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
        V60::Filters::In.new(key: :genre, value: [:horror, :thriller])
      ],
      reducer: V60::Reducers::Product.new(field: :price)
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
