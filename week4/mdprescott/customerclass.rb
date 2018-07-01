require "./phonenumberclass"
require "./addressclass"
require "./moduleyesno"

class Customer
  include YesNo
  attr_accessor :id, :first_name, :middle_name, :last_name, :phone_numbers, :addresses, :phone_number_id_array, :address_id_array

  def initialize
    @phone_numbers = []
    @addresses = []
    @phone_number_id_array = []
    @address_id_array = []
  end

  def id
    @id
  end

  def first_name
    @first_name
  end

  def middle_name
    @middle_name
  end

  def last_name
    @last_name
  end

  def phone_numbers
    @phone_numbers
  end

  def addresses
    @addresses
  end

  def phonenumberidarray
    phone_numbers.each do |phone_number|
      if @phone_number_id_array.any? == false
        @phone_number_id_array << phone_number.id
      else
        unless @phone_number_id_array.include?(phone_number.id)
          @phone_number_id_array << phone_number.id
        end
      end
    end
  end

  def addressidarray
    addresses.each do |address|
      if @address_id_array.any? == false
        @address_id_array << address.id
      else
        unless @address_id_array.include?(address.id)
          @address_id_array << address.id
        end
      end
    end
  end

  def full_name
    full_name = first_name + " "
    if !middle_name.nil?
      full_name += middle_name + " "
    end
    full_name += last_name
  end

  def first_last
    first_last = first_name
    first_last += " " + last_name
  end

  def first_last_short
    first_last_short = first_name
    first_last_short += " " + last_name.slice(0,1)
  end

  def last_first
    last_first = last_name
    last_first += ", " + first_name
      if !middle_name.nil?
        last_first += " " + middle_name.slice(0,1)
      end
  end

  def add_phone_number
    phone_number = PhoneNumber.new
    phonenumberidarray
    if phone_number_id_array.any?
    phone_number.id = address_id_array.max + 1
    else
    phone_number.id = 1
    end
    print "Enter Type (Work, Cell, Home, etc): "
    phone_number.label = gets.chomp.to_s
    print "Enter Number: "
    phone_number.number = gets.chomp.gsub(/\s+/, "").tr("()-", '').to_s
      until phone_number.number.length == 10
        print "That doesn't seem right... Enter Number: "
        phone_number.number = gets.chomp.gsub(/\s+/, "").tr("()-", '').to_s
      end
    phone_numbers << phone_number
    phonenumberidarray
  end

  def add_address
    address = Address.new
    addressidarray
    if address_id_array.any?
    address.id = address_id_array.max + 1
    else
    address.id = 1
    end
    print "Enter Address Name (Home, Work, Grandma's House, etc): "
    address.name = gets.chomp.to_s
    print "Enter Street Address: "
    address.street_1 = gets.chomp.to_s
    print question = "Do you need to add an apartment or unit number? (Y/N)"
    response = yncheck(question)
      if response == "y"
        print "Enter Apartment/Unit Number: "
        address.street_2 = gets.chomp.to_s
      end
    print "Enter City: "
    address.city = gets.chomp.to_s
    print "Enter State: "
    address.state = gets.chomp.to_s
    print "Enter 5-digit Zip: "
    address.postal_code = gets.chomp.to_s
    until address.postal_code.length == 5
      print "That doesn't seem right... Enter 5-digit Zip: "
      address.postal_code = gets.chomp.gsub(/\s+/, "").tr("()-", '').to_s
    end
    addresses << address
    addressidarray
  end

  def to_s(format = "full_name")
    case format
    when "first"
      first_name
    when "last"
      last_name
    when "middle"
      middle_name
    when "first_last"
      first_last
    when "last_first"
      last_first
    when "first_last_short"
      first_last_short
    when "full_name"
      full_name
    else
      full_name
    end
  end

end
