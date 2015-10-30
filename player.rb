class Player

  attr_accessor :name 
  attr_reader :lives, :point

  def initialize(name)
    @name = name
    @lives = 3
    @point = 0
  end

  def lose_life
    @lives -= 1
  end

  def earn_point
    @point += 1
  end

  def lost_game?
   if  @lives == 0
    true
  else
    false
  end
  end

end