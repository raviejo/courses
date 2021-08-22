# 1. Privacy
# Consider the following class:
# class Machine
#   def start
#     flip_switch(:on)
#   end

#   def stop
#     flip_switch(:off)
#   end

#   def switch_state
#     "The switch is #{switch}"
#   end

#   private

#   attr_accessor :switch

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end

# end

# machine = Machine.new
# machine.start
# puts machine.switch_state

# Modify this class so both flip_switch and the setter method switch= are private methods.

# 2. Fixed Array
# A fixed-length array is an array that always has a fixed number of elements. Write a class
# that implements a fixed-length array, and provides the necessary methods to support the following code:
# class FixedArray
#   def initialize(length)
#     @ary = Array.new(length)
#   end

#   def [](idx)
#     @ary.fetch(idx)
#   end

#   def []=(idx, value)
#     self[idx]
#     @ary[idx] = value
#   end

#   def to_a
#     @ary.clone
#   end

#   def to_s
#     to_a.to_s
#   end
# end

# fixed_array = FixedArray.new(5)
# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# The above code should output true 16 times.

# 3. Students

# Below we have 3 classes: Student, Graduate, and Undergraduate. The implementation details for the #initialize methods in Graduate and Undergraduate are missing.
# Fill in those missing details so that the following requirements are fulfilled:

# Graduate students have the option to use on-campus parking, while Undergraduate students do not.

# Graduate and Undergraduate students both have a name and year associated with them.

# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end
# end

# class Graduate < Student
#   def initialize(name, year, parking)
#     super(name, year)
#     @parking = parking
#   end
# end

# class Undergraduate < Student
#   def initialize(name, year)
#     super
#   end
# end

# 4. Circular Queue

# A circular queue is a collection of objects stored in a buffer that is treated as though it is connected end-to-end in a circle.
# When an object is added to this circular queue, it is added to the position that immediately follows the most recently added object,
# while removing an object always removes the object that has been in the queue the longest.

# This works as long as there are empty spots in the buffer. If the buffer becomes full, adding a new object to the queue requires
# getting rid of an existing object; with a circular queue, the object that has been in the queue the longest is discarded and
# replaced by the new object.

# Assuming we have a circular queue with room for 3 objects, the circular queue looks and acts like this:

# Say we have a hash called ages:
# - the key is the index (position in the buffer) of the object
# - the value is the age of the object
# - a value of nil means that there is no object in the current index

# Every time a new object is added to the queue:
# - add one to the age of all indices that are not nil
# - add the object after the youngest index
#   - if all indices after the youngest are full,
#     - add it to the first available index in the buffer

# Every time a new object is removed from the queue:
# - flush the age for that object (set it to nil)
# - remove the object from the buffer (at it's index' position)
# - return the object

require "pry"

# class CircularQueue
#   def initialize(buffer_size)
#     @buffer = Array.new(buffer_size)
#     @ages = Hash.new
#     @buffer.size.times { |n| @ages[n] = 0 }
#   end

#   def enqueue(obj)
#     @ages.each { |idx, age| @ages[idx] += 1 if !age.zero? }
#     if @ages.values.all?(&:zero?)
#       @buffer[0] = obj
#       @ages[0] += 1
#     elsif !@buffer.include?(nil)
#       idx = @ages.index(@ages.values.max)
#       @buffer[idx] = obj
#       @ages[idx] = 1
#     else
#       idx = @buffer.index(nil)
#       idx = after_idx || idx
#       @buffer[idx] = obj
#       @ages[idx] += 1
#     end
#   end

#   def dequeue
#     idx = @ages.index(@ages.values.max)
#     obj = @buffer[idx]
#     @ages[idx] = 0
#     @buffer[idx] = nil
#     obj
#   end

#   def after_idx
#     youngest = @ages.values.reject(&:zero?).min
#     youngest_idx = @ages.index(youngest)
#     after_idx = @ages.select { |idx, value| idx > youngest_idx && value.zero? }.first
#     after_idx = after_idx[0] if after_idx
#   end
# end

# class CircularQueue
#   def initialize(buffer_size)
#     @buffer = Array.new(buffer_size)
#     @first_in = 0
#     @first_out = 0
#     @capacity = buffer_size
#   end

#   def enqueue(obj)
#     if @capacity.zero?
#       @buffer[@first_out] = obj
#       @first_in = @first_out
#       @first_out = (@first_out + 1) % @buffer.size
#     else
#       @buffer[@first_in] = obj
#       @first_in = (@first_in + 1) % @buffer.size
#       @capacity -= 1
#     end
#   end

