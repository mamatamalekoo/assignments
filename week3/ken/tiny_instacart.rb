
#each.do | | takes in each item of the array. order_item can be anything.


def checkout
    total = 0
    @order_items.each do | name, attributes |
        add_to_receipt(name) #How does this know to pull the name from the hash?
        add_quantity(attributes["quantity"])
        sub_total = attributes["quantity"] * attributes["price"]
        puts "Total: #{sub_total}"
        total = total + sub_total
        print_seperator()
    end
    puts "Your overall total charge is $#{total.round(2)}"
end


# #This is the same as above
# # def checkout
# #     add_to_receipt(yogurt)
# #     add_to_receipt(steak)
# #     add_to_receipt(cheese)


def add_to_receipt(order_item)
    puts "Item: #{order_item}"
end

def add_quantity(order_item)   
    puts "Quantity: #{order_item}"
end
  
def print_seperator(character = "-")
     puts character * 40
 end 


def customer
    puts "What is your name?"
        customer = gets.chomp
    puts "Thank you #{customer}. Here is your receipt:" 
end 

@order_items = {
    "apple" => {
        "quantity" => 3, 
        "price" => 1.99
    }, 
    "steak" => {
        "quantity" => 2, 
        "price" => 9.88
    }, 
    "cheese" => {
        "quantity" => 4, 
        "price" => 3.50
    }
}

customer
sleep(2)

checkout()


