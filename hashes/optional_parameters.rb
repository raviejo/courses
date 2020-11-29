require 'pry'
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

anagrams = []

def anagram?(w1, w2)
  w2_chars = w2.each_char.to_a
  matches = []
  w2_chars.each { |char| matches << char if w1.include?(char) }
  w1.length == matches.length && w1.length == w2.length
end

words.each do |word| 
  if anagrams.include?([word])
    next
  else
    anagrams << [word]
  end
end

anagrams.each do |anagram_arr|
  first_word = anagram_arr.first
  words.each do |word|
    if first_word == word
      next
    elsif anagram?(first_word, word)
      anagram_arr.append(word)
    end
  end
end
    
anagrams.each { |anagram_arr| p anagram_arr }