#   def dequeue
#     result = @buffer[@first_out]
#     return result unless result
#     @buffer[@first_out] = nil
#     @first_out = (@first_out + 1) % @buffer.size
#     @capacity += 1
#     result
#   end
# end

# class CircularQueue
#   def initialize(buffer_size)
#     @buffer = Array.new(buffer_size)
#     @first_in = 0
#     @first_out = 0
#     @capacity = buffer_size
#   end

#   def enqueue(obj)
#     if @capacity.zero?
#       @buffer[@first_out] = obj
#       @first_in = @first_out
#       @first_out = (@first_out + 1) % @buffer.size
#     else
#       @buffer[@first_in] = obj
#       @first_in = (@first_in + 1) % @buffer.size
#       @capacity -= 1
#     end
#   end

#   def dequeue
#     result = @buffer[@first_out]
#     return result unless result
#     @buffer[@first_out] = nil
#     @first_out = (@first_out + 1) % @buffer.size
#     @capacity += 1
#     result
#   end
# end

# class CircularQueue
#   def initialize(buffer_size)
#     @buffer = Array.new
#     @buffer_size = buffer_size
#   end

#   def enqueue(obj)
#     if @buffer.size == @buffer_size
#       @buffer.shift
#       @buffer.push(obj)
#     else
#       @buffer.push(obj)
#     end
#   end

#   def dequeue
#     @buffer.shift
#   end
# end


# queue = CircularQueue.new(3)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# 5. Stack Machine Interpretation
# require 'set'

# class MinilangError < StandardError; end
# class BadTokenError < MinilangError; end
# class EmptyStackError < MinilangError; end

# class Minilang
#   ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

#   def initialize(ops)
#     @ops = ops
#   end

#   def eval(**rest)
#     @stack = Array.new
#     @register = 0
#     @ops = format(@ops, rest) if rest
#     @ops = @ops.downcase.strip.split
#     @ops.each { |token| eval_token(token) }
#   rescue MinilangError => error
#     puts error.message
#   end

#   def eval_token(token)
#     if ACTIONS.include?(token.upcase)
#       self.send token.to_sym
#     elsif ("0".."9").cover?(token.delete("-"))
#       @register = token.to_i
#     else
#       raise BadTokenError, "Invalid token: #{token.upcase}"
#     end
#   end

#   def push
#     @stack.push(@register)
#   end

#   def add
#     @register += pop
#   end

#   def sub
#     @register -= pop
#   end

#   def mult
#     @register *= pop
#   end

#   def div
#     @register /= pop
#   end

#   def fdiv
#   end

#   def mod
#     @register %= pop
#   end

#   def pop
#     raise EmptyStackError, "Empty Stack!" if @stack.empty?
#     @register = @stack.pop
#   end

#   def print
#     puts @register
#   end
# end


# Minilang.new('PRINT').eval
# # 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

# Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)

# CENTIGRADE_TO_FAHRENHEIT = '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
# minilang.eval(degrees_c: 100)

# MILES_TO_KILOMETERS = '3 PUSH 5 PUSH %<miles_c>d MULT DIV PRINT'
# minilang = Minilang.new(MILES_TO_KILOMETERS)
# minilang.eval(miles_c: 10)

# AREA_OF_RECTANGE = '%<height_c>d PUSH %<width_c>d MULT PRINT'
# minilang = Minilang.new(AREA_OF_RECTANGE)
# minilang.eval(height_c: 10, width_c: 5)

# 6. Number Guesser Part 1
# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game.
# The game should play like this:

# class GuessingGame
#   def initialize(start, top)
#     @bottom = start
#     @top = top
#     @guesses = Math.log2(size_of_range).to_i + 1
#   end

#   def play
#     reset
#     loop do
#       space
#       display_remaining_guesses
#       get_guess
#       reduce_guess_count
#       display_guess_result
#       break if won? || @guesses.zero?
#     end
#     display_match_result
#   end

#   private

#   def size_of_range
#     (@bottom..@top).size
#   end

#   def space
#     puts
#   end

#   def display_remaining_guesses
#     puts "You have #{@guesses} guesses remaining"
#   end

#   def get_guess
#     guess = nil
#     puts "Enter a number between #{@bottom} and #{@top}:"
#     loop do
#       guess = gets.chomp.to_i
#       break if guess.between?(@bottom, @top)
#       puts "Invalid guess. Enter a number between #{@bottom} and #{@top}"
#     end
#     @guess = guess
#   end

