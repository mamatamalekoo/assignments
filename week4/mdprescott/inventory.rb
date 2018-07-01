require "./moduleyesno"
require "./itemclass"
require "./newwarehouseclass"
require "yaml"

class WarehouseList
  include YesNo
  include Enumerable
  attr_accessor :warehouse_list, :warehouse_id_array

  def initialize
    @warehouse_list = []
    @warehouse_id_array = []
    open
  end

  def open
    if File.exist?("inventory.yml")
      unless File.zero?("inventory.yml")
      @warehouse_list = YAML.load_file("inventory.yml")
      end
    end
  end

  def save
    File.open("inventory.yml", "w") do |file|
      file.write(warehouse_list.to_yaml)
    end
  end

  def warehouse_list
    @warehouse_list
  end

  def warehouseidarray
    warehouse_list.each do |warehouse|
      if @warehouse_id_array.any? == false
        @warehouse_id_array << warehouse.id
      else
        unless @warehouse_id_array.include?(warehouse.id)
          @warehouse_id_array << warehouse.id
        end
      end
    end
  end

  def each(input, &block)
    warehouse_list.each(&block)
  end

  def run
    loop do
    puts "\n"
    puts "="*42
    puts "Welcome to the Inventory Management Menu!"
    puts "Options:"
    puts "Add New Warehouses: A".rjust(42)
    puts "Edit Existing Warehouse: E".rjust(42)
    puts "Delete Warehouse: D".rjust(42)
    puts "Search Warehouses: S".rjust(42)
    puts "Print Inventory: P".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
        print "\n Make your selection: "
        response = gets.chomp.downcase
        if response == "x"
          puts "\nGoodbye!"
          save
        break
        elsif response == "a"
          add_warehouse
        elsif response == "e"
          edit_warehouses
        elsif response == "d"
          delete_warehouse
        elsif response == "p"
          print_inventory
        elsif response == "s"
          search_warehouses
        end
      end
  end

  def add_warehouse
    loop do
      warehouse = NewWarehouse.new
      if warehouse_id_array.any?
      warehouse.id = warehouse_id_array.max + 1
      else
      warehouse.id = 1
      end
      print "\nWhat is the name of the warehouse? "
      response_w = gets.chomp.to_s
      while @warehouse_list.any?{ |warehouse| warehouse.name == response_w }
        print "\nThere is already a #{response_w} warehouse! Warehouse names must be unique. What is the name of the warehouse?"
        response_w = gets.chomp.to_s
      end
      warehouse.name = response_w
      question = "Would you like to add items to this warehouse? (Y/N)"
      print "\n" + question
      response = yncheck(question)
      if response == "y"
      warehouse.add_items
      else
      print "\nI guess warehouses don't need items...\n"
      end
      @warehouse_list << warehouse
      warehouseidarray
      question = "Would you like to add another warehouse? (Y/N) "
      print "\n" + question
      response = yncheck(question)
    break if response == "n"
    end
  end

  def edit_warehouses
    print_warehouses
    warehouseidarray
    print "\n Which warehouse would you like to edit? "
    edit = gets.chomp.to_i
    while !@warehouse_id_array.include?(edit)
    puts "Sorry! I don't see a warehouse with and ID of #{edit}.\nWhich warehouse would you like to edit?\nEnter Warehouse ID: "
    edit = gets.chomp.to_i
    end
    edit_warehouse_menu(edit)
  end

  def edit_warehouse_menu(edit)
    loop do
    puts "\n"
    puts "="*42
    puts "Edit Options: "
    puts "Add Item: A".rjust(42)
    puts "Delete Item: D".rjust(42)
    puts "Edit Existing Items: E".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
    print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
      elsif response == "a"
        warehouse_list.each do |warehouse|
          if warehouse.id == edit
            warehouse.add_items
          end
        end
      elsif response == "d"
        warehouse_list.each do |warehouse|
          if warehouse.id == edit
            warehouse.items.each do |item|
            puts "=" * 20
            puts "\n" + "ID: #{item.id}, #{item.name}, #{item.price}, #{item.type}"
            end
            puts "=" * 20
          end
        end
        print "\nWhich item would you like to delete? Enter ID: "
        itemid = gets.chomp.to_i
        warehouse_list.each do |warehouse|
          if warehouse.id == edit
            warehouse.items.each do |item|
              if item.id == itemid
                warehouse.items.delete(item)
              end
            end
          end
        end
      elsif response == "e"
        edit_items_selection(edit)
      end
      puts "\n" * 10
    end
  end

    def edit_items_selection(edit)
      warehouse_list.each do |warehouse|
        if warehouse.id == edit
          warehouse.items.each do |item|
          puts "=" * 20
          puts "\n" + "ID: #{item.id}, #{item.name}, #{item.price}, #{item.type}"
          end
          puts "=" * 20
        end
      end
      print "\nWhich item would you like to edit? Enter ID: "
      itemid = gets.chomp.to_i
      edit_item_menu(edit, itemid)
    end

    def edit_item_menu(edit, itemid)
      loop do
      puts "\n"
      puts "="*42
      puts "Edit Options: "
      puts "Edit Name: N".rjust(42)
      puts "Edit Price: P".rjust(42)
      puts "Edit Type: T".rjust(42)
      puts "Exit: X".rjust(42)
      puts "="*42
      print "\n Make your selection: "
        response = gets.chomp.downcase
        if response == "x"
        break
        elsif response == "n"
          warehouse_list.each do |warehouse|
            if warehouse.id == edit
              warehouse.items.each do |item|
                if item.id == itemid
                  print "Enter Name: "
                  item.name = gets.chomp.to_s
                end
              end
            end
          end
        elsif response == "p"
          warehouse_list.each do |warehouse|
            if warehouse.id == edit
              warehouse.items.each do |item|
                if item.id == itemid
                  print "Enter Price: "
                  item.price = gets.chomp.to_f
                  while item.price <= 0
                    print "\nThat doesn't seem right... How much is it? (Do not inlude '$') "
                    item.price = gets.chomp.to_f
                  end
                end
              end
            end
          end
        elsif response == "t"
          warehouse_list.each do |warehouse|
            if warehouse.id == edit
              warehouse.items.each do |item|
                if item.id == itemid
                  question = "Is the item sold by the pound? (Y/N) "
                  print question
                  response = yncheck(question)
                  if response == "y"
                  item.type = "looseweight"
                  else item.type = "each"
                  end
                end
              end
            end
          end
        end
      puts "\n" * 10
      end
    end

  def delete_warehouse
    print_warehouses
    warehouseidarray
    print "\nWhich warehouse would you like to delete?\nEnter Warehouse ID: "
    deleted = gets.chomp.to_i
    while !@warehouse_id_array.include?(deleted)
    puts "Sorry! I don't see a warehouse with and ID of #{deleted}.\nWhich warehouse would you like to delete?\nEnter ID: "
    deleted = gets.chomp.to_i
    end
    find_by_id(deleted)
    question = "Are you sure you want to delete this warehouse? (Y/N)"
    print "\n" + question
    response = yncheck(question)
    unless response == 'n'
    delete_warehouse_id(deleted)
    end
  end

  def delete_warehouse_id(deleted)
    warehouse_list.each do |customer|
    if warehouse.id == id
      @warehouse_list.delete(warehouse)
    end
  end
