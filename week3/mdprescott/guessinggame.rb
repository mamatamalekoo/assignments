LOWVALUE = 1 #lowest possible number, can be no lower than 1
HIGHVALUE = 10 #highest possible number
variable = 5 #number of guesses

def clown
puts "=" *50
puts "
      __________\t     _____________________\n
   -/  _      _  \\- \t   /                       \\\n
 / / / 0 \\  / 0 \\ \\ \\\t  |  Let's play a game...  |\n
/ |  @     _    @  | \\\t /_\\______________________/\n
|  \\      ^ ^      /  |\n
 \\_ \\_   ----   _/ _/\t\n
       \\__/\\__/ "
puts "=" *50
end

def loser
  puts "=" *64
  puts "\tYou have guessed poorly... The number was #{@number}"
  puts "=" *64
  puts "
  ________                        ________
 /  _____/_____    _____   ____   \\_____  \\___  __ ___________
/   \\  ___\\__  \\  /     \\_/ __ \\   /   |   \\  \\/ // __ \\_  __ \\
\\    \\_\\  \\/ __ \\|  Y Y  \\  ___/  /    |    \\   /\\  ___/|  | \\/
 \\______  (____  /__|_|  /\\___  > \\_______  /\\_/  \\___  >__|
        \\/     \\/      \\/     \\/          \\/          \\/     "
  puts "=" *64
  puts "=" *64
end

def winner
  puts "=" *64
  puts "\tYes, the number was #{@number}. You win!!!"
  puts "=" *64
  puts "
_____.___.               __      __.__         ._. ._. ._.
\\__  |   | ____  __ __  /  \\    /  \\__| ____   | | | | | |
 /   |   |/  _ \\|  |  \\ \\   \\/\\/   /  |/    \\  | | | | | |
 \\____   (  <_> )  |  /  \\        /|  |   |  \\  \\|  \\|  \\|
 / ______|\\____/|____/    \\__/\\  / |__|___|  /  __  __  __
 \\/                            \\/          \\/   \\/  \\/  \\/ "
  puts "=" *64
  puts "=" *64
end


def set_random_and_intro
  sleep(1)
  puts "\nI've picked a number between #{LOWVALUE - 1} and #{HIGHVALUE + 1}."
  sleep(1)
  @number = rand(LOWVALUE..HIGHVALUE)
end

def prompt_guess(variable)
  print "\nGuess my number. You have #{variable} guesses. "
  loop do
    response = gets.chomp.to_i
    if response == @number
    puts "\n"
    winner
    break
    elsif response == 0 || response > HIGHVALUE || response < LOWVALUE
    puts "\n"
    print "That is not a number between #{LOWVALUE - 1} and #{HIGHVALUE + 1}. Guess again. "
    else
      variable -= 1
      if response != @number && variable > 1
      puts "\n"
      print "That is incorrect. Guess again. You have #{variable} guesses left. "
      elsif response != @number && variable == 1
      puts "\n"
      print "That is incorrect. This is your last guess. Guess wisely. "
    elsif response != @number && variable == 0
      puts "\n"
      loser
      break
    end
    end
  end
end

def run_it(variable)
  clown
  set_random_and_intro
  prompt_guess(variable)
end


run_it(variable)
