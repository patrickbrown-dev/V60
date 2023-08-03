# frozen_string_literal: true

require "minitest/autorun"
require "minitest/benchmark"
require "set"
require "v60"

class EngineBenchmark < MiniTest::Benchmark
  def self.bench_range
    bench_exp 1, 100_000
  end

  def bench_engine
    set = Set.new

    genres = [:horror, :thriller, :literary_fiction, :fantasy]
    authors = [
      "Stephen King",
      "J. R. R. Tolkien",
      "Agatha Christie",
      "N. K. Jemisin",
      "Dr. Seuss",
      "Ursla K. Le Guin",
      "J. D. Salinger",
      "R. F. Kuang"
    ]

    assert_performance_linear 0.9999 do |n|
      n.times do |i|
        set << {
          title: "Book #{i}",
          genre: genres.sample,
          author: authors.sample,
          price: rand(1_00..20_00),
          year: rand(1900..2023)
        }
      end

      engine = V60::Engine.new(
        filters: [
          V60::Filters::LessThan.new(key: :year, value: 2010),
          V60::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
          V60::Filters::In.new(key: :genre, value: [:horror, :thriller]),
          V60::Filters::In.new(key: :author, value: ["Stephen King", "Dr. Seuss", "J. D. Salinger", "R. F. Kuang"]),
          V60::Filters::GreaterThanOrEqualTo.new(key: :year, value: 2000),
        ],
        reducer: V60::Reducers::Sum.new(key: :price)
      )

      engine.run(set)
    end
  end
end