#   def reduce_guess_count
#     @guesses -= 1
#   end

#   def display_guess_result
#     if won?
#       puts "That's the number!"
#     elsif @guess > @answer
#       puts "Your guess is too high"
#     else
#       puts "Your guess is too low"
#     end
#   end

#   def won?
#     @guess == @answer
#   end

#   def display_match_result
#     if won?
#       puts "You won!"
#     else
#       puts "You have no more guesses. You lost!"
#     end
#   end

#   def reset
#     @guess = nil
#     @answer = (@bottom..@top).to_a.sample
#   end
# end

# game = GuessingGame.new(500, 1501)
# game.play

# 7. Highest and Lowest Ranking Cards
# Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects:
# class Card
#   include Comparable

#   attr_reader :rank, :suit

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def <=>(other)
#     value <=> other.value
#   end

#   def value
#     case @rank
#     when 'Jack' then 11
#     when 'Queen' then 12
#     when 'King' then 13
#     when 'Ace' then 14
#     else @rank
#     end
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end
# end


# cards = [Card.new(2, 'Hearts'),
#   Card.new(10, 'Diamonds'),
#   Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#   Card.new(4, 'Diamonds'),
#   Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#   Card.new('Jack', 'Diamonds'),
#   Card.new('Jack', 'Spades')]

# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#   Card.new(8, 'Clubs'),
#   Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8

# class Card
#   include Comparable
#   attr_reader :rank, :suit

#   CARD_RANKING = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
#   SUIT_RANKING = { 'Spades' => 1/10, 'Hearts' => 1/20, 'Clubs' => 1/30, 'Diamonds' => 1/40 }

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def value
#     CARD_RANKING.fetch(rank, rank) + SUIT_RANKING.fetch(@suit)
#   end

#   def <=>(other_card)
#     value <=> other_card.value
#   end
# end

# cards = [Card.new(4, 'Spades'),
#          Card.new(4, 'Diamonds'),
#          Card.new(4, 'Clubs'),
#          Card.new(4, 'Hearts')]
# puts cards.min == Card.new(4, 'Diamonds')
# puts cards.max == Card.new(4, 'Spades')

# cards = [Card.new(4, 'Spades'),
#          Card.new(4, 'Diamonds'),
#          Card.new(4, 'Clubs'),
#          Card.new(4, 'Hearts'),
#          Card.new(5, 'Hearts')]
# puts cards.min == Card.new(4, 'Diamonds')
# puts cards.max == Card.new(5, 'Hearts')

# 8. Deck of Cards
# Using the Card class from the previous exercise, create a Deck class that contains all of the standard 52 playing cards.
# Use the following code to start your work:
# class Card
#   include Comparable
#   attr_reader :rank, :suit

#   CARD_RANKING = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def value
#     CARD_RANKING.fetch(rank, rank)
#   end

#   def <=>(other_card)
#     value <=> other_card.value
#   end
# end

# # class Deck
# #   attr_reader :cards

# #   RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
# #   SUITS = %w(Hearts Clubs Diamonds Spades).freeze

# #   def initialize
# #     reset
# #   end

# #   def draw
# #     reset if @cards.empty?
# #     @cards.pop
# #   end

# #   def reset
# #     @cards = Array.new
# #     RANKS.each do |rank|
# #       SUITS.each do |suit|
# #         @cards << Card.new(rank, suit)
# #       end
# #     end
# #     @cards.shuffle!
# #   end
# # end

# class Deck
#   RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
#   SUITS = %w(Hearts Clubs Diamonds Spades).freeze

#   def initialize
#     reset
#   end

#   def draw
#     reset if @deck.empty?
#     @deck.pop
#   end

#   def reset
#     @deck = RANKS.product(SUITS).map do |rank, suit|
#       Card.new(rank, suit)
#     end
#     @deck.shuffle!
#   end
# end

# # The Deck class should provide a #draw method to deal one card. The Deck should be shuffled when it is initialized and, if
# # it runs out of cards, it should reset itself by generating a new set of 52 shuffled cards.
# # Examples:

# # deck = Deck.new
# # drawn = []
# # 52.times { drawn << deck.draw }
# # puts drawn.count { |card| card.rank == 5 } == 4
# # puts drawn.count { |card| card.suit == 'Hearts' } == 13

# # drawn2 = []
# # 52.times { drawn2 << deck.draw }
# # puts drawn != drawn2 # Almost always.

# # 9. Poker!
# # In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and
# # evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand.
# # If you've never played poker before, you may find this overview of poker hands useful.

