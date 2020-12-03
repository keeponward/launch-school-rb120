# Poker!

# In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand.

# You should build your class using the following code skeleton:

# Include Card and Deck classes from the last two exercises.

# Based on LS Solution
class Card
  include Comparable
  attr_reader :rank, :suit, :value
  VALUES_ARRAY = (2..14).to_a

  HIGH_CARDS_RANK_TO_VALUES_HASH = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = get_value
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def get_value
    HIGH_CARDS_RANK_TO_VALUES_HASH.fetch(rank, rank)
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


class PokerHand
  NUM_CARDS_IN_HAND = 5

  attr_reader :hand, :value_arr, :suit_arr, :num_uniq_values, :num_uniq_suits

  def initialize(deck)
    @hand = []
    NUM_CARDS_IN_HAND.times { @hand << deck.draw }
    # puts "start @hand"
    # puts @hand
    # puts "end @hand"
    @value_arr = @hand.map { |card| card.value }
    @suit_arr = @hand.map { |card| card.suit }
    @num_uniq_values = @value_arr.uniq.size
    @num_uniq_suits = @suit_arr.uniq.size

    # puts "@value_arr = #{@value_arr}"

    # puts "@value_arr = #{@value_arr}   @suit_arr = #{@suit_arr}  @num_uniq_values = #{@num_uniq_values}   @num_uniq_suits = #{@num_uniq_suits}"
  end

  def print
    puts hand
  end

  def evaluate
    # puts hand

    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    ((num_uniq_values == 5) && (num_uniq_suits == 1) && (value_arr.min == 10) && (value_arr.max == 14))
  end

  def straight_flush?
    # Allow for the straight-flush wheel (5-high straight all the same suit)
    ((num_uniq_values == 5) && (num_uniq_suits == 1)) && 
    ((value_arr.max - value_arr.min == 4) || (value_arr - [14, 2, 3, 4, 5]).empty?)
  end

  def four_of_a_kind?
    Card::VALUES_ARRAY.any? { |value| value_arr.count(value) == 4 }
  end

  def full_house?
    Card::VALUES_ARRAY.select { |rank| value_arr.count(rank) == 3 }.count == 1 && (num_uniq_values == 2)
  end

  def flush?
    # Disallow the wheel (5-high straight)
    ((num_uniq_suits == 1) && !((value_arr.max - value_arr.min == 4) || (value_arr - [14, 2, 3, 4, 5]).empty?))
  end

  def straight?
    # Allow for the wheel (5-high straight)
    ((num_uniq_values == 5) && (num_uniq_suits > 1)) &&
    ((value_arr.max - value_arr.min == 4) || (value_arr - [14, 2, 3, 4, 5]).empty?)
  end

  def three_of_a_kind?
    Card::VALUES_ARRAY.select { |rank| value_arr.count(rank) == 3 }.count == 1 && (num_uniq_values == 3)
  end

  def two_pair?
    Card::VALUES_ARRAY.select { |rank| value_arr.count(rank) == 2 }.count == 2
  end

  def pair?
    (num_uniq_values == 4)
    # Card::VALUES_ARRAY.select { |rank| value_arr.count(rank) == 2 }.count == 1 && (num_uniq_values == 4)
  end
end

# LS Solution
# class PokerHand
#   def initialize(cards)
#     @cards = []
#     @rank_count = Hash.new(0)

#     5.times do
#       card = cards.draw
#       @cards << card
#       @rank_count[card.rank] += 1
#     end
#   end

#   def print
#     puts @cards
#   end

#   def evaluate
#     if    royal_flush?     then 'Royal flush'
#     elsif straight_flush?  then 'Straight flush'
#     elsif four_of_a_kind?  then 'Four of a kind'
#     elsif full_house?      then 'Full house'
#     elsif flush?           then 'Flush'
#     elsif straight?        then 'Straight'
#     elsif three_of_a_kind? then 'Three of a kind'
#     elsif two_pair?        then 'Two pair'
#     elsif pair?            then 'Pair'
#     else 'High card'
#     end
#   end

#   private

#   def flush?
#     suit = @cards.first.suit
#     @cards.all? { |card| card.suit == suit }
#   end

#   def straight?
#     return false if @rank_count.any? { |_, count| count > 1 }

#     @cards.min.value == @cards.max.value - 4
#   end

#   def n_of_a_kind?(number)
#     @rank_count.one? { |_, count| count == number }
#   end

#   def straight_flush?
#     flush? && straight?
#   end

#   def royal_flush?
#     straight_flush? && @cards.min.rank == 10
#   end

#   def four_of_a_kind?
#     n_of_a_kind?(4)
#   end

#   def full_house?
#     n_of_a_kind?(3) && n_of_a_kind?(2)
#   end

#   def three_of_a_kind?
#     n_of_a_kind?(3)
#   end

#   def two_pair?
#     @rank_count.select { |_, count| count == 2 }.size == 2
#   end

#   def pair?
#     n_of_a_kind?(2)
#   end
# end

# Testing your class:


hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.

hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

# Straight flush wheel
hand = PokerHand.new([
  Card.new(2,     'Clubs'),
  Card.new(4,     'Clubs'),
  Card.new(3,     'Clubs'),
  Card.new('Ace', 'Clubs'),
  Card.new(5,     'Clubs')
])
puts hand.evaluate == 'Straight flush'


hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

# Wheel
hand = PokerHand.new([
  Card.new(2,     'Clubs'),
  Card.new(4,     'Diamonds'),
  Card.new(3,     'Clubs'),
  Card.new('Ace', 'Hearts'),
  Card.new(5,     'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
