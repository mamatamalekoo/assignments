require "./customerclass"
require "./phonenumberclass"
require "./addressclass"
require "./moduleyesno"
require "yaml"

class CustomerBook
  include YesNo
  include Enumerable

  attr_accessor :customer_list, :customer_id_array

  def initialize
    @customer_list = []
    @customer_id_array = []
    open
  end

  def open
    if File.exist?("customers.yml")
      unless File.zero?("customers.yml")
      @customer_list = YAML.load_file("customers.yml")
      end
    end
  end

  def save
    File.open("customers.yml", "w") do |file|
      file.write(customer_list.to_yaml)
    end
  end

  def customer_list
    @customer_list
  end

  def customeridarray
    customer_list.each do |customer|
      if @customer_id_array.any? == false
        @customer_id_array << customer.id
      else
        unless @customer_id_array.include?(customer.id)
          @customer_id_array << customer.id
        end
      end
    end
  end

  def each(input, &block)
    customer_list.each(&block)
  end

  def run
    loop do
    puts "\n"
    puts "="*42
    puts "Welcome to the Customer Management Menu!"
    puts "Options:"
    puts "Add Customer: A".rjust(42)
    puts "Edit Customer: E".rjust(42)
    puts "Delete Customer: D".rjust(42)
    puts "Search Customers: S".rjust(42)
    puts "Print Customer List P".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
        print "\n Make your selection: "
        response = gets.chomp.downcase
        if response == "x"
          puts "\nGoodbye!"
          save
        break
        elsif response == "a"
          add_customer
        elsif response == "e"
          edit_customer
        elsif response == "d"
          delete_customers
        elsif response == "s"
          search_menu
        elsif response == "p"
          print_customers
        end
        puts "\n" * 10
      end
  end

  def add_customer
    customer = Customer.new
    customeridarray
    if @customer_id_array.any?
    customer.id = @customer_id_array.max + 1
    else
    customer.id = 1
    end
    print "\nFirst Name: "
    customer.first_name = gets.chomp.to_s
    print "Last Name: "
    customer.last_name = gets.chomp.to_s
    question = "Would you like to add a middle name? (Y/N) "
    print question
    response = yncheck(question)
    if response == "y"
    print "Middle Name: "
    customer.middle_name = gets.chomp.to_s
    end
    puts "\nSet Default Address: "
    customer.add_address
    puts "\nSet Default Phone Number: "
    customer.add_phone_number
    customer_list << customer
    customeridarray
  end

  def edit_customer
    print_customers
    customeridarray
    print "\nWhich customer would you like to edit?\nEnter ID: "
    edit = gets.chomp.to_i
    while !@customer_id_array.include?(edit)
    puts "Sorry! I don't see a customer with and ID of #{edit}.\nWhich customer would you like to edit?\nEnter Customer ID: "
    edit = gets.chomp.to_i
    end
    edit_menu(edit)
  end

  def edit_menu(edit)
    loop do
    puts "\n"
    puts "="*42
    puts "Edit Options: "
    puts "Edit Names: N".rjust(42)
    puts "Edit Phone Numbers: P".rjust(42)
    puts "Edit Addresses: A".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
    print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
      elsif response == "n"
        edit_name_menu(edit)
      elsif response == "p"
        edit_phone_number_menu(edit)
      elsif response == "a"
        edit_address_menu(edit)
      end
      puts "\n" * 10
    end
  end

  def edit_name_menu(edit)
    loop do
    puts "\n"
    puts "="*42
    puts "Edit Name Options: "
    puts "Edit First Name: F".rjust(42)
    puts "Edit Middle Name: M".rjust(42)
    puts "Edit Last Name: L".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
    print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
      elsif response == "f"
        customer_list.each do |customer|
          if customer.id == edit
          print "Old First Name: #{customer.first_name}"
          print "\nEnter New First Name: "
          response = gets.chomp
          customer.first_name = response
          end
        end
      elsif response == "f"
        customer_list.each do |customer|
          if customer.id == edit
          print "Old Middle Name: #{customer.middle_name}"
          print "\nEnter Middle Name: "
          response = gets.chomp
          customer.middle_name = response
          end
        end
      elsif response == "l"
        customer_list.each do |customer|
          if customer.id == edit
          print "Old Last Name: #{customer.last_name}"
          print "\nEnter Last Name: "
          response = gets.chomp
          customer.last_name = response
          end
        end
      end
          puts "\n" * 10
    end
  end

  def edit_phone_number_menu(edit)
    loop do
    puts "\n"
    puts "="*42
    puts "Edit Phone Number Options: "
    puts "Add Phone Number: A".rjust(42)
    puts "Delete Phone Number: D".rjust(42)
    puts "Edit Existing Phone Numbers: E".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
    print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
      elsif response == "a"
        add_new_phone_number(edit)
      elsif response == "d"
        delete_phone_number(edit)
      elsif response == "e"
        edit_phone_number_selector(edit)
      end
      puts "\n" * 10
    end
  end

  def add_new_phone_number(edit)
    customer_list.each do |customer|
      if customer.id == edit
        customer.add_phone_number
      end
    end
  end

  def delete_phone_number(edit)
    customer_list.each do |customer|
      if customer.id == edit
        customer.phone_numbers.each do |phone_number|
        puts "=" * 15
        puts "\nID: #{phone_number.id}\nLabel: #{phone_number.label}\nNumber: #{phone_number.number}\n"
        puts "=" * 15
        end
      end
    end
    print "\nWhich phone number would you like to delete? Enter ID: "
    phnid = gets.chomp.to_i
    customer_list.each do |customer|
      if customer.id == edit
        customer.phone_numbers.each do |phone_number|
          if phone_number.id == phnid
            customer.phone_numbers.delete(phone_number)
          end
        end
      end
    end
  end

  def edit_phone_number_selector(edit)
      customer_list.each do |customer|
      if customer.id == edit
        customer.phone_numbers.each do |phone_number|
          puts "=" * 15
          puts "\nID: #{phone_number.id}\nLabel: #{phone_number.label}\nNumber: #{phone_number.number}\n"
          puts "=" * 15
        end
      end
    end
    print "\nWhich phone number would you like to edit? Enter ID: "
    phnid = gets.chomp.to_i
    edit_phone_number_options(edit, phnid)
  end

  def edit_phone_number_options(edit, phnid)
    loop do
    puts "\n"
    puts "="*42
    puts "Edit Existing Phone Options: "
    puts "Edit Label: L".rjust(42)
    puts "Edit Number: N".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
    print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
      elsif response == "l"
      customer_list.each do |customer|
        if customer.id == edit
          customer.phone_numbers.each do |phone_number|
            if phone_number.id == phnid
              print "Old Label: #{phone_number.label}"
              print "\nEnter New Label: "
              response = gets.chomp
              phone_number.label = response
            end
          end
        end
      end
      elsif response == "n"
      customer_list.each do |customer|
        if customer.id == edit
          customer.phone_numbers.each do |phone_number|
            if phone_number.id == phnid
              print "Old Number: #{phone_number.number}"
              print "\nEnter New Number: "
              response = gets.chomp.gsub(/\s+/, "").tr("()-", '').to_s
              until response.length == 10
                print "That doesn't seem right... Enter New Number: "
                phone_number.number = gets.chomp.gsub(/\s+/, "").tr("()-", '').to_s
              end
              phone_number.number = response
            end
            end
          end
        end
      end
      puts "\n" * 10
    end
  end

  def edit_address_menu(edit)
    loop do
    puts "\n"
    puts "="*42
    puts "Edit Address Options: "
    puts "Add Address: A".rjust(42)
    puts "Delete Address: D".rjust(42)
    puts "Edit Existing Addresses: E".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
    print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
      elsif response == "a"
        add_new_address(edit)
      elsif response == "d"
        delete_address(edit)
      elsif response == "e"
        edit_address_selector(edit)
      end
      puts "\n" * 10
    end
  end

  def add_new_address(edit)
    customer_list.each do |customer|
      if customer.id == edit
        customer.add_address
      end
    end
  end

  def delete_address(edit)
    customer_list.each do |customer|
      if customer.id == edit
        customer.addresses.each do |address|
        puts "=" * 20
        puts "\n" + "ID: #{address.id}\n" + address.short + "\n"
        puts "=" * 20
        end
      end
    end
    print "\nWhich address would you like to delete? Enter ID: "
    addid = gets.chomp.to_i
    customer_list.each do |customer|
      if customer.id == edit
        customer.addresses.each do |address|
          if address.id == addid
            customer.addresses.delete(address)
          end
        end
      end
    end
  end

  def edit_address_selector(edit)
    customer_list.each do |customer|
      if customer.id == edit
        customer.addresses.each do |address|
          puts "=" * 20
          puts "\n" + "ID: #{address.id}\n" + address.short + "\n"
          puts "=" * 20
        end
      end
    end
    print "\nWhich address would you like to edit? Enter ID: "
    addid = gets.chomp.to_i
    edit_address_options(edit, addid)
  end

  def edit_address_options(edit, addid)
    loop do
    puts "\n"
    puts "="*42
    puts "Edit Address Options: "
    puts "Edit Name: N".rjust(42)
    puts "Edit Street Address: A".rjust(42)
    puts "Edit Unit/Apartment number: U".rjust(42)
    puts "Edit City: C".rjust(42)
    puts "Edit State: S".rjust(42)
    puts "Edit Zip: Z".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*42
    print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
      elsif response == "n"
      customer_list.each do |customer|
        if customer.id == edit
          customer.addresses.each do |address|
            if address.id == addid
              print "Old Address Name: #{address.name}"
              print "\nEnter New Address Name: "
              response = gets.chomp
              address.name = response
            end
          end
        end
      end
      elsif response == "a"
        customer_list.each do |customer|
          if customer.id == edit
            customer.addresses.each do |address|
              if address.id == addid
                print "Old Street Address: #{address.street_1}"
                print "\nEnter New Street Address: "
                response = gets.chomp
                address.street_1 = response
              end
            end
          end
        end
      elsif response == "u"
        customer_list.each do |customer|
          if customer.id == edit
            customer.addresses.each do |address|
              if address.id == addid
                print "Old Unit/Apartment #: #{address.street_2}"
                print "\nEnter New Unit/Apartment #: "
                response = gets.chomp
                address.street_2 = response
              end
            end
          end
        end
      elsif response == "c"
      customer_list.each do |customer|
        if customer.id == edit
          customer.addresses.each do |address|
            if address.id == addid
              print "Old City: #{address.city}"
              print "\nEnter New City: "
              response = gets.chomp
              address.city = response
            end
          end
        end
      end
      elsif response == "s"
      customer_list.each do |customer|
        if customer.id == edit
          customer.addresses.each do |address|
            if address.id == addid
              print "Old State: #{address.state}"
              print "\nEnter New State: "
              response = gets.chomp
              address.state = response
            end
          end
        end
      end
      elsif response == "z"
      customer_list.each do |customer|
        if customer.id == edit
          customer.addresses.each do |address|
            if address.id == addid
              print "Old Zip: #{address.postal_code}"
              print "\nEnter New Zip: "
              response = gets.chomp
              address.postal_code = response
            end
          end
        end
      end
    end
    puts "\n" * 10
  end
  end

  def search_menu
    loop do
    puts "\n"
    puts "="*25
    puts "Search Options: "
    puts "Search Name: N".rjust(42)
    puts "Search Phone Number: B".rjust(42)
    puts "Search Address: A".rjust(42)
    puts "Search ID: I".rjust(42)
    puts "Exit: X".rjust(42)
    puts "="*25
    print "\n Make your selection: "
      response = gets.chomp.downcase
      if response == "x"
      break
      elsif response == "n"
        print "Enter Name: "
        search = gets.chomp.downcase
        find_by_name(search)
      elsif response == "b"
        print "Enter Number: "
        search = gets.chomp.downcase
        find_by_number(search)
      elsif response == "a"
        print "Enter Address Part: "
        search = gets.chomp.downcase
        find_by_address(search)
      elsif response == "i"
        print "Enter ID: "
        search = gets.chomp.to_i
        find_by_id(search)
      end
      puts "\n" * 10
    end
  end

  def find_by_id(search)
    results = []
    customer_list.each do |customer|
      if customer.id == search
        results << customer
      end
    end
    print_results(results)
  end

  def find_by_address(search)
    results = []
    customer_list.each do |customer|
      customer.addresses.each do |address|
        if address.long.downcase.include?(search)
          results << customer
        end
      end
    end
    print_results(results)
  end

  def find_by_name(search)
    results = []
    customer_list.each do |customer|
      if customer.full_name.downcase.include?(search)
        results << customer
      end
    end
    print_results(results)
  end

  def find_by_number(search)
    results = []
    customer_list.each do |customer|
      customer.phone_numbers.each do |phone_number|
        if phone_number.to_s.include?(search)
          results << customer
        end
      end
    end
    print_results(results)
  end

  def delete_customers
    print_customers
    customeridarray
    print "\nWhich customer would you like to delete?\nEnter ID: "
    deleted = gets.chomp.to_i
    while !@customer_id_array.include?(deleted)
    puts "Sorry! I don't see a customer with and ID of #{deleted}.\nWhich customer would you like to delete?\nEnter ID: "
    deleted = gets.chomp.to_i
    end
    find_by_id(deleted)
    question = "Are you sure you want to delete this customer? (Y/N)"
    print "\n" + question
    response = yncheck(question)
    unless response == 'n'
    delete_customer(deleted)
    end
  end

  def delete_customer(id)
    customer_list.each do |customer|
      if customer.id == id
        @customer_list.delete(customer)
      end
    end
  end

  def print_results(results)
    results.each do |customer|
      puts "=" * 30
      puts "\nName:\n#{customer.full_name}"
      puts "\nPhone Numbers: "
      customer.phone_numbers.each do |phone_number|
        puts "ID: #{phone_number.id}\tLabel: #{phone_number.label}\tNumber: #{phone_number.number}"
      end
      puts "\nAddresses: "
      customer.addresses.each do |address|
        puts "Address: #{address.short}"
      end
      puts "\n"
      puts "=" * 30
    end
  end

  def print_customers
    puts "=" * 65
    puts "=" * 65
    variable = 0
    customer_list.each do |customer|
      puts "\nName: #{customer.full_name}"
      puts "\nID: #{customer.id}\n\n"
      variable += 1
        customer.phone_numbers.each do |phone_number|
          puts "ID: #{phone_number.id} Label: #{phone_number.label}\tNumber: #{phone_number.number}"
        end
        customer.addresses.each do |address|
          puts "ID: #{address.id} Address: #{address.short}"
        end
      if variable != customer_list.length
      puts "\n" + "+"*49 + "\n"
      end
    end
    puts "\n"
    puts "=" * 65
    puts "=" * 65
  end

end

customer = CustomerBook.new
customer.run
