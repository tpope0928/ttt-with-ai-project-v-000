module Players
  class Human < Player
    def move
      puts "Please enter your move"
      gets.strip
    
  end 
end