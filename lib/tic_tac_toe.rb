class TicTacToe
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [2, 4, 6],
    [0, 3, 6],
    [2, 5, 8],
    [1, 4, 7],

  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  #HELPER METHODS - they help to keep our code DRY and well-encapsulated
  #each method has a single responsibility

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(input_str)
    index = input_str.to_i - 1
  end

  def move(index, token = "X")
    board[index] = token
  end

  def position_taken?(index)
    board[index] == " " ? false : true
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    hash_count = board.tally
    occupied_positions = 9 - hash_count[" "]
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def turn
    puts "Please enter a position between 1 and 9:"
    input_str = gets
    index = input_to_index(input_str)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  #check for first position taken of each win combination
  #check that tokens are the same
  def won?
    WIN_COMBINATIONS.any? do |combination|
      if position_taken?(combination[0]) && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
        return combination
      end
    end
  end

  def full?
    [0 - 8].all? { |index| position_taken?(index) }
  end

  def draw?
    result = full? && !won?
  end

  def over?
    result = won? || full?
  end

  def winner
    if won?
      outcome = won?
      board[outcome[0]]
    end
  end

  def play
    turn until over?
    # if draw?
    #   puts "It's a draw"
    # elsif winner
    #   puts "Congratulations #{winner}"
    # end
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
end
