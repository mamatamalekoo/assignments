class DeliveryBatch
  include Enumerable
  attr_accessor :shopper, :shopping_list, :warehouse_name

  def shopper
    @shopper
  end

  def shopping_list
    @shopping_list
  end

  def warehouse_name
    @warehouse_name
  end

end
