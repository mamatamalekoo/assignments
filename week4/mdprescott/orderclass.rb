require "./moduleyesno"
require "./itemclass"
require "./newwarehouseclass"
require "./inventory.rb"
require "./orderitemclass.rb"
require "./deliverybatch"
require "./shopperbook"

class Orders
  include YesNo
  include Enumerable
  attr_accessor :shopping_cart, :warehouse_name, :orderitem

  def initialize
    @shopping_cart = []
  end

  def shopping_cart
    @shopping_cart
  end

  def warehouse_name
    @warehouse_name
  end

  def orderitem
    @orderitem
  end

  def each(input, &block)
    shopping_cart.each(&block)
  end

  def display_inventory_all
    inventory.print_inventory
  end

  def quantity_ask(item)
    if item.type == "looseweight"
      print "#{item.name} costs $#{sprintf("%0.2f", item.price)} per lb\n"
      print "How many pounds would you like to add? "
      quantity = gets.chomp.to_f
    elsif item.type == "each"
      print "#{item.name} costs $#{sprintf("%0.2f", item.price)} each\n"
      print "How many would you like to add? "
      quantity = gets.chomp.to_i
    else
    end
    return quantity
  end


  def build_cart
    inventory = WarehouseList.new
    print "Welcome to Instacart Mini!\n"
    puts"Please see our options below: "
    inventory.print_warehouses
    warehouseidarray = []
    inventory.warehouse_list.each do |warehouse|
      warehouseidarray << warehouse.id
    end
    print "\nSelect a warehouse to start shopping! Enter Warehouse ID:"
    wid = gets.chomp
    until warehouseidarray.include?(wid.to_i)
      puts "It looks like there are no warehouses with that id. Enter warehouse Id: "
      wid = gets.chomp
    end
    inventory.find_by_id(wid)
    itemidarray = []
    inventory.warehouse_list.each do |warehouse|
      if warehouse.id.to_s == wid.to_s
      @warehouse_name = warehouse.name
      warehouse.items.each do |item|
        itemidarray << item.id
      end
      end
    end
    puts "To add an item to your cart, simply enter the item ID! To stop adding items, enter \"Done\"!\n"
    loop do
    print "Enter Item Id: "
    selection = gets.chomp.to_s
    until itemidarray.include?(selection.to_i) || selection.downcase.tr("!", "") == "done"
      puts "It looks like there are no items with that id. Enter Item Id: "
      selection = gets.chomp.to_s
    end
    break if selection.downcase.tr("!", "") == "done"
    inventory.warehouse_list.each do |warehouse|
      if warehouse.id.to_s == wid.to_s
        warehouse.items.each do |item|
          if item.id == selection.to_i
            orderitem = OrderItem.new
            orderitem.warehouse_id = wid
            orderitem.item = item
            orderitem.quantity = quantity_ask(item)
            shopping_cart << orderitem
          end
        end
      end
    end
    end
    puts "\n" * 2
    puts "All set! Here is your shopping list:"
    puts "\n"
    puts "=" * 35
    shopping_cart.each do |orderitem|
    puts "#{orderitem.item.name} x #{orderitem.quantity}\t $#{sprintf("%0.2f", orderitem.price)}"
    end
    puts "=" * 35
    puts "\nWe will send someone right away!"
    puts "\n" *3
    sleep(3)
  end

  def assign_to_shopper
    batch = DeliveryBatch.new
    shoppers = ShopperBook.new
    batch.shopper = shoppers.shopper_list.sample
    batch.shopping_list = shopping_cart
    batch.warehouse_name = @warehouse_name
    puts "Insta Mini Shopper #{batch.shopper.first_last_short} has accepted your order and is on the way to shop!"
    sleep(3)
    puts "\n#{batch.shopper.first_last_short} has arrived at #{warehouse_name}! #{batch.shopper.first_name} will begin shopping soon.\n"
    sleep(2)
    shopping_cart.each do |orderitem|
    puts "#{batch.shopper.first_name} has purchased the #{orderitem.item.name} for $#{orderitem.price_format}"
    sleep(1)
    end
    sleep(1)
    puts "\n\n#{batch.shopper.first_last_short} has checked out and is on the way to deliver!"
    sleep(3)
    puts "\n\nYour order has been delivered. Thank you for using Instacart Mini!"
  end

  def print_receipt
    pricearray = []
    puts "=" *30
    puts "Receipt:\n"
    shopping_cart.each do |orderitem|
      puts "#{orderitem.item.name} x #{orderitem.quantity}\t $#{orderitem.price_format}"
      pricearray << orderitem.price.to_f
    end
    total = pricearray.inject(0){|sum,x| sum + x}
    puts "\nTotal:\t#{total.round(2)}"
    puts "=" *30
  end




end

order = Orders.new
order.build_cart
order.assign_to_shopper
order.print_receipt
