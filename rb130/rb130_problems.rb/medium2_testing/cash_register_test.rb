require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'transaction.rb'
require_relative 'cash_register.rb'

class CashRegisterTest < Minitest::Test
  def setup
    @register = CashRegister.new(200)
    @transaction = Transaction.new(25)
  end

  def test_accept_money
    @transaction.amount_paid = 25
    previous_amount = @register.total_money
    @register.accept_money(@transaction)
    current_amount = @register.total_money
    assert_equal(previous_amount + 25, @register.total_money)
  end

  def test_change
    @transaction.amount_paid = 30
    expexted_change = 30 - @transaction.item_cost
    actual_change = @register.change(@transaction)
    assert_equal expexted_change, actual_change
  end

  def test_give_receipt
    item_cost = 25
    expected_output = "You've paid $#{item_cost}.\n"
    assert_output(expected_output) do
      @register.give_receipt(@transaction)
    end
  end
end