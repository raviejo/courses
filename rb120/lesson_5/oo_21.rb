require "pry"
# Twenty-One is a card game consisting of a dealer and a player,
# where the participants try to get as close to 21 as possible without
# going over.

# Here is an overview of the game:
# - Both participants are initially dealt 2 cards from a 52-card deck.
# - The player takes the first turn, and can "hit" or "stay".
# - If the player busts, he loses. If he stays, it's the dealer's turn.
# - The dealer must hit until his cards add up to at least 17.
# - If he busts, the #{@player.name} wins!. If both player and dealer stays,
#   then the highest total wins.
# - If both totals are equal, then it's a tie, and nobody wins.

# Nouns: cards, player, dealer, participant, deck, game, total
# Verbs: deal, hit, stay, bust

# Player
# - hit
# - stay
# - busted?
# - total

# Dealer
# - stay
# - hit
# - busted?
# - total
# - deal (should this be here, or in Deck?)

# Participant

# Deck
# - deal (should this be here or in dealer?)

# Card
# Game
# - start

module Promptable
  def prompt(msg, spaces=2, character="=", ending=">")
    puts "#{character * spaces}#{ending} #{msg}"
  end

  def prompt_space
    puts
  end

  def clear
    system("clear")
  end
end

module Hand
  # attr_reader :hand
  # attr_accessor :stay

  # def initialize(deck)
  #   @deck = deck
  #   @hand = []
  #   @stay = false
  #   # what would be the states of a Player object?
  #   # cards? name?
  # end

  def hit
    card = @deck.cards.sample
    @hand << @deck.cards.delete(card)
  end

  def busted?
    total > 21
  end

  def card_values
    hand.map(&:value).sort_by(&:size)
  end

  def ace_value(hand_value, value)
    if (hand_value + value.last) <= 21
      value.last
    else
      value.first
    end
  end

  def total
    hand_value = 0
    card_values.each do |value|
      hand_value += if value.size > 1
                      ace_value(hand_value, value)
                    else
                      value.first
                    end
    end
    hand_value
  end

  def show_cards
    prompt("#{name}'s cards:")
    hand.each do |card|
      if card.hidden
        prompt("Hidden Card", 4, " ")
      else
        prompt(card, 4, " ")
      end
    end
  end

  def display_card_value_message
    prompt_space
    prompt("With a value of #{total}", 3, " ", "")
    prompt_space
  end
end

class Participant
  include Hand
  include Promptable
  attr_accessor :name, :hand, :stay

  def initialize(deck)
    @hand = []
    @stay = false
    @deck = deck
    set_name
  end
end

class Player < Participant
  def set_name
    name = nil
    loop do
      clear
      puts "What's your name"
      name = gets.chomp.capitalize
      break unless name.empty?
      puts "Sorry, you must enter a value"
    end
    self.name = name
  end

  def show_cards
    super
    display_card_value_message unless busted?
  end
end

class Dealer < Participant
  ROBOTS = ["Hal", "Chappie", "R2D2", "Sonny", "Number 5"]

  def set_name
    self.name = ROBOTS.sample
  end

  def stay?
    total >= 17
  end

  def hidden_cards?
    hand.map(&:hidden).include?(true)
  end

  def unhide_cards
    hand.each { |card| card.hidden = false }
  end

  def show_cards
    super
    display_card_value_message unless hidden_cards?
    prompt_space
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    reset
  end

  def deal
    dealt_cards = cards.sample(2)
    dealt_cards.each { |card| @cards.delete(card) }
    dealt_cards
  end

  def reset
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
    cards = (2..10).to_a + ["Jack", "Queen", "King", "Ace"]
    suits.each do |suit|
      cards.each do |card|
        @cards << Card.new(suit, card)
      end
    end
    @cards.shuffle!
  end
end

class Card
  attr_reader :suit, :card
  attr_accessor :hidden

  def initialize(suit, card, hidden=false)
    # what are the "states" of a card?
    @suit = suit
    @card = card
    @value = value
    @hidden = hidden
  end

  def value
    if card.class == Integer
      [card]
    elsif card == "Ace"
      [1, 11]
    else
      [10]
    end
    # binding.pry
  end

  def to_s
    "#{card} of #{suit}"
  end
end

class Game
  include Promptable

  def initialize
    @deck = Deck.new
    @player = Player.new(@deck)
    @dealer = Dealer.new(@deck)
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn unless @player.busted?
    show_result
  end

  def deal_cards
    display_welcome_message
    prompt_space
    player_cards = @deck.deal
    dealer_cards = @deck.deal
    dealer_cards.last.hidden = true
    player_cards.each { |card| @player.hand << card }
    dealer_cards.each { |card| @dealer.hand << card }
  end

  def display_welcome_message
    clear
    prompt("Hi #{@player.name} welcome to 21! The cards have been dealt.")
  end

  def show_initial_cards
    @dealer.show_cards
    @player.show_cards
  end

  def clear_and_show_cards
    clear
    show_initial_cards
    prompt_space
  end

  def player_move
    if @player.stay
      prompt("#{@player.name} stays!")
      clear_and_show_cards
    else
      @player.hit
      prompt("#{@player.name} hits!")
      clear_and_show_cards
    end
  end

  def player_turn
    answer = nil
    loop do
      prompt("Would you like to hit or stay (h, s)")
      answer = check_input
      show_initial_cards
      player_move
      break if @player.busted?
    end
  end

  def check_input
    answer = nil
    loop do
      answer = gets.chomp.downcase
      @player.stay = true if answer == "s"
      break if ["h", "s"].include? answer
      prompt("That's an invalid option, please enter 'h' to hit or 's' to stay")
    end
    answer
  end

  def dealer_turn
    @dealer.unhide_cards
    loop do
      @dealer.hit unless @dealer.stay?
      break if @dealer.busted? || @dealer.stay?
    end
    clear
    show_initial_cards
  end

  def both_participants_busted?
    @player.busted? && @dealer.busted?
  end

  def tie?
    @player.total == @dealer.total
  end

  # rubocop:disable all
  def show_result
    dealer_name = @dealer.name
    player_name = @player.name
    if @dealer.busted?
      prompt("Oh no the #{dealer_name} busted! #{dealer_name}'s cards add up to #{dealer_name}, which is more than 21. #{player_name} wins!")
    elsif @player.busted?
      prompt("Oh no #{player_name}, you've busted! Your cards add up to #{@player.total}, which is more than 21. Better luck next time!")
    elsif both_participants_busted? || tie?
      prompt("It's a tie!")
    else
      prompt("#{winner} wins!")
      prompt("Better luck next time #{player_name}") if dealer_won?
    end
  end
  # rubocop:enable all

  def winner
    if @player.total > @dealer.total
      @player.name
    else
      @dealer.name
    end
  end

  def dealer_won?
    winner == @dealer.name
  end
end

Game.new.start
