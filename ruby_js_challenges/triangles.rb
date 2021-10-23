class Triangle
  def initialize(s1, s2, s3)
    @sides = [s1, s2, s3]
    raise ArgumentError if check_sides
  end
  
  def check_sides
    no_size? ||
    negative_size? ||
    size_inequality?
  end
  
  def no_size?
    @sides.join.match(/000/)
  end
  
  def negative_size?
    @sides.any?(&:negative?)
  end
  
  def size_inequality?
    comparisons = []
    @sides.size.times do |n|
      first = @sides[n]
      rest = @sides.select.with_index { |_, idx| idx != n }
      comparisons << (rest.sum <= first)
    end
    comparisons.include?(true)
  end
  
  def kind
    if equilateral?
      'equilateral'
    elsif isoceles?
      'isosceles'
    else
      'scalene'
    end
  end
  
  def isoceles?
    @sides.uniq.size < 3
  end
  
  def equilateral?
    @sides.all? { |side| side == @sides.first }
  end
end

Triangle.new(2, 2, 2)