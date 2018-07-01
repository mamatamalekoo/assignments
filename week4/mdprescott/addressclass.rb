class Address
  attr_accessor :id, :name, :street_1, :street_2, :city, :state, :postal_code

  def id
    @id
  end

  def name
    @name
  end

  def street_1
    @street_1
  end

  def street_2
    @street_2
  end

  def city
    @city
  end

  def state
    @state
  end

  def postal_code
    @postal_code
  end

  def short
    address = street_1
    if street_2
      address += " " + street_2
    end
    address += ", #{city}, #{state} #{postal_code}"
  end

  def long
    address = "#{name}:" + "\n" + street_1
    if street_2
      address += " " + street_2
    end
    address += "\n" + "#{city}, #{state} #{postal_code}"
  end

end
