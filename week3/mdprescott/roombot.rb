
@options = ["bedroom", "bathroom", "living room", "kitchen", "garage"]
@responses = ["y","n"]
@rooms = []
room = ""
response = ""
receipt_request = ""
total_cost = ""
@price_array = []
spec_mult = 0
@bathroom_price = 10
@bedroom_price = 15
@kitchen_price = 20
@living_room_price = 20
@garage_price = 25
@special_price = 10


def print_logo
puts "_____/\\\\\\\\\\\\\\\\\____________/\\\\\\\\\\\\\\\\\\_____/\\\\\\\\\\\\\\\\\\_____
 ___/\\\\\\\\\\\\\\\\\\\\\\\\\\_______/\\\\\\////////____/\\\\\\///////\\\\\\___
  __/\\\\\\/////////\\\\\\____/\\\\\\/____________\\/\\\\\\_____\\/\\\\\\___
   _\\/\\\\\\_______\\/\\\\\\___/\\\\\\______________\\/\\\\\\\\\\\\\\\\\\\\\\/____
    _\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\__\\/\\\\\\______________\\/\\\\\\//////\\\\\\____
     _\\/\\\\\\/////////\\\\\\__\\//\\\\\\_____________\\/\\\\\\____\\//\\\\\\___
      _\\/\\\\\\_______\\/\\\\\\___\\///\\\\\\___________\\/\\\\\\_____\\//\\\\\\__
       _\\/\\\\\\_______\\/\\\\\\_____\\////\\\\\\\\\\\\\\\\\\__\\/\\\\\\______\\//\\\\\\_
        _\\///________\\///_________\\/////////___\\///________\\///__"
end

def intro
  puts "\n\nWelcome to the Automated Cleaning Robot!!\n\n"
  puts "=" * 55
  print_logo
  puts "=" *65
  puts "\n\n"
  puts "We will clean your Bedroom, Bathroom, Living Room, Kitchen, and Garage for you!\n\n\tOur prices are:\n\n\t\tBathrooms:\t\t$#{@bathroom_price}\n\t\tBedrooms:\t\t$#{@bedroom_price}\n\t\tLiving Rooms:\t\t$#{@living_room_price}\n\t\tKitchens:\t\t$#{@kitchen_price}\n\t\tGarages:\t\t$#{@garage_price}\n\n\nJust let us know what you need cleaned!\n\n"
  puts puts "=" *50
  sleep(2)
end

def outro
  sleep(2)
  puts "\n\nThanks for using the Automated Cleaning Robot!!!\n\n"
  puts "=" * 55
  print_logo
  puts "=" *65
  puts "\n\n Hope to see you again soon!"
  puts "\n\n\n"
end

def room_ask(room, response)
  loop do
      puts "\nWhat room would you like cleaned?"
      room = gets.chomp.downcase
        if @rooms.include?(room)
          puts "\nWe've already got the #{room} on the list!"
        elsif @options.include?(room)
          @rooms.push(room)
        else
          puts "\nSorry! We don't clean #{room}s. We clean Bedrooms, Bathrooms, Living Rooms, Kitchens, and Garages.\n"
        end
          unless @rooms.length >= 5
            puts "\nWould you like to add another room? (Y/N)"
              response = gets.chomp.downcase
        loop do
            if @responses.include?(response) == false
              puts "\nSorry, I didn't quite get that. Would you like to add another room? (Y/N)"
              response = gets.chomp.downcase
            else end
        break if @responses.include?(response)
          end
      end
    break if response == "n" || @rooms.length >= 5
  end
end

def ask_special
  puts "\nWould you like to purchase our Sqeuaky Clean Guarantee for an additional $#{@special_price} per room? (Y/N)"
  @special = gets.chomp.downcase
end

def watch_it_go
  sleep(1)
  puts "\n\n\n\n"
  puts "=" * 55
  print_logo
  puts "=" *65
  puts "\n\n\t\t Watch it go!\n\n"
  puts "=" *50
end

def clean_room(room)
  puts "\n"
  puts "Starting to clean the #{room}!"
  sleep(1)
  puts "=" * 50
  puts "└[∵┌]└[ ∵ ]┘[┐∵]┘" * 3
  puts "=" * 50
  dust(room)
  if room == "bedroom" && @special != "y"
  make_bed
  laundry
  vaccum(room)
  trash
elsif room == "bedroom" && @special == "y"
  make_bed
  laundry
  vaccum(room)
  trash
  pillows
elsif room == "bathroom" && @special != "y"
  sink
  mop_floor
  toilet
  trash
elsif room == "bathroom" && @special == "y"
  sink
  mop_floor
  toilet
  trash
  potpourri
elsif room == "kitchen" && @special != "y"
  dishes
  sink
  mop_floor
  trash
