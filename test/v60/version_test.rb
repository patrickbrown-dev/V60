# frozen_string_literal: true

require "minitest/autorun"
require "v60"

class VersionTest < MiniTest::Test
  def test_version
    assert_equal "0.1.0", V60::VERSION
  end
end
