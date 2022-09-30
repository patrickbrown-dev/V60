require "minitest/autorun"
require "kisoku"

class VersionTest < MiniTest::Test
  def test_version
    assert_equal "0.1.0", Kisoku::VERSION
  end
end
