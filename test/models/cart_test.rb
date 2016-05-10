require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :products
  
  def new_cart_with_one_product(product_name)
  	cart = Cart.create
  	cart.add_product(products(product_name).id)
  	cart
  end

  test "cart should create a new line item" do
  	cart = new_cart_with_one_product(:one)
  	puts '1 Line Items: '
  	puts cart.line_items
  	assert_equal 1, cart.line_items.size

  	cart.add_product(products(:ruby).id)
  	puts '2 Line Items: '
  	puts cart.line_items
  	assert_equal 2, cart.line_items.size

  	cart.add_product(products(:one).id)
  	puts '3 Line Items: '
  	puts cart.line_items
  	assert_equal 2, cart.line_items.size
  end
end
