class NameValidator < ActiveModel::EachValidator
	def validate_each record, attribute, value
		not_name = /([^0-9])/
		if value =~ not_name
			record.errors[attribute] = "can not contain numbers"
		end
	end
end
class Product < ActiveRecord::Base
	scope :of_category, ->(category_id) {where("category_id = ?", category_id)}
	scope :of_similar_price, ->(price) {where("price > ? and price < ?", price - price * 0.25, price + price * 0.25)}
	belongs_to :category

	validates :name, presence: true
	validates :description, presence: true
	validates :price, presence: true, numericality: {only_float: true}

	def related_products
		Product.of_category(self.category_id).of_similar_price(self.price)
	end

end
