# Assignment: Some Improvements

require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                   [1, 4, 7], [2, 5, 8], [3, 6, 9], # columns
                   [1, 5, 9], [3, 5, 7]] # diagonals

  def initialize
    @squares = {}
    reset
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
    # @squares.select { |_, sq| sq.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        # return the first of the 3 identical markers
        return squares.first.marker
      end
    end
    nil
  end

  def unmarked_square_in_line_having_two_identical_markers(identical_marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)

      next if squares.count { |sq| sq.unmarked? } != 1
      next if squares.count { |sq| sq.marker == identical_marker } != 2

      squares.each_with_index do |sq, i|
        return line[i] if sq.unmarked?
      end
    end
    nil
  end
  
  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    puts "     |     |     "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |     "
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  NUM_WINS_REQUIRED_TO_WIN_SET = 5
  attr_reader :num_games_won_in_set, :name
  attr_accessor :marker

  def initialize(default_marker, name)
    @marker = default_marker
    @num_games_won_in_set = 0
    @name = name
  end

  def inc_num_games_won_in_set
    @num_games_won_in_set += 1
  end

  def won_enough_games_to_win_set?
    @num_games_won_in_set >= NUM_WINS_REQUIRED_TO_WIN_SET
  end

  def reset_num_games_won_in_set
    @num_games_won_in_set = 0
  end
end

class TTTGame
  PLAYER_NAME = "Medley"
  COMPUTER_NAME = "IBM"
  DEFAULT_HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'

  FIRST_MOVE_PLAYER = 'player'
  FIRST_MOVE_COMPUTER = 'computer'
  FIRST_MOVE_CHOOSE = 'choose'
  WHO_MOVES_FIRST_EACH_GAME = FIRST_MOVE_CHOOSE  # FIRST_MOVE_PLAYER, FIRST_MOVE_COMPUTER, or FIRST_MOVE_CHOOSE

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(DEFAULT_HUMAN_MARKER, PLAYER_NAME)
    @computer = Player.new(COMPUTER_MARKER, COMPUTER_NAME)
  end

  def play
    clear
    display_welcome_message

    puts "Player name is #{human.name}. Computer name is #{computer.name}."
    puts ""

    human.marker = pick_player_marker

    @first_marker_to_move = get_first_marker_to_move
    @current_marker = @first_marker_to_move
    main_set
    display_goodbye_message
  end

 
  private

  def display_welcome_message
    puts ""
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def get_first_marker_to_move
    case WHO_MOVES_FIRST_EACH_GAME
    when FIRST_MOVE_PLAYER then return human.marker
    when FIRST_MOVE_COMPUTER then return COMPUTER_MARKER
    else
      puts "Who moves first each game (p for player, or c for computer)?"
      first_choice = nil
      loop do
        first_choice = gets.chomp
        break if ['c', 'p'].include? (first_choice.downcase)
        puts "Please choose p or c"
      end
      return first_choice == 'p' ? human.marker : COMPUTER_MARKER 
    end   
  end

  def pick_player_marker
    print "Pick a marker for the player (#{human.name}, default of X if return): "
    marker_choice = gets.chomp
    marker_choice = 'X' if marker_choice == ''
    puts "Player marker is: #{marker_choice}"
    return marker_choice
  end

  def main_set
    loop do # until user does not want to play a set again

      loop do # until someone wins the set

        display_board

        play_game

        display_game_result
        display_set_score
        reset_game

        break if someone_won_set?
        display_play_new_game_message
      end

      display_set_result
      reset_set

      break unless play_set_again?
      display_play_new_set_message
    end
  end

  def play_game
    loop do # alternate moves until someone wins game or board becomes full
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye #{human.name} and #{computer.name}!"
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "#{human.name}'s marker is a #{human.marker}. #{computer.name}'s marker is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def joinor(arr, sep = ', ', conjunc = 'or')
    if arr.size == 0
      out_string = ''
    elsif arr.size == 1
      out_string = arr[0].to_s
    else
      last_elem = arr.pop
      out_string = arr.join(sep)
      out_string << ' ' + conjunc + ' ' + last_elem.to_s
    end
    out_string
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    square = get_ai_square
    puts "#{computer.name} chose #{square}"
    board[square] = computer.marker
  end

  # 1) Pick the winning move
  # 2) Defend against a winning move
  # 3) Pick #5 square
  # 4) Randomly pick a square
  def get_ai_square
    square = get_winning_square
    return square if square

    square = get_defending_square
    return square if square

    square = get_number_5_square
    return square if square

    square = board.unmarked_keys.sample
    return square
  end

  def get_winning_square
    board.unmarked_square_in_line_having_two_identical_markers(computer.marker)
  end

  def get_defending_square
    board.unmarked_square_in_line_having_two_identical_markers(human.marker)
  end

  def get_number_5_square
    board.unmarked_keys.include?(5) ? 5 : nil
  end

  def display_game_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "#{human.name} won the game!"
    when computer.marker
      puts "#{computer.name} won the game!"
    else
      puts "It's a tie!"
    end
  end

  def someone_won_set?
    human.won_enough_games_to_win_set? || computer.won_enough_games_to_win_set?
  end

  def display_set_result
    if human.won_enough_games_to_win_set?
      puts "#{human.name} won the set!"
    else
      puts "#{computer.name} won the set!"
    end
  end

  def reset_set
    human.reset_num_games_won_in_set
    computer.reset_num_games_won_in_set
  end

  def display_set_score
    case board.winning_marker
    when human.marker
      human.inc_num_games_won_in_set
    when computer.marker
      computer.inc_num_games_won_in_set
    end
    puts "Set score. Number of games #{human.name} has won: #{human.num_games_won_in_set}.  Number of games #{computer.name} has won: #{computer.num_games_won_in_set}."
  end

  def play_set_again?
    answer = nil
    loop do
      puts "Would you like to play a set again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def reset_game
    board.reset
    @current_marker = @first_marker_to_move
    clear
  end

  def display_play_new_game_message
    puts "Playing next game in set"
    puts ""
  end

  def display_play_new_set_message
    puts "Let's play a set again!"
    puts ""
  end

  def clear
    # system 'clear'
  end

  def human_turn?
    @current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = human.marker
    end
  end
end

game = TTTGame.new
game.play