# # You should build your class using the following code skeleton:

# # Include Card and Deck classes from the last two exercises.

# class PokerHand
#   def initialize(deck)
#     @hand = Array.new(5).map { deck.draw }
#     @suits = @hand.map(&:suit)
#     @ranks = @hand.map(&:rank)
#   end

#   def print
#     @hand.each { |card| puts card }
#   end

#   def evaluate
#     case
#     when royal_flush?     then 'Royal flush'
#     when straight_flush?  then 'Straight flush'
#     when four_of_a_kind?  then 'Four of a kind'
#     when full_house?      then 'Full house'
#     when flush?           then 'Flush'
#     when straight?        then 'Straight'
#     when three_of_a_kind? then 'Three of a kind'
#     when two_pair?        then 'Two pair'
#     when pair?            then 'Pair'
#     else                       'High card'
#     end
#   end

#   private

#   def rank_freq_table
#     @ranks.each.with_object(Hash.new(0)) do |rank, freq_table|
#       freq_table[rank] += 1
#     end
#   end

#   def royal_flush?
#     flush? && @hand.min.rank == 10
#   end

#   def straight_flush?
#     flush? && straight?
#   end

#   def four_of_a_kind?
#     rank_freq_table.values.include?(4)
#   end

#   def full_house?
#     pair? && three_of_a_kind?
#   end

#   def flush?
#     @suits.count(@suits.first) == @suits.count
#   end

#   def straight?
#     lowest_rank = @hand.min.value - 1
#     @hand.sort.all? { |card| card.value == lowest_rank += 1 }
#   end

#   def three_of_a_kind?
#     rank_freq_table.values.include?(3)
#   end

#   def two_pair?
#     rank_freq_table.values.select { |value| value == 2 }.count == 2
#   end

#   def pair?
#     rank_freq_table.values.include?(2)
#   end
# end

# hand = PokerHand.new(Deck.new)
# hand.print
# puts hand.evaluate

# # Danger danger danger: monkey
# # patching for testing purposes.
# class Array
#   alias_method :draw, :pop
# end

# # Test that we can identify each PokerHand type.
# hand = PokerHand.new([
#   Card.new(10,      'Hearts'),
#   Card.new('Ace',   'Hearts'),
#   Card.new('Queen', 'Hearts'),
#   Card.new('King',  'Hearts'),
#   Card.new('Jack',  'Hearts')
# ])
# puts hand.evaluate == 'Royal flush'

# hand = PokerHand.new([
#   Card.new(8,       'Clubs'),
#   Card.new(9,       'Clubs'),
#   Card.new('Queen', 'Clubs'),
#   Card.new(10,      'Clubs'),
#   Card.new('Jack',  'Clubs')
# ])
# puts hand.evaluate == 'Straight flush'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts hand.evaluate == 'Four of a kind'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts hand.evaluate == 'Full house'

# hand = PokerHand.new([
#   Card.new(10, 'Hearts'),
#   Card.new('Ace', 'Hearts'),
#   Card.new(2, 'Hearts'),
#   Card.new('King', 'Hearts'),
#   Card.new(3, 'Hearts')
# ])

# puts hand.evaluate == 'Flush'

# hand = PokerHand.new([
#   Card.new(8,      'Clubs'),
#   Card.new(9,      'Diamonds'),
#   Card.new(10,     'Clubs'),
#   Card.new(7,      'Hearts'),
#   Card.new('Jack', 'Clubs')
# ])
# puts hand.evaluate == 'Straight'

# hand = PokerHand.new([
#   Card.new('Queen', 'Clubs'),
#   Card.new('King',  'Diamonds'),
#   Card.new(10,      'Clubs'),
#   Card.new('Ace',   'Hearts'),
#   Card.new('Jack',  'Clubs')
# ])
# puts hand.evaluate == 'Straight'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(6, 'Diamonds')
# ])
# puts hand.evaluate == 'Three of a kind'

# hand = PokerHand.new([
#   Card.new(9, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(8, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts hand.evaluate == 'Two pair'

# hand = PokerHand.new([
#   Card.new(2, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(9, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts hand.evaluate == 'Pair'

# hand = PokerHand.new([
#   Card.new(2,      'Hearts'),
#   Card.new('King', 'Clubs'),
#   Card.new(5,      'Diamonds'),
#   Card.new(9,      'Spades'),
#   Card.new(3,      'Diamonds')
# ])
# puts hand.evaluate == 'High card'