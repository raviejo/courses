# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

SUITS = %w(hearts diamonds clubs spades)
CARD_VALUES = (2..10).to_a + %w(jack queen kind ace)

def initialize_deck()
  deck = []
  SUITS.each do |suit|
    CARD_VALUES.each do |value|
      card = {}
      card[value] = suit
      deck << card
    end
  end
  deck
end

def deal_cards()

end

def hit()

end

def display_hand()

end

def bust?()

end

def compare_hands()

end