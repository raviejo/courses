class Cipher
  ALPHABET = ("a".."z").to_a

  def self.rotate(str, rotations)
    rotated = ''
    str.each_char do |char|
      if !ALPHABET.include?(char.downcase)
        rotated << char
        next
      end
      idx = index(char, rotations)
      rotated << rotated(char, idx)
    end
    rotated
  end

  class << self
    private

    def lowercase?(char)
      ALPHABET.include?(char)
    end

    def index(char, rotations)
      idx = ALPHABET.index(char.downcase) + rotations
      idx -= 26 while idx >= 26
      idx
    end

    def rotated(char, idx)
      if lowercase?(char)
        ALPHABET[idx]
      else
        ALPHABET[idx].upcase
      end
    end
  end
end
