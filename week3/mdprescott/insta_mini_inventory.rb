@warehouses = [] #outer array holding warehouses, index holds the warehouse and inventory hash, inventory hash holds items and prices
@responses = ["y", "n"] #applicable answers to Y/N questions

def intro
  puts "=" *80
  puts "Welcome to Basic Inventory Creation!"
  puts "=" *80
  sleep(1)
  puts "Let's get started..."
  sleep(1)
  puts "=" *80
end

def add_warehouse
  print "\nWhat is the warehouse name? "
  name = gets.chomp.to_s
  new_warehouse = {name: name, items: []} #adds new_warehouse hash to warehouse array, inventory file lives in the warehouse name_hash
  @warehouses << (new_warehouse)
  sleep(1)
  puts "\nOkay, now that we know the warehouse. Lets add some items!\n"
  puts "=" *60
  add_warehouse_items
end

def ask_add_warehouse
  if @warehouses.length == 0
    print "\nWould you like add a warehouse? (Y/N) "
    response_aaw = gets.chomp.downcase
  else
    puts "\nWould you like to add another warehouse? (Y/N)"
    response_aaw = gets.chomp.downcase
  end
  loop do
    while @responses.include?(response_aaw) == false
      puts "\nSorry, I didn't quite get that. Would you like to add a warehouse? (Y/N)"
      response_aaw = gets.chomp.downcase
    end
    break if @responses.include?(response_aaw)
  end
    if response_aaw == "y"
      puts "\nGreat! Lets add the warehouse"
      add_warehouse
    elsif @warehouses.length == 0
      puts "\nI guess we don't need any inventory..."
    else
      puts "\nOkay, the warehouses are all set up!"
    end
end

def add_warehouse_items
  loop do
    print "\n\nWhat item would you like to add? "
      item = gets.chomp.to_s
    print "How much is it? (Do not include '$') "
      price = gets.chomp.to_f
    loop do
      while price <= 0
        puts "\nThat doesn't seem right... How much is it? (Do not include '$')"
        price = gets.chomp.to_f
      end
      break if price > 0
    end
  warehouse_items = { item: item, price: price}
  @warehouses[@warehouses.length - 1][:items] << (warehouse_items) #warehouses length calculation creats correct index for array
  print "Added!"
  print "\n\nWould you like to add another item? (Y/N) "
    response_awi = gets.chomp.downcase.to_s
  loop do
    while @responses.include?(response_awi) == false
      puts "\nSorry, I didn't quite get that. Would you like to add a warehouse? (Y/N)"
      response_awi = gets.chomp.downcase
    end
    break if @responses.include?(response_awi)
    end
  break if response_awi == "n"
  end
  ask_add_warehouse
end


def display_stores
  puts "=" *80
  puts"Here's the Inventory!"
  puts "=" *80
  variable = 0
    loop do
      puts "\tStore Name: #{@warehouses[@warehouses.length - (@warehouses.length - variable)][:name]}\n" #warehouses length calculation added to pull from correct array position
      @warehouses[@warehouses.length - (@warehouses.length - variable)][:items].each do |item|  # warehouses length calculation identifies the correct has in the array, .each do pulls individual items and prices from hash
        puts "\t\tItem: #{item[:item]}\t\tPrice: $" + sprintf("%0.2f", item[:price]) +"\n"
      end
      variable += 1
      break if variable == @warehouses.length
    end
  puts "=" *80
  puts"Your inventory files are all set up!"
  puts "=" *80
end

def run_it
  intro
  ask_add_warehouse
  unless @warehouses.length == 0
  display_stores
  end
end

run_it
