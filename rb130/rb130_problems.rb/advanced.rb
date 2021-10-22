# 1. Enumerable
class MyEnumerator
  include Enumerable
  def initialize(size = nil, &block)
    @yielder = Array.new
    @size = size
    @block = block
  end

  def produce(initial = nil, &block)
    loop do
      initial = block.call(initial)
    end
  end

  def take(num)
    num.times { @block.call(@yielder) }
    @ary.dup
  end

end