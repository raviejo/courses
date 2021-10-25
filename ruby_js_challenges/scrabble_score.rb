class Scrabble
  LETTER_VALUES = {
    %w(A E I O U L N R S T) => 1,
    %w(D G) => 2,
    %w(B C M P) => 3,
    %w(F H V W Y) => 4,
    %w(K) => 5,
    %w(J X) => 8,
    %w(Q Z) => 10
  }

  def initialize(word)
    @word = word ? word : ''
  end

  def score
    total = 0
    @word.chars.each do |char|
      key = LETTER_VALUES.keys.select { |k| k.include?(char.upcase) }.first
      total += LETTER_VALUES[key] if char.match?(/[a-z]/i)
    end
    total
  end

  def self.score(word)
    Scrabble.new(word).score
  end
end