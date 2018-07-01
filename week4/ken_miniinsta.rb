class Item
    attr_accessor :price, :name

    def initialize(name, price)
        @name = name
        @price = price
    end 
end

cheese = Item.new("cheese", 8)
popsicle = Item.new("popsicle", 2.5)
fruit_snack = Item.new("Fruit Snack", 2)
catalog = {
  popsicle: popsicle,
  cheese: cheese,
  fruit_snack: fruit_snack
}


class Shopper
    attr_accessor :name

    def initialize(name)
        @name = name
        @order = nil
    end

    def assign_order(order)
        @order = order
        @order.status = "assigned"
    end

    def current_order()
        return @order
    end

    def pick_current_order()
        @order.status = "picked"
    end

    def deliver_current_order()
        @order.status = "fulfilled"
    end
end

paul = Shopper.new("Paul")
emilio = Shopper.new("Emilio")
mc = Shopper.new("mc")
shoppers = [paul, emilio, mc]


class Order
    attr_accessor :status

    def initialize(items)
        @items = items
        @status = "pending"
    end
end


class Cart
    attr_accessor :items

    def initialize()
        @items = []
    end

    def total()
        total = 0
        @items.each do |item|
            total = total + item.price
        end
        return total
    end
end

class Customer
    attr_accessor :orders, :address, :cart

    def initialize()
        @orders = []
        @address = ""
        @cart = Cart.new
    end

    def add_item_to_cart(item) 
        @cart.items.push(item) 
    end     

    def place_order()
        @orders.push(Order.new(@cart.items))
        @cart.items = []
    end
end

ken = Customer.new()
ken.address = "123 Fake St. San Francisco, CA"


puts "Ken add #{cheese.name} to cart"
ken.add_item_to_cart(cheese)
puts "Total of the cart: #{ken.cart.total}"

puts "Now Ken added #{popsicle.name} to cart"
ken.add_item_to_cart(popsicle)

puts "Now the Total of the cart is: #{ken.cart.total}"

ken.place_order
puts "Now Ken has orders"

order = ken.orders.last

shopper = shoppers.sample
puts  "The shopper is #{shopper.name}"

puts "The status of my order is #{order.status}"

shopper.assign_order(order)
puts "The status of my order is #{order.status}"

puts shopper.current_order

shopper.pick_current_order
puts "The status of my order is #{order.status}"

shopper.deliver_current_order

puts "The status of my order is #{order.status}"
