MOVES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

class History
  attr_accessor :move_arr

  def initialize
    @move_arr = []
  end

  def save_moves(human, computer)
    self.move_arr << [human.name, human.move, computer.name, computer.move]
  end

  def display_moves
    puts "Move History"
    move_arr.each_with_index do |sub_arr, i|
      puts "Move #{i + 1}: #{sub_arr[0]}'s move: #{sub_arr[1]}  #{sub_arr[2]}'s move = #{sub_arr[3]}"
    end
  end
end

class Match
  POINTS_FOR_WIN = 2

  def initialize(human, computer)
    @score_hash = {}
    @score_hash[human] = 0
    @score_hash[computer] = 0
  end

  def  update_num_wins(winner)
    score_hash[winner] += 1 if winner != nil
  end

  def  display_num_wins
    score_hash.each_pair { |contestant, num_wins| puts "Match update: #{contestant.name} has won #{num_wins} games" }
  end

  def is_over?
    score_hash.any? { |contestant, num_wins| num_wins == POINTS_FOR_WIN }
  end

  def display_winner
    puts "The match is over. The winner is: #{score_hash.key(POINTS_FOR_WIN).name}"
  end

  private
  
  attr_accessor :score_hash

end

class Rock
  def >(other)
    other.class == Scissors || other.class == Lizard
  end

  def <(other)
    other.class == Paper || other.class == Spock
  end

  def to_s
    'rock'
  end
end

class Paper
  def >(other)
    other.class == Rock || other.class == Spock
  end

  def <(other)
    other.class == Lizard || other.class == Scissors
  end

  def to_s
    'paper'
  end
end

class Scissors
  def >(other)
    other.class == Paper || other.class == Lizard
  end

  def <(other)
    other.class == Rock || other.class == Spock
  end

  def to_s
    'scissors'
  end
end

class Lizard
  def >(other)
    other.class == Paper || other.class == Spock
  end

  def <(other)
    other.class == Rock || other.class == Scissors
  end

  def to_s
    'lizard'
  end
end

class Spock
  def >(other)
    other.class == Scissors || other.class == Rock
  end

  def <(other)
    other.class == Lizard || other.class == Paper
  end

  def to_s
    'spock'
  end
end

class Player

  attr_accessor :move
  attr_reader :name

  def initialize
    set_name
  end

  def to_s
    name
  end

  protected

  attr_writer :name

end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      print "Please choose "
      MOVES.each_with_index do |move, i|
        if i == MOVES.size - 1
          print 'or '
          print move
          puts ': '
        else
          print move
          print ', '
        end
      end
      choice = gets.chomp
      break if MOVES.include?(choice)
      puts "Sorry, invalid choice."
    end
    case choice
    when 'rock' then self.move = Rock.new
    when 'paper' then self.move = Paper.new
    when 'scissors' then self.move = Scissors.new
    when 'lizard' then self.move = Lizard.new
    when 'spock' then self.move = Spock.new
    end
  end
end

class Computer < Player

  attr_accessor :robot_arr

  ROBOT_MOVE_WEIGHTS =
  { 'R2D2' => [['rock', 100], ['paper', 0], ['scissors', 0], ['lizard', 0], ['spock', 0]], 
    'Hal' => [['rock', 0], ['paper', 50], ['scissors', 50], ['lizard', 0], ['spock', 0]], 
    'Chappie' => [['rock', 0], ['paper', 0], ['scissors', 100], ['lizard', 0], ['spock', 0]], 
    'Sonny' => [['rock', 0], ['paper', 0], ['scissors', 0], ['lizard', 100], ['spock', 0]], 
    'Number 5' => [['rock', 0], ['paper', 0], ['scissors', 0], ['lizard', 0], ['spock', 100]] } 

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    print "Computer's name is: "
    puts name
    self.robot_arr = ROBOT_MOVE_WEIGHTS[name]
    p robot_arr
  end

  def choose
    choice = ''
    # robot_arr = ROBOT_MOVE_WEIGHTS[name]
    rand_percen = rand(100)
    robot_arr.each do |sub_arr|
      if rand_percen < sub_arr[1]
        choice = sub_arr[0]
        break
      else
        rand_percen -= sub_arr[1]
      end
    end
    case choice
    when 'rock' then self.move = Rock.new
    when 'paper' then self.move = Paper.new
    when 'scissors' then self.move = Scissors.new
    when 'lizard' then self.move = Lizard.new
    when 'spock' then self.move = Spock.new
    else  puts "Choice error"
    end
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer, :match, :winner, :history

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    @history = History.new
    @match = nil
    @winner = nil
  end

  def display_welcome_message
    print "Welcome to "
    MOVES.each_with_index do |move, i|
      if i == MOVES.size - 1
        print move.capitalize
        puts '!'
      else
        print move.capitalize
        print ', '
      end
    end
  end

  def display_goodbye_message
    print "Thanks for playing "
    MOVES.each_with_index do |move, i|
      if i == MOVES.size - 1
        print move.capitalize
        puts '. Good bye!'
      else
        print move.capitalize
        print ', '
      end
    end

  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def determine_winner
    if human.move > computer.move
      self.winner = human
    elsif human.move < computer.move
      self.winner = computer
    else
      self.winner = nil
    end
  end

  def display_winner
    if winner != nil
      puts "#{winner.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play
    loop do
      match = Match.new(human, computer)
      loop do
        human.choose
        computer.choose
        history.save_moves(human, computer)
        display_moves
        determine_winner
        display_winner
        match.update_num_wins(winner)
        match.display_num_wins
        if match.is_over?
          match.display_winner
          break
        end
      end
      break unless play_again?
      @computer = Computer.new if player_wants_new_computer_opponent?
    end
    history.display_moves

    display_goodbye_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again (y/n)?"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be a y or n"
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def player_wants_new_computer_opponent?
    answer = nil
    loop do
      puts "Would like to play against a different computer opponent? (y for new opponent/n for same opponent)?"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be a y or n"
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end
end

RPSGame.new.play


# i = 30

# r = (0..i)

# p r

# p r.include?(31)


