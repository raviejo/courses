require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!

require_relative "text"

class TestTest < Minitest::Test
  def setup
    @file = File.open('sample_text.txt', 'r')
    @file_text = @file.read
    @text = Text.new(@file_text)
  end

  def test_swap
    expected = @file_text.gsub('a', 'e')
    assert_equal expected, @text.swap('a', 'e')
  end

  def test_word_count
    expected = @file_text.split.count
    assert_equal expected, @text.word_count
  end

  def teardown
    @file.close
  end
end
