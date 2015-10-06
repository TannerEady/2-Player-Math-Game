# Colourize 
require 'colorize'
# Instance variables set to default values.
@player_1_lives = 0
@player_2_lives = 0
@player_1_wins = 0
@player_2_wins = 0
@replay_wanted = 'yes'
@player_1_name = ""
@player_2_name = ""

# Generates a random number between 1 and 20.
def random_number
  rand(1..20)
end

# Generates a random choice of addition, subtraction, or multiplication.
def random_op
  op = rand(1..3)
  case op
  when 1
    'add'
  when 2
    'subtract'
  when 3
    'multiply'
  end
end

# Takes two numbers as input and returns the sum.
def add(a, b)
  a + b
end

# Takes two numbers as input and returns the difference.
def subtract(a, b)
  a - b
end

# Takes two numbers as input and returns the product.
def multiply(a, b)
  a * b
end

# Asks for players' names, saves them to corresponding instance variables.
def get_names
  print "Player 1, what is your name? "
  @player_1_name = gets.chomp
  print"Player 2, what is your name? "
  @player_2_name = gets.chomp
end

# Takes in player number, returns player's remaining lives.
def player_lives(player)
  player == 1 ? @player_1_lives : @player_2_lives
end

# Returns the player's name.
def player_name(player)
  player == 1 ? @player_1_name : @player_2_name
end

# Returns the other player's name.
def second_player_name(player)
  player == 1 ? @player_2_name : @player_1_name
end

# Takes in 2 numbers, player number, an operation, and returns a question.
def generate_question(num1, num2, player, operation)
  case operation
  when 'add'
    "\n#{player_name(player)}, what is #{num1} plus #{num2}?"
  when 'subtract'
    "\n#{player_name(player)}, what is #{num1} minus #{num2}?"
  when 'multiply'
    "\n#{player_name(player)}, what is #{num1} times #{num2}?"
  end
end

# Asks player for answer to the question.
def get_answer
  print 'Enter your answer:'
  user_input = gets.chomp.to_i
end

# Returns true if player's answer is correct, returns false otherwise.
def correct_answer?(a, b, player_input, operation)
  case operation
  when 'add'
    result = add(a,b)
  when 'subtract'
    result = subtract(a,b)
  when 'multiply'
    result = multiply(a,b)
  end
  player_input == result
end

# Acknowledges correct answer.
def answer_is_correct
  'Correct! Congratulations, you can do elementary math! '.colorize(:green)
end

# Acknowledges incorrect answer.
def answer_is_incorrect
  'Wrong! Should have stayed in school! '.colorize(:red)
end

# Adds points to each player's score based on his/her answer.
def earn_point(player)
  player ==1 ? @player_2_wins += 1 : @player_1_wins +=1
end

# Takes away from the three lives with which each player starts.
def lose_life(player)
  player == 1 ? @player_1_lives -= 1 : @player_2_lives -= 1
end

# Returns score as it currently stands.
def current_score
  "Score: #{@player_1_name} has #{@player_1_wins} points, #{@player_2_name} has #{@player_2_wins} points."
end

# Takes player number and current number of lives and returns them.
def player_lives_status(player, num_lives)
  "\n#{player_name(player)} has #{num_lives} lives/life left.\n"
end

# Starts new turn, uses other methods to generate question and return game status.
def new_turn(player)
  num1 = random_number
  num2 = random_number
  operation = random_op
  puts generate_question(num1, num2, player, operation)
  player_input = get_answer
  if correct_answer?(num1, num2, player_input,operation)
    print answer_is_correct
  else
    print answer_is_incorrect
    lose_life(player)
  end
  game_status(player_lives(player), player)
end

# Shows player's number of remaining lives after a turn.
def game_status(num_lives, player)
  if num_lives == 0
    puts end_of_game(player)
    earn_point(player)
    puts current_score
    puts ask_replay
  else
    puts player_lives_status(player, num_lives)
  end
end

# Announces end of the game and the winner's name.
def end_of_game (player)
  "#{player_name(player)} loses! #{second_player_name(player)} is the winner (and may now gloat)!"
end

# Asks if players want another game, starts new game or quits game.
def ask_replay
  puts "\nDo you want to play another game? (yes or no)"
  @replay_wanted = gets.chomp
  if @replay_wanted == 'yes'
    return nil
  elsif @replay_wanted == 'no'
    return  "\nIf you won, congratulations. If not, I could not care less."
  else
    @replay_wanted = 'no'
    return 'Your answer is not recognized. If you wish to play again, restart the game.'
  end
end

# Runs the game until a player uses up all of his/her lives.
def start_game
  @player_1_lives = 3
  @player_2_lives = 3
  while @player_1_lives > 0 && @player_2_lives > 0
    new_turn(1)
    break if @player_1_lives == 0
    new_turn(2)
  end
end

# Begins the game.
def game
  get_names
  while @replay_wanted == 'yes'
    start_game
  end
end

game