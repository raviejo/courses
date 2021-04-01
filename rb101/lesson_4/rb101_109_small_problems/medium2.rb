## 1. Longest Sentence
# Problem:
# Write a program that reads the content of a text file and then prints the longest sentence in the file based on number of words. Sentences may end with periods (.), exclamation points (!),
# or question marks (?). Any sequence of characters that are not spaces or sentence-ending characters should be treated as a word. You should also print the number of words in the longest
# sentence.
# Examples:
# Four score and seven years ago our fathers brought forth
# on this continent a new nation, conceived in liberty, and
# dedicated to the proposition that all men are created
# equal.

# Now we are engaged in a great civil war, testing whether
# that nation, or any nation so conceived and so dedicated,
# can long endure. We are met on a great battlefield of that
# war. We have come to dedicate a portion of that field, as
# a final resting place for those who here gave their lives
# that that nation might live. It is altogether fitting and
# proper that we should do this.

# But, in a larger sense, we can not dedicate, we can not
# consecrate, we can not hallow this ground. The brave
# men, living and dead, who struggled here, have
# consecrated it, far above our poor power to add or
# detract. The world will little note, nor long remember
# what we say here, but it can never forget what they
# did here. It is for us the living, rather, to be dedicated
# here to the unfinished work which they who fought
# here have thus far so nobly advanced. It is rather for
# us to be here dedicated to the great task remaining
# before us -- that from these honored dead we take
# increased devotion to that cause for which they gave
# the last full measure of devotion -- that we here highly
# resolve that these dead shall not have died in vain
# -- that this nation, under God, shall have a new birth
# of freedom -- and that government of the people, by
# the people, for the people, shall not perish from the
# earth.
# The longest sentence in the above text is the last sentence; it is 86 words long. (Note that each -- counts as a word.)

# Another Example

# Download the book at http://www.gutenberg.org/cache/epub/84/pg84.txt, and run your program on this file.

# The longest sentence in this book is 157 words long.

# Downloaded the book and saved it as "text.txt"
text = File.read("text.txt")

def longest_sentence(text)
  text = text.split(/[\.\?!]/)
  text = text.map {|sentence| sentence.split.map(&:strip) }
  max_sentence = text.max_by {|sentence| sentence.size }
  puts "The longest sentence has #{max_sentence.size} characters"
  puts max_sentence.join(" ")
end

longest_sentence(text)

# 2. Now I Know My ABCs
# A collection of spelling blocks has two letters per block, as shown in this list:
# B:O   X:K   D:Q   C:P   N:A
# G:T   R:E   F:S   J:W   H:U
# V:I   L:Y   Z:M
# This limits the words you can spell with the blocks to just those words that do not use both letters from any given block. Each block can only be used once.
# Write a method that returns true if the word passed in as an argument can be spelled from this set of blocks, false otherwise.
# Examples:
# block_word?('BATCH') == true
# block_word?('BUTCH') == false
# block_word?('jest') == true


SPELLING_BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM)

def block_word?(word)
  counter = 0
  SPELLING_BLOCKS.each do |block| 
    word.each_char do |letter|
      counter += 1 if block.include?(letter.upcase)
    end
    if counter >= 2
      return false
    else
      counter = 0
    end
  end
  return true
end

def block_word(word)
  blocks = SPELLING_BLOCKS
  !blocks.map do |block|
    word.upcase.count(block) >= 2
  end.include?(true)
end

def block_word?(word)
  blocks = SPELLING_BLOCKS
  blocks.none? {|block| word.upcase.count(block) >= 2}
end