elsif room == "kitchen" && @special == "y"
  dishes
  sink
  mop_floor
  beer
elsif room == "living room" && @special != "y"
  vaccum(room)
  wipe
  trash
elsif room == "living room" && @special == "y"
  vaccum(room)
  wipe
  trash
  flowers
elsif room == "garage" && @special != "y"
  swept(room)
  wipe
  trash
elsif room == "garage" && @special == "y"
  swept(room)
  wipe
  trash
  body
  end
  puts "The #{room} is clean!\n"
  sleep(1)
  puts "=" * 50
  puts "└[∵┌]└[ ∵ ]┘[┐∵]┘" * 3
  puts "=" * 50
  sleep(1)
end

def make_bed
  puts "The beds have been made."
end

def laundry
  puts "The laundry has been folded."
end

def trash
  puts "The trash has been emptied."
end

def vaccum(room)
  puts "The #{room} has been vaccumed."
end

def swept(room)
  puts "The #{room} has been swept."
end

def dust(room)
  puts "The #{room} has been dusted."
end

def mop_floor
  puts "The floor has been mopped."
end

def dishes
  puts "The dishes have been done."
end

def sink
  puts "The sink has been scrubbed."
end

def toilet
  puts "The toilet has been scrubbed."
end

def wipe
  puts "The tables have been wiped down."
end

def pillows
  puts "***The pillows have been fluffed!***"
end

def potpourri
  puts "***The potpourri has been refreshed!***"
end

def beer
  puts "***A cold beer was left in the fridge!***"
end

def flowers
  puts "***Some fresh flowers have been left on the coffee table!***"
end

def body
  puts "***I've disposed of the body... ಠ_ಠ***"
end

def clean_house
  @rooms.each do |(room)|
  clean_room(room)
  end
end

def wrap_up
  sleep(1)
  puts "\n\n"
  puts "\t\tJust wrapping up...\n\n"
  sleep(1)
  puts "=" *55
  print_logo
  puts "=" *65
  puts "\n\n\n*****All set. The house is now clean!*****\n\n\n"
  puts "=" *50
  sleep(1)
end

def fill_receipt_room(room)
  if room == "bathroom"
    puts "\t\tBathroom Cleaned:\t\t\t$#{@bathroom_price}\n"
  elsif room == "bedroom"
    puts "\t\tBedroom Cleaned:\t\t\t$#{@bedroom_price}\n"
  elsif room == "kitchen"
    puts "\t\tKitchen Cleaned:\t\t\t$#{@kitchen_price}\n"
  elsif room == "living room"
    puts "\t\tLiving Room Cleaned:\t\t\t$#{@living_room_price}\n"
  elsif room == "garage"
    puts "\t\tGarage Cleaned:\t\t\t\t$#{@garage_price}\n"
  else end
end

def print_receipt(receipt_request, total_cost)
  puts "\nWould you like a receipt? (Y/N)"
  receipt_request = gets.chomp.downcase
  loop do
    if @responses.include?(receipt_request) == false
      puts "\nSorry, I didn't quite get that. Would you like a receipt? (Y/N)"
      receipt_request= gets.chomp.downcase
    else end
  break if @responses.include?(receipt_request)
  end
    if receipt_request != "n"
      puts "=" * 70
      puts "\n\tReceipt:\n"

      @rooms.each do |item|                         #Calculates the price of each room - pushes into price_array
        if item == "bathroom"
          @price_array.push(@bathroom_price)
        elsif item == "bedroom"
          @price_array.push(@bedroom_price)
        elsif item == "kitchen"
          @price_array.push(@kitchen_price)
        elsif item == "living room"
          @price_array.push(@living_room_price)
        elsif item == "garage"
          @price_array.push(@garage_price)
        else end
        end

      @spec_mult = @rooms.length * @special_price  #Calculates special price, adds to price_array
        if @special == "y"
          @price_array.push(@spec_mult)
        else
          @price_array.push(0)
        end

      total_cost = @price_array.inject(0, :+)      #Calculates total

      @rooms.each do |room|                       #Populates receipt with rooms and prices
        fill_receipt_room(room)
      end

      if @special == "y"                          #Adds line item for additional cost of special cleaning
        puts "\t\tSqueaky Clean Guarantee!\n\t\t\t\t\t\t#{@rooms.length} x $#{@special_price} = $#{@spec_mult}"
      else end

      puts "\n\n\tTotal Order:\t\t\t$#{total_cost}\n\n"
      puts "=" * 70
      outro
    else
      outro
  end
end

def run_it(room, response, receipt_request, total_cost)
  intro
  room_ask(room, response)
  ask_special
  watch_it_go
  clean_house
  wrap_up
  print_receipt(receipt_request, total_cost)
end

run_it(room, response, receipt_request, total_cost)
