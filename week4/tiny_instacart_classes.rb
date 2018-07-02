require 'byebug'

class Item

    attr_accessor :name, :price

    def initialize(name, price)
        @name = name
        @price = price
    end

    def name
        @name
    end

    def price
        @price
    end
end

class Customer

    attr_accessor :name, :address, :phone_number

    def initialize(name, address, phone_number)
        @name = name
        @address = address
        @phone_number = phone_number
    end

    def name
        @name
    end

    def address
        @address
    end
end

class Shopper

    attr_accessor :name, :zone

    def initialize(name, zone)
        @name = name
        @zone = zone
    end

    def name
        @name
    end

    def zone
        @zone
    end
end

class Orders

    attr_accessor :item_name, :quantity

    def initialize(order)
        @order = order
        #@total = 0
    end

    def order
        @order
    end

    # def order_total
    #     @order.each { |order_number|
    #         order_number.order.each { |key, value|
    #             @total += (key.to_sym.price * value)
    #         }
    #     }
    #     return @total
    # end
end

shopper = [
    Shopper.new("Kyle", "San Francisco, CA"),
    Shopper.new("Brad", "Oakland, CA"),
    Shopper.new("Jessica", "San Jose, CA")
]

@items = {
    beer: Item.new("beer", 15.99),
    chips: Item.new("chips", 3.99),
    hot_dog: Item.new("hot dog", 3.99)
}

@customers_list = []
#@cart = []
@orders = []

def register
    puts "Welcome to Tiny Instacart! Please create an account."
    print "What is your name?: "
    name = gets.chomp
    print "What is your address?: "
    address = gets.chomp
    print "What is your phone number?: "
    phone_number = gets.chomp
    puts "Thank you for registering!"

    @customers_list.push(Customer.new(name, address, phone_number))
end

def order
    puts "These are the items that we have for sale?"
    @items.each { |key, value|
        puts "Name: #{key}, Price: #{value.price}"
    }
    answer = 0
    cart = {}
    until answer == "n"
        print "What would you like to order? Please order the name of the item.: "
        item = gets.chomp.downcase.to_sym
        if @items.keys.include? item
            item_count = 0
            unless item_count.to_i > 0
                print "How many would you like? "
                item_count = gets.chomp
                if item_count.to_i == 0
                    puts "Sorry, I'm unable to process that number."
                elsif item_count.to_i > 0
                    item_count = item_count.to_i
                else
                    puts "Error!"
                end
            end
            cart[item] = item_count
            puts "#{item_count} #{item}(s) have been added to your cart!"
            print "Do you want to add more items to your cart?(y/n): "
            answer = gets.chomp.downcase
            if answer == "n" || answer == 'no'
                answer = "n"
                puts "Your cart is ready for check out."
            end
        else
            puts "Error"
        end
    end
    @orders.push(Orders.new(cart))
end

register()
order()
total = 0
@orders.each { |order_number|
    order_number.order.each { |key, value|
        total += (@items[key].price * value)
    }
}
puts "\n"
puts "Here is your order:"
@orders.each { |order_number|
    order_number.order.each { |key, value|
        puts "Item name: #{key}, Quantity: #{value}"
    }
}
puts "------------------------------------"
puts "You're total is: #{total}"
driver = 0
byebug
shopper.each { |shopper|
    if @customers_list[0].address.include? shopper.zone
        driver = shopper.name
    else
        driver = "Kyle"
    end
}
puts "Thanks for using Tiny Instacart! Your shopper is #{driver}, and will be delivered shortly."
