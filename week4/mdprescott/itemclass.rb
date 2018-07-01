class Item
  attr_accessor :id, :name, :price, :type

  def id
    @id
  end

  def name
    @name
  end

  def price
    @price
  end

  def type
    @type
  end

  def to_s
    "ID: #{id}, #{name}, #{price}, #{type}"
  end
end
