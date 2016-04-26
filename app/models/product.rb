class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	validates :title, length: {minimum: 2}

	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present') # Ассоциировать ошибку с объектом base. Хз зачем
			return false
		end
	end

	def self.latest
		Product.order(:updated_at).last
	end
end
