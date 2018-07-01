class OrderItem
  include Enumerable
  attr_accessor :item, :quantity, :warehouse_id

  def initialize
    @item = ""
    @quantity = ""
  end

  def item
    @item
  end

  def quantity
    @quantity
  end

  def price
    @quantity * @item.price
  end

  def price_round
    price.round(2)
  end

  def price_format
    sprintf("%0.2f", price_round)
  end
end
