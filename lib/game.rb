class Game
  attr_accessor :player_1, :player_2, :board

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
  
  def current_player
    x_moves = self.board.cells.select {|moves| moves == "X"}
    o_moves = self.board.cells.select {|moves| moves == "O"}
    x_moves.size == o_moves.size ? self.player_1 : self.player_2
  end

  def over?
    # binding.pry
    draw? || won?
  end



  def won?
  # binding.pry
    WIN_COMBINATIONS.find do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = self.board.cells[win_index_1]
      position_2 = self.board.cells[win_index_2]
      position_3 = self.board.cells[win_index_3]
      position_1 == position_2 && position_2 == position_3 && position_1 != " "
    end
  end

  def draw?
    board.full? && won? == nil
  end

  def winner
    if won? != nil
      winning_position = won?
      winning_index = winning_position[0]
      # binding.pry
      self.board.cells[winning_index]
    else
      nil
    end
  end

  def turn
    if board.turn_count.even?
      puts "Player 1:"
      board.display
      move = self.player_1.move(self.board)
      if board.valid_move?(move)
        board.update(move, self.player_1)
      else
        puts "Invalid move"
        turn
      end
    else
      puts "Player 2:"
      board.display
      move = self.player_2.move(self.board)
      if board.valid_move?(move)
        board.update(move, self.player_2)
      else
        puts "Invalid move"
        turn
      end
    end
  end

  def play
    while !over?
      puts "Player, please enter 1 - 9"
      turn
    end

    if won?
      puts "Winning board:"
      board.display
      puts "Congratulations #{winner}!"
    else draw?
      board.display
      puts "Cat's Game!"
    end
  end
end