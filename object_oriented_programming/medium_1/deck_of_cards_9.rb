# Deck of Cards

# Using the Card class from the previous exercise, create a Deck class that contains all of the standard 52 playing cards. Use the following code to start your work:

# Based on LS Solution (from highest_and_lowest_ranking_cards_8.rb)
class Card
  include Comparable
  attr_reader :rank, :suit, :value

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = get_value
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def get_value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end

end



class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = []
    reset
  end

  def draw
    drawn_card = @deck.pop
    reset if @deck.empty?
    drawn_card
  end

  private

  def reset
    SUITS.each { |suit| RANKS.each { |rank| @deck << Card.new(rank, suit) } }
    @deck.shuffle!
  end

end

# LS Solution
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

#   private

#   def reset
#     @deck = RANKS.product(SUITS).map do |rank, suit|
#       Card.new(rank, suit)
#     end

#     @deck.shuffle!
#   end
# end

# The Deck class should provide a #draw method to deal one card. The Deck should be shuffled when it is initialized and, if it runs out of cards, it should reset itself by generating a new set of 52 shuffled cards.

# Examples:

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
