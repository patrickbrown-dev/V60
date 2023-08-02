# frozen_string_literal: true

require "minitest/spec"
require "minitest/autorun"
require "set"
require "v60"

class InTest < MiniTest::Test
  def test_in_filter
    in_filter = V60::Filters::In.new(key: :genre, value: [:horror, :literary_fiction])
    horror_book = {
      genre: :horror
    }
    literary_fiction_book = {
      genre: :literary_fiction
    }
    romance_book = {
      genre: :romance
    }

    assert in_filter.filter(horror_book)
    assert in_filter.filter(literary_fiction_book)
    refute in_filter.filter(romance_book)
  end
end
