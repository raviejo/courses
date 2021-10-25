class Octal
  def initialize(str)
    @str = octal?(str) ? str : ''
  end

  def to_decimal
    count = @str.length - 1
    decimal = 0
    @str.chars.each do |char|
      num = char.to_i
      decimal += num * (8 ** count)
      count -= 1
    end
    decimal
  end

  def octal?(str)
    !str.match?(/(8|9|\D)/)
  end
end