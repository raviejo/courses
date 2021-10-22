# 1. Boolean Assertions
# Write a minitest assertion that will fail if the value.odd? is not true.

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

class NoExperienceError < StandardError; end
class Employee
  def hire
    raise NoExperienceError
  end
end

class BooleanAssertions < Minitest::Test
  def test_boolean
    odds = [1, 3, 5, 7, 9, 233, 333, 1045, 505]
    odds.each { |odd| assert(odd.odd?, 'value is not odd') }
  end

  def test_downcase
    assert_equal('xyz', 'XYZ'.downcase)
  end

  def test_nil
    assert_nil nil
    assert_equal nil, [][1]
  end

  def test_empty_list
    assert [].empty?
    refute [1,2].empty?
    assert_empty []
  end

  def test_include_xyz
    assert_includes ['xyz'], 'xyz'
  end

  def test_raise_no_experience_error
    employee = Employee.new
    assert_raises('NoExperienceError') do
      employee.hire
    end
  end

  def test_value
    assert_instance_of Numeric, Numeric.new
  end

  def test_value_subclass
    assert_kind_of Numeric, 1
    assert_kind_of Numeric, Numeric.new
  end

  # describe 'list.process' do
  #   it 'is the same object' do
  #     _([]).must_equal []
  #   end
  # end

  # def test_list_process
  #   assert_same list list.process
  # end

  def test_exclude_xyz
    refute_includes [], ('xyz')
  end
end

