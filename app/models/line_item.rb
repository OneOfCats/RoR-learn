class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def total_price
  	price * quantity
  end

  def get_price
  	product.price
  end
end
