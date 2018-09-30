module Players
  class Human < Player

    def move(board)
      puts "Choose a spot between 1-9"
      input = gets.strip
    end
  end
end