
#Guessing Game:
#Create a simple terminal program where the user guesses a randomly generated number.

#Hints:
#You'll want to look at other kinds of loops, the rand() method, and gets.chomp logic
#Bonus: REVERSE IT! Have the computer guess the user's input.
#MOAR Bonus: Look up how to implement a "binary search" to minimize the number of guesses the computer makes.




#Guessing game:

puts "Welcome to the number guessing game"
# print "What difficulty would you like? (low, med, or high)"
# response = gets.chomp 

# max
#   max = case 
#   when "low" then 10
#   when "med" then 100
#   else  1000
# end
# min = 1

# puts "Guess the number between  #{"min"} and #{"max"}"



random_number = Random.new.rand(100)
puts "guess the number between 0 and 100."
loop do
  print "Enter guess (or e to exit): "
  answer = gets.chomp
   if answer == "e"
     puts "the number was #{random_number}."
      break
    else
     if answer.to_i == random_number
    puts "You got it!"
       break
     else
        if answer.to_i > random_number
            puts "You guessed over"
        else 
            puts "You guessed under"
        end
       puts "Guess again!"
       end
     end
  end

#random_number = Random.new.rand(100)


