
def ask_user
  puts "Would you like your room cleaned? (Y/N)"
  user_input = gets.chomp
  if user_input == 'Y'
    puts "We will get right to it!"
    return true
  else
    puts "Oh well, goodbye!"
    return false
  end
end

rooms = ["bedroom", "kitchen", "bathroom", "living room"]

def clean_house(rooms)
  sleep 3
  rooms.each do |room|
    clean_room(room)
  end
end


def clean_room(room)
  if #the room is a bedroom
      room == "bedroom"
      make_bed
      vaccum(room)
  elsif room == "kitchen"
     mop_floor
  end
  dust(room)
  puts "The " + room + " has been cleaned!"
end

def make_bed
  puts "The beds have been made."
end

def vaccum(room)
  puts "The #{room} has been vaccumed."
end

def dust(room)
  puts "The #{room} has been dusted!"
end

def mop_floor
  puts "The floor has been mopped."
end

if ask_user
  clean_house(rooms)
end