end

  def find_by_id(search)
    results = []
    warehouse_list.each do |warehouse|
      if warehouse.id == search.to_i
        results << warehouse
      end
    end
    if results.any?
    print_results(results)
    else
    puts "No results."
    end
  end

  def find_by_warehouse_name(search)
    results = []
    warehouse_list.each do |warehouse|
      if warehouse.name.include?(search)
        results << warehouse
      end
    end
    print_results(results)
  end

  def find_by_item_name(search)
    results = []
    warehouse_list.each do |warehouse|
      warehouse.items.each do |item|
        if item.name.downcase.include?(search.downcase)
          results << warehouse
        end
      end
    end
    results.each do |warehouse|
      puts "=" * 30
      puts "\nName:\n#{warehouse.name}"
      warehouse.items.each do |item|
        if item.name.downcase == search.downcase
          puts puts "ID: #{item.id} Item: #{item.name}\tPrice: $#{sprintf("%0.2f", item.price)}\t Type: #{item.type}"
        end
      end
    end
  end

  def search_warehouses
    loop do
    puts "\n"
    puts "="*42
    puts "Welcome to the Inventory Management Menu!"
    puts "Options:"
    puts "Search Warehouse by ID: ID".rjust(42)
    puts "Search Warehouse by Name: N".rjust(42)
    puts "Search Warehouse by Item: I".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
      print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
    elsif response == "id"
        print "Enter Warehouse ID: "
        search = gets.chomp
        find_by_id(search)
      elsif response == "n"
        print "Enter Warehouse Name: "
        search = gets.chomp
        find_by_warehouse_name(search)
      elsif response == "i"
        print "Enter Item Name: "
        search = gets.chomp
        find_by_item_name(search)
      end
    end
  end


  def print_results(results)
    results.each do |warehouse|
      puts "=" * 30
      puts "\nName:\n#{warehouse.name}"
      puts "\nItems: "
      warehouse.items.each do |item|
        puts "ID: #{item.id} Item: #{item.name}\tPrice: $#{sprintf("%0.2f", item.price)}\t Type: #{item.type}"
      end
      puts "\n"
      puts "=" * 30
    end
  end

  def print_warehouses
    puts "\n"
    puts "=" * 49
    puts "=" * 49
    variable = 0
    @warehouse_list.each do |warehouse|
      variable += 1
      puts "\nID: #{warehouse.id}\tWarehouse: #{warehouse.name}\n\n"
      end
    puts "\n"
    puts "=" * 65
    puts "=" * 65
  end

  def print_inventory
    puts "\n"
    puts "=" * 65
    puts "=" * 65
    variable = 0
    @warehouse_list.each do |warehouse|
      puts "\nID: #{warehouse.id}\tWarehouse: #{warehouse.name}\n\n"
      variable += 1
        warehouse.items.each do |item|
          puts "ID: #{item.id} Item: #{item.name}\tPrice: $#{sprintf("%0.2f", item.price)}\t Type: #{item.type}"
          end
    end
    puts "\n"
    puts "=" * 65
    puts "=" * 65
  end


  def to_s
    "#{@name}: #{@warehouse_list}"
  end
end

#inventory = WarehouseList.new
#inventory.run
