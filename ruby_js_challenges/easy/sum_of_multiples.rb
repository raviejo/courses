class SumOfMultiples
  def self.to(num)
    SumOfMultiples.new(3, 5).to(num)
  end

  def initialize(*set)
    @set = set
  end

  def to(num)
    sum = 0
    (1...num).each do |n|
      sum += n if multiple_of_set(n)
    end
    sum
  end

  private

  def multiple_of_set(num)
    @set.any? do |set_num|
      num % set_num == 0
    end
  end
end