class RomanNumeral
  CONVERSION_TABLE = {
    1000 => "M",
    500 => "D",
    100 => "C",
    50 => "L",
    10 => "X",
    5 => "V",
    1 => "I"
  }

  SUBTRACTABLE = [1, 10, 100]

  def initialize(number)
    @number = number
  end

  # def to_roman
  #   roman_conversion = ''
  #   CONVERSION_TABLE.each do |num, roman|
  #     if num < @number
  #       roman_conversion += roman * @number.divmod(num).first
  #       @number -= num * @number.divmod(num).first
  #     end
  #   end
  #   roman_conversion
  # end

  def to_roman
    conversion_keys = CONVERSION_TABLE.keys.sort.reverse
    result = ''
    remainder = @number
    while remainder > 0
      conversion_keys.each.with_index do |key, idx|
        placeholder = ''
        previous_idx_key = conversion_keys[idx - 1]
        divmod = remainder.divmod(key)
        if divmod.first.zero?
          other_numeral = 0
          powers_of_ten = SUBTRACTABLE.select { |num| num != key }
          powers_of_ten.each { |num| other_numeral = num if remainder.divmod(key - num).first == 1 }
          if !other_numeral.zero?
            placeholder += CONVERSION_TABLE[other_numeral]
            placeholder += CONVERSION_TABLE[key]
            remainder -= (key - other_numeral)
          end
        elsif divmod.first > 0
          placeholder += CONVERSION_TABLE[key]
          placeholder += CONVERSION_TABLE[key] * (divmod.first - 1) if divmod.first <= 3
          remainder = divmod.last
          placeholder += CONVERSION_TABLE[previous_idx_key] if divmod.first > 3
        end
        result += placeholder
      end
    end
    result
  end
end

# CMXI

# result = DLXXV
# placeholder:

# Algo

# Cannot repeat roman numerals over three times in a row
# A smaller numeral before a larger one is subtraction

# - Get the keys of the conversion table, sort them descending
# - Create a result string
# - Create a remainder, set it to the number to convert
# - While the remainder is greater than zero
#   - Iterate through keys and their indexes
#     - Start a placeholder
#     - Get the divmod of the remainder and the key
#     - If the divmod.first is greater than zero
#       - Add it to the placeholder
#       - Subtract divmod.first * key from the remainder
#     - If divmod.first is greater than 3
#       - Add the previous index key to result
#     - Add placeholder to result

def to_roman
  conversion_keys = CONVERSION_TABLE.keys.sort { |a, b| b > a }
  result = ''
  remainder = @number
  while remainder > 0
    conversion_keys.each.with_index do |key, idx|
      placeholder = ''
      divmod = remainder.divmod(key)
      if divmod.first > 0
        placeholder += CONVERSION_TABLE[key]
        remainder -= (divmod.first * key)
      elsif divmod.first > 3
        previous_idx_key = conversion_keys[idx - 1]
        result += CONVERSION_TABLE[previous_idx_key]
      end
      result += placeholder
    end
  end
  result
end