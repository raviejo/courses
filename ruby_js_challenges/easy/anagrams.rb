class Anagram
  def initialize(anagram)
    @anagram = anagram.downcase
    @frequency = character_frequency(anagram)
  end

  def match(ary)
    matches = []
    ary.each do |word|
      word_frequency = character_frequency(word)
      matches << word if @frequency == word_frequency && @anagram != word.downcase
    end
    matches
  end

  def character_frequency(word)
    frequency = {}
    word.downcase.chars.each do |char|
      if frequency.include?(char)
        frequency[char] += 1
      else
        frequency[char] = 1
      end
    end
    frequency
  end
end

detector = Anagram.new('ant')
anagrams = detector.match(%w(tan stand at))
puts anagrams