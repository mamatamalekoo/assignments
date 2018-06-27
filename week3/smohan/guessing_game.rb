
random_number = rand(10)

puts "Guess a number between 0 and 10!"
loop do
  puts "Enter a number or press E to end the game."
  guess = gets.chomp
  if guess.to_i == random_number
    puts "Nice work! You guessed correctly!"
    break
  elsif guess == "E"
    puts "Goodbye!"
    break
  elsif guess.to_i != random_number
    puts "Guess again!"
  end
end
