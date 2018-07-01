require "./moduleyesno.rb"

class NewWarehouse
  include YesNo
  include Enumerable
  attr_accessor :id, :name, :items, :item_id_array

  def initialize
    @items = []
    @item_id_array = []
  end

  def id
    @id
  end

  def name
    @name
  end

  def items
    @items
  end

  def itemidarray
    items.each do |item|
      if @item_id_array.any? == false
        @item_id_array << item.id
      else
        unless @item_id_array.include?(item.id)
          @item_id_array << item.id
        end
      end
    end
  end

  def each(&block)
    items.each(&block)
  end

  def to_s
    "ID: #{id} Name: #{name} Items: #{items}"
  end

  def add_items
    loop do
      item = Item.new
      itemidarray
      if item_id_array.any?
      item.id = item_id_array.max + 1
      else
      item.id = 1
      end
      print "\nWhat item would you like to add? "
      item.name = gets.chomp.to_s
      print "How much is it? (Do not inlude '$') "
      item.price = gets.chomp.to_f
      while item.price <= 0
        print "\nThat doesn't seem right... How much is it? (Do not inlude '$') "
        item.price = gets.chomp.to_f
      end
      question = "Is the item sold by the pound? (Y/N) "
      print question
      response = yncheck(question)
      if response == "y"
      item.type = "looseweight"
      else item.type = "each"
      end
      items << item
      itemidarray
      question = "Would you like to add another item? (Y/N) "
      print "\n" + question
      response = yncheck(question)
    break if response == "n"
    end
  end
end
