# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "v60"

class EqualToTest < MiniTest::Test
  def test_equal_to_filter
    equal_to_filter = V60::Filters::EqualTo.new(key: :genre, value: :horror)
    scary_book = {
      genre: :horror
    }
    sad_book = {
      genre: :literary_fiction
    }

    assert equal_to_filter.filter(scary_book)
    refute equal_to_filter.filter(sad_book)
  end
end
