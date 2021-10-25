class BeerSong
  LYRICS = "2 bottles of beer on the wall, 2 bottles of beer.\n" \
  "Take one down and pass it around, 1 bottle of beer on the wall.\n"

  def self.verse(num)

    sub_num = substitute(num)
    sub_sentence = num.zero? ? "Go to the store and buy some more" : "Take it down and pass it around"
    sub_next_num = substitute(num - 1)
    LYRICS.sub(/(1)|(2)|(3)|(4)/, "\\1#{sub_num}\\1\\2#{sub_sentence}\\2\\3#{sub_next_num}\\3")
  end

  def self.substitute(num)
    case num
    when 0 then substitute = "No more bottles"
    when 1 then substitute = "#{num} bottle"
    when (2..99) then substitute = "#{num} bottles"
    end
  end

  def self.verses()

  end
end

puts BeerSong.verse(5)