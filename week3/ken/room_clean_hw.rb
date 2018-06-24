
def user_approval
 print "Please enter user data to proceed (y/n): "
    user_response = gets.chomp
    if user_response == "y"
      puts "Thanks!"
      return true
    else
      puts "no cleaning for you today"
      return false      
    end
 end






def user
    print "what is your first name?"
    f_name = gets.chomp.upcase

    print "what is your last name?"
    l_name = gets.chomp.upcase

    print "what is your age?"
    age = gets.chomp.to_i


    puts "Thank you for providing this information. Your name is #{f_name} #{l_name} and you are #{age} years of age. We will now begin the cleaning process."
end


rooms = ["bedroom", "kitchen", "bathroom", "livingroom"]



def clean_house(rooms)
    rooms.each do |room|
        clean_room(room)
    end
end


def clean_room(room)
    if room == "bedroom"
        make_bed
        vacuum(room)
    elsif room == "kitchen"
        mop_floor
    else
            puts "This room doesn't require any special processes."
    end
    dust(room)
    puts "The " + room + " has been cleaned!"
end






def make_bed
    puts "The beds have been made"
end

def vacuum(room)
        puts "The #{room} has been vacuumed."
end

def dust(room)
        puts "The #{room} has been dusted!"
end

def mop_floor
        puts "The floor has been mopped."
end


def clean_rooms(room, other_room)
 puts "The "  + room + " has been cleaned!"
 puts "The " +other_room + "has been cleaned!"
end

def add_two_numbers(number1, number2)
     if (number1 + number2) > 0
     number1 + number2
    else puts "the result is negative"
    end  
end


if user_approval
    sleep(2)
    user
    sleep(2)
    puts "Please hold tight as we clean"
    sleep(10)
    puts "Almost done...Appreciate your patience"
    sleep(3)
    clean_house(rooms)
    sleep(3)
    puts "The cleaning process is now complete. Goodbye."
end
