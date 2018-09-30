class Board
  attr_accessor :cells
  
  def reset!
    @cells = Array.new(9, " ")
  end
  
  
end