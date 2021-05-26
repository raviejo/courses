# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

require "pry"

SUITS = %w(Hearts Diamonds Clubs Spades)
CARD_VALUES = (2..10).to_a + %w(Jack Queen King Ace)
PRINTED_SUITS = {"Hearts" => ["|(\\/)|", "| \\/ |", "|  "],
                 "Diamonds" => ["| /\\ |", "| \\/ |", "|  "],
                 "Clubs" => ["| /\\ |", "|(__)|", "| /\\"],
                 "Spades" => ["| &  |", "|&|& |", "| |"]}

def prompt(msg)
  puts "=> " + msg
end

def initialize_deck
  deck = []
  SUITS.each do |suit|
    CARD_VALUES.each do |value|
      card = {}
      card[:suit] = suit
      card[:value] = value
      card[:hidden] = false
      deck << card
    end
  end
  deck
end

def deal_cards(player, computer, deck)
  deck.sample(4).each_with_index do |card, index|
    if index.even?
      card[:hidden] = true if index == 0
      computer << card
    else
      player << card
    end
    deck.delete(card)
  end
end

def hit(player, deck)
  card = deck.sample
  player << card
  deck.delete(card)
end

def hand_to_str(player)
  cards = player.map do |card|
    if !card[:hidden]
      "#{card[:value]} of #{card[:suit]}"
    else
      "Unknown card"
    end
  end
  cards.join(" and ")
end

def show_cards(player)
  player.each { |card| card[:hidden] = false if card[:hidden] == true }
end

def unknown_card
  unknown_card = []
  unknown_card << " ____ "
  unknown_card << "|?   |"
  unknown_card << "|    |"
  unknown_card << "|    |"
  unknown_card << "|   ?|"
  unknown_card << "`----`"
end

def card_list(card)
  return unknown_card() if card[:hidden] == true
  suit = card[:suit]
  value = card[:value]
  first_space = 3
  last_space = 1
  if value.class == String
    value = value[0]
  elsif value == 10
    first_space = 2
    last_space = 0
  end
  card_list = []
  card_list << " ____ "
  card_list << "|#{value}" + " " * first_space + "|"
  card_list << PRINTED_SUITS[suit][0]
  card_list << PRINTED_SUITS[suit][1]
  if suit == "Clubs" && value == 10
    card_list << "#{PRINTED_SUITS[suit][2][0,3]}#{value}|"
  elsif suit == "Clubs"
    card_list << "#{PRINTED_SUITS[suit][2]}#{value}|"
  else
    card_list << "#{PRINTED_SUITS[suit][2]}" + " " * last_space + "#{value}|"
  end
  card_list << "`----`"
  card_list
end

def print_card_list(card_list)
  card_list.each { |row| puts row }
end

def merge_print_lists(card_lists)
  merged_lists = []
  card_lists.each_with_index do |card_list, idx|
    if idx == 0
      card_list.each { |row| merged_lists << row }
    else
      card_list.each_with_index { |row, i| merged_lists[i] += "  #{row}" }
    end
  end
  merged_lists
end

def print_cards(player)
  card_lists = []
  player.each do |card|
    card_lists << card_list(card)
  end
  merged_lists = merge_print_lists(card_lists)
  print_card_list(merged_lists)
end

def placeholder(deck)
  card_lists = []
  deck.each do |card|
    card_lists << card_list(card)
  end
  print_card_list(card_lists)
end

def rearrange_aces(player)
  hand = []
  player.each { |card| hand << card if card[:value] != "Ace" }
  player.each { |card| hand << card if card[:value] == "Ace" }
  hand
end

def score(player)
  score = 0
  hand = rearrange_aces(player)
  hand.each do |card|
    score += if card[:value].class == Integer
               card[:value]
             elsif %w(Jack Queen King).include?(card[:value])
               10
             elsif score > 10
               1
             else
               11
             end
  end
  score
end

def bust?(player)
  score(player) > 21
end

def compare_scores(player, computer)
  player_score = score(player)
  computer_score = score(computer)
  if player_score > computer_score
    "Player wins"
  elsif player_score < computer_score
    "Dealer wins"
  else
    "It's a tie!"
  end
end

def compare_hands(player, computer)
  if !bust?(computer) && !bust?(player)
    compare_scores(player, computer)
  elsif bust?(computer) && bust?(player)
    "It's a tie!"
  elsif bust?(computer)
    "Player wins"
  elsif bust?(player)
    "Dealer wins"
  end
end

def print_hands(player, computer)
  prompt("The dealer's cards are: #{hand_to_str(computer)}")
  print_cards(computer)
  prompt("Your cards are: #{hand_to_str(player)}.")
  print_cards(player)
  puts "Worth a total of: #{score(player)}"
end

def print_hand(player, pseudonym)
  prompt("The #{pseudonym}'s cards are: #{hand_to_str(player)}")
  print_cards(player)
  puts "Worth a total of: #{score(player)}"
end

loop do
  deck = initialize_deck
  player = []
  computer = []
  deal_cards(player, computer, deck)

  system("clear")
  prompt("Welcome to 21. The cards have been dealt.")
  print_hands(player, computer)
  # player loop
  loop do
    prompt("Would you like to hit or stay? (h or s)")
    user_input = gets.chomp
    system("clear")
    if user_input == "h"
      hit(player, deck)
      print_hands(player, computer)
    else
      prompt("Player stays!")
      print_hand(player, "player")
    end
    prompt("Player busted! Better luck next time") if bust?(player)
    break if user_input == "s" || bust?(player)
  end

  # computer loop
  dealer_hits = 0
  loop do
    show_cards(computer)
    if score(computer) < 17
      hit(computer, deck)
      dealer_hits += 1
    end
    break if score(computer) >= 17 || bust?(computer)
  end
  prompt("The dealer hit #{dealer_hits} times!") if dealer_hits > 1
  prompt("The dealer hit #{dealer_hits} time!") if dealer_hits == 1

  print_hands(player, computer)

  prompt(compare_hands(player, computer))
  prompt("Do you want to play again? (y/n)")
  user_input = gets.chomp
  break if user_input != "y"
  system("clear")
end
