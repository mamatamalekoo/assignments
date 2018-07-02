
def user_approval
 print "Please enter user data to proceed? (yes/no): "
    user_response = gets.chomp
        if user_response == "yes"
            puts "Thanks!"
            return true
        else
            puts "no cleaning for you today"
            return false
        end
end

def user
    print "what is your first name? "
        f_name = gets.chomp.upcase
    print "what is your last name? "
        l_name = gets.chomp.upcase
    print "what is your age? "
        age = gets.chomp.to_i
    puts "Thank you for providing this information. Your name is #{f_name} #{l_name} and you are #{age} years of age. We will now begin the cleaning process."
end

rooms = ["bedroom", "kitchen", "bathroom", "living room"]

def clean_house(rooms)
    rooms.each do |room|
    clean_room(room)
    end
end


def clean_room(room)
    if room == "bedroom"
        make_bed
        vacuum(room)
        sleep(3)
    elsif room == "kitchen"
        mop_floor
        sleep(2)
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

if user_approval
    user
    sleep(2)
    puts "Please hold tight as we clean"
    sleep(4)
    puts "Almost done...Appreciate your patience"
    sleep(3)
    clean_house(rooms)
    sleep(3)
    puts "The cleaning process is now complete. Goodbye."
end
