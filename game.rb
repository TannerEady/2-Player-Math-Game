require_relative 'player.rb'
require 'colorize'

class Game

  def run
    print "Player 1, what is your name? "
      name1 = gets.chomp
    print "Player 2, what is your name? "
      name2 = gets.chomp
    @player_1 = Player.new(name1)
    @player_2 = Player.new(name2)
    @current_player = @player_1

    begin
      generate_question
      switch_players
    end while !@player_1.lost_game? && !@player_2.lost_game?
    
    if @player_1.lost_game?
      puts "#{@player_1.name} has lost. #{@player_2.name} is the winner!"
    else
      puts "#{@player_2.name} has lost. #{@player_1.name} is the winner!"
    end
    puts "GAME OVER."
  end

  def random_number
    rand(1..20)
  end

  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end

  def multiply(a, b)
    a * b
  end

  def random_op
    operation = rand(1..3)
    case operation
      when 1
        'plus'
      when 2
        'minus'
      when 3
        'times'
    end
  end

  def generate_question
    num1 = random_number
    num2 = random_number
    operation = random_op
    puts "#{@current_player.name}: What is #{num1} #{operation} #{num2}?"
      answer = gets.chomp.to_i
    verify_answer(num1, num2, operation, answer)
  end

  def verify_answer(num1, num2, operation, answer)
    case operation
      when 'plus'
        result = add(num1, num2)
      when 'minus'
        result = subtract(num1, num2)
      when 'times'
        result = multiply(num1, num2)
      end
    if result == answer
      puts 'Correct! Congratulations, you can do elementary math!'.colorize(:green)
    else
      puts 'Wrong! Should have stayed in school!'.colorize(:red) 
      lives = @current_player.lose_life
      puts "Number of remaining lives: #{lives}"
    end
  end

  def switch_players
    @current_player = case @current_player
      when @player_1 then @player_2
      when @player_2 then @player_1
    end
  end
  
end

Game.new.run