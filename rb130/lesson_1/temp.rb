# in temp.rb
require 'minitest/autorun'

class MyFirstTest < Minitest::Test
  def test_first_test
    assert true
  end
end


class Astronaut

  module Badge
    def badge
      "US"
    end
  end

  # include Astronaut::Badge

  def initialize(name)
    @name = name
    @badge =
  end

end


bobby = Astronaut.new("Robert")

p bobby