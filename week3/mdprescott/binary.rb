#@lowvalue = 1
#@highvalue = 100
#arr = (@lowvalue..@highvalue).to_a
#my_num = 22

def clown
puts "=" *50
puts "
      __________\t     ________________\n
   -/  _      _  \\- \t   /                 \\\n
 / / / 0 \\  / 0 \\ \\ \\\t  | I have an idea... |\n
/ |  @     _    @  | \\\t /_\\__________________/\n
|  \\      ^ ^      /  |\n
 \\_ \\_   ----   _/ _/\t\n
       \\__/\\__/ "
puts "=" *50
end

def get_num(my_num)
  puts "\nThe clown tells you he has a smarter way of guessing your number...\n\n"
  clown
  sleep(2)
  print "\n\nI write down a number on a piece of paper: "
  my_num = gets.chomp.to_i
end

def get_arr(arr)
  puts "\n"
  print "I tell the clown my number is greater than: "
  lowvalue = gets.chomp.to_i
  puts "\n"
  print "I tell the clown my number is less than: "
  highvalue = gets.chomp.to_i
  puts "\n"
  print "Okay Clown, guess my number!\n"
  arr = (lowvalue..highvalue).to_a
end

def binary_search(my_num, arr)
  middle = arr[arr.length / 2]
  minu = 0
  maxu = arr.length - 1

    while minu <= maxu
      sleep(2)
      puts "\nThe clown asks: 'Is your number #{middle}?'"
    if middle == my_num
        sleep(1)
        puts "\nI say: 'Yes, Clown. My number is #{my_num}.'\n\n\n"
        puts "=" *75
        puts "A sense of uneasiness washes over me as I realize the clown is learning..."
        puts "=" *75
        puts "\n\n\n"
        break
    elsif middle < my_num
        sleep(1)
        puts "I say: Wrong! 'My number is greater than #{middle}.'\n"
        minu = middle + 1
        middle = (minu + maxu) / 2
    else
        sleep(1)
        puts "I say: Wrong! 'My number is lower than #{middle}.'\n"
        maxu = middle - 1
        middle = (minu + maxu) / 2
    end
  end
end

def run_it
  my_num = get_num(my_num)
  arr = get_arr(arr)
  binary_search(my_num, arr)
end

run_it
