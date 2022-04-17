# player_test.rb
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'player'

class PlayerTest < MiniTest::Test

  def setup
    @initial_health = 100
    @player = Player.new("john", @initial_health)
    @default_player = Player.new("jane")
  end

  def test_name_is_capitalized
    assert_equal('John', @player.name)
  end

  def test_health
    assert_equal(@initial_health, @player.health)
    assert_equal(50, @default_player.health)
  end

  def test_to_s
    assert_equal("I'm John with health = 100.", @player.to_s)
    @player.health = -1
    assert_equal("I was John, now I am dead :(.", @player.to_s)
  end

  def test_raises_error
    @player.health = -1
    assert_raises(NoMethodError) { @player.boost }
    assert_raises(NoMethodError) { @player.hurt }
  end

  def test_boost
    @player.boost
    assert_equal(@initial_health + 20, @player.health)
  end

  def test_hurt
    @player.hurt
    assert_equal(@initial_health - 10, @player.health)
  end

  def test_dead?
    @player.health = -1
    assert(@player.dead?)
  end
end