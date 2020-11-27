class Card
  attr_reader :value, :name_short

  SUITS = ['H', 'D', 'S', 'C']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(cardparam1, cardparam2 = nil)
    # If e.g., (cardparam1 = '3h')
    if cardparam2.nil?
      @name_short = cardparam1
      ns_arr = @name_short.split('')

      suit = ns_arr.pop.upcase
      rank = ns_arr.join('')
    # Else e.g., (cardparam1 = 'J', cardparam2 = 'D')
    else
      suit = cardparam1
      rank = cardparam2
      @name_short = rank + suit.downcase
    end

    @name = rank_to_name(rank)
    @suit_string = suit(suit)
    @value = get_value(rank)
  end

  def to_s
    "The #{@name} of #{@suit_string}"
  end

  private

  def rank_to_name(rank)
    case rank
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      rank
    end
  end

  def suit(suit)
    case suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    end
  end

  def get_value(rank)
    value = nil
    if rank == 'A'
      value = 11
    elsif rank == 'J' || rank == 'Q' || rank == 'K'
      value = 10
    else
      value = rank.to_i
    end
    value
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []

    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end

    cards.shuffle!
  end

  def deal_one
    cards.pop
  end
end

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "=> #{card.name_short}"
    end
    puts "=> Total: #{total}"
    puts ""
  end

  def total
    # Add up all the value in the hand to obtain total
    total = cards.reduce(0) { |sum, card| sum + card.value }

    # Correct for cards having value == 11 (i.e., aces), while total is over 21
    cards.select { |card| card.value == 11 }.count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > 21
  end
end

class Participant
  include Hand

  attr_accessor :name, :cards

  def initialize
    @cards = []
    set_name
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name
  end
end

class Dealer < Participant
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def set_name
    self.name = ROBOTS.sample
  end

  def show_upcard
    puts "---- #{name}'s up card ----"
    puts "=> #{cards.first.name_short}"
    puts ""
  end

  def show_downcard
    print "#{name} turns up its down card, the "
    puts cards.last.name_short
    puts ""
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
  end

  def show_all_up_cards
    player.show_hand
    dealer.show_upcard
  end

  def player_turn
    puts "#{player.name}'s turn..."

    loop do
      puts "Would you like to (h)it or (s)tay?"
      answer = nil
      loop do
        answer = gets.chomp.downcase
        break if ['h', 's'].include?(answer)
        puts "Sorry, must enter 'h' or 's'."
      end

      if answer == 's'
        puts "#{player.name} stays!"
        puts ""
        break
        # elsif player.busted?
        # break
      else
        # show update only for hit
        player.add_card(deck.deal_one)
        puts "#{player.name} hits and gets the #{player.cards.last.name_short}"
        player.show_hand
        break if player.busted?
      end
    end
  end

  def dealer_turn
    puts "#{dealer.name}'s turn..."

    dealer.show_downcard
    dealer.show_hand

    loop do
      # if dealer.total >= 17 && !dealer.busted?
      if dealer.total >= 17
        puts "#{dealer.name} must stay!"
        puts ""
        break
        # elsif dealer.busted?
        # break
      else
        con = dealer.cards.size > 2 ? 'another' : 'a'
        dealer.add_card(deck.deal_one)
        puts "#{dealer.name} must take #{con} card and gets the #{dealer.cards.last.name_short}!"
        puts ""
        dealer.show_hand
        break if dealer.busted?
      end
    end
  end

  def show_who_busted_and_who_wins
    if player.busted?
      puts "#{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "#{dealer.name} busted! #{player.name} wins!"
    end
  end

  def show_both_hands
    player.show_hand
    dealer.show_hand
  end

  def determine_and_show_result
    if player.total > dealer.total
      puts "#{player.name} wins!"
    elsif player.total < dealer.total
      puts "#{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def start
    loop do
      system 'clear'
      # Deal initial 2 cards to each participant (player and dealer)
      deal_cards

      # Show both of the player's cards, and show dealer's upcard.
      show_all_up_cards

      # Player takes zero or more cards until either 'stays' or 'busts'
      player_turn

      # Dealer's turn if player did not bust
      dealer_turn if !player.busted?

      # If either participant busted
      if player.busted? || dealer.busted?
        show_who_busted_and_who_wins
      # Else neither busted
      else
        show_both_hands
        determine_and_show_result
      end

      play_again? ? reset : break
    end

    puts "Thank you for playing Twenty-One. Goodbye!"
  end
end

# mycard = Card.new('2h')
# puts mycard.name_short

game = TwentyOne.new
game.start
