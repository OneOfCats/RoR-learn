class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		puts '<add_product>'
		puts 'current id: '
		puts product_id
		puts 'existing line items id: '
		product = Product.find(product_id)
		line_items.each do |item|
			puts item.product_id
		end
		current_item = line_items.find_by_product_id(product_id)
		puts 'current item: '
		puts current_item
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id)
			current_item.price = product.price
		end
		puts '</add_product>'
		current_item
	end

	def total_price
		line_items.to_a.sum {|item| item.total_price}
	end
end
