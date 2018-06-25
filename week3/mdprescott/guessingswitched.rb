LOWVALUE = 1 #lowest possible number
HIGHVALUE = 10 #highest possible number
variable = 5 #sets number of guesses
@arr = (LOWVALUE..HIGHVALUE)
@new_array = Array(@arr) #array of possible values, where .sample is applicable and can be adjusted with other arrays
@already_asked = [] #array of already guessed values
@number = 0


def clown
puts "=" *50
puts "
      __________\t     ____________________\n
   -/  _      _  \\- \t   /                      \\\n
 / / / 0 \\  / 0 \\ \\ \\\t  |  Now it's my turn...  |\n
/ |  @     _    @  | \\\t /_\\______________________/\n
|  \\      ^ ^      /  |\n
 \\_ \\_   ----   _/ _/\t\n
       \\__/\\__/ "
puts "=" *50
end

def loser
  puts "=" *64
  puts "\tThe clown guessed poorly... He did not guess #{@number}."
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
  sleep(1)
  puts "I say: 'Yes Clown, my number is #{@number}.'"
  sleep(2)
  puts "=" *64
  puts "\t\tThe Clown Wins..."
  puts "=" *64
  puts "=" *50
  puts "
        __________\t     ________________\n
     -/  _      _  \\- \t   /                  \\\n
   / / / 0 \\  / 0 \\ \\ \\\t  |      I win...      |\n
  / |  @     _    @  | \\ /_\\__________________/\n
  |  \\      ^ ^      /  |\n
   \\_ \\_   ----   _/ _/\t\n
         \\__/\\__/ "
  puts "=" *50
end


def set_random_and_intro(variable)
  puts "\n\n The clown tells me its time to switch things around."
  sleep(1)
  puts "\nPick a number between #{LOWVALUE - 1} and #{HIGHVALUE + 1}, and I will guess it in #{variable} guesses."
  print "\nI pick: "
  @number = gets.chomp.to_i
  loop do
    if @number == 0 || @number > HIGHVALUE || @number < LOWVALUE
      puts "\n"
      print "That is not a number between #{LOWVALUE - 1} and #{HIGHVALUE + 1}. Pick another number. "
      @number = gets.chomp.to_i
    else
    break
    end
  end
  sleep(1)
  puts "\n\n"
  puts "=" *64
  puts "\n\n"
end

def guesses_do(variable)
  @arrs = @new_array - @already_asked #sets original possible numbers
  loop do
    guess = @arrs.sample
    if guess == @number
      puts "\nThe clown asks: 'Is your number #{guess}?'"
      puts winner
      break
    else
    variable -= 1
    end
    if guess != @number && !@already_asked.include?(guess) && variable > 1
      puts "\nThe clown asks: 'Is your number #{guess}?'"
      sleep(1)
      @already_asked.push(guess) #adds guessed value to array
      @arrs = @new_array - @already_asked #removes guessed values from array used to make next guess
      puts "I say: 'Nope! Guess, again.'"
      sleep(2)
    elsif guess != @number && variable == 1
      puts "\nThe clown asks: 'Is your number #{guess}?'"
      sleep(1)
      @already_asked.push(guess)
      @arrs = @new_array - @already_asked
      puts "I say: 'No foolish Clown. You only have one more guess! Guess, again.'"
      sleep(2)
    elsif guess != @number && variable == 0
      puts "\nThe clown asks: 'Is your number #{guess}?'"
      sleep(1)
      puts "I say: 'Nope! You are all out of guesses. You lose!'"
      sleep(2)
      loser
    break
    end
  end
end

def run_it(variable)
  clown
  set_random_and_intro(variable)
  guesses_do(variable)
end



run_it(variable)
