class BeerSong
  LYRICS = "2 bottles of beer on the wall, 2 bottles of beer.\n" \
  "Take one down and pass it around, 1 bottle of beer on the wall.\n"

  def self.verse(num)
    sub_num = substitute(num)
    sub_next_num = (num - 1).negative? ? "99 bottles" : substitute(num - 1)
    sub_sentence = num.zero? ? "Go to the store and buy some more" : "Take one down and pass it around"
    sub_sentence.sub!(/one/, 'it') if num == 1
    "#{sub_num} of beer on the wall, #{sub_num.downcase} of beer.\n" \
    "#{sub_sentence}, #{sub_next_num.downcase} of beer on the wall.\n"
  end

  def self.verses(high, low)
    result = ""
    (low..high).reverse_each do |num|
      add_verse = verse(num)
      add_verse += "\n" unless num == low
      result << add_verse
    end
    result
  end
  
  def self.lyrics
    verses(99, 0)
  end
  
  class << self
    private
    
    def substitute(num)
      case num
      when 0 then "No more bottles"
      when 1 then "#{num} bottle"
      when (2..99) then "#{num} bottles"
      end
    end
    
  end
end

puts BeerSong.verses(2, 0)