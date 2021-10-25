class PerfectNumber
  def self.classify(num)
    raise StandardError if num.negative?
    sum = divisors(num).sum

    if sum > num
      'abundant'
    elsif sum < num
      'deficient'
    else
      'perfect'
    end
  end

  class << self
    private
    def divisors(number)
      result = []
      subtracted = number - 1
      until subtracted.zero?
        if (number % subtracted).zero?
          result << subtracted
        end
        subtracted -= 1
      end
      result
    end
  end
end