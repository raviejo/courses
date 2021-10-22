require "minitest/autorun"
require "minitest/reporters"
require "stringio"
Minitest::Reporters.use!

require_relative 'transaction'

class TransactionTest < Minitest::Test
  def setup
    @transaction = Transaction.new(15)
  end

  def test_prompt_for_payment
    input = StringIO.new("25\n")
    output = StringIO.new
    @transaction.prompt_for_payment(input: input, output: output)
    assert_equal(25, @transaction.amount_paid)
  end

  def test_prompt_for_invalid_payment
    user_payment = StringIO.new("10\n" + "15\n")
    assert_output(/That is not the correct amount/) do
      @transaction.prompt_for_payment(input: user_payment)
    end
    assert_equal 15, @transaction.amount_paid
  end
end

