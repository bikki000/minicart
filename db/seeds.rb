# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
img1 = File.open(File.join(Rails.root, 'public/system/default/avatar01.png'))
# img2 = File.open(File.join(Rails.root, 'public/system/default/avatar02.png'))
# img3 = File.open(File.join(Rails.root, 'public/system/default/avatar03.png'))
# img4 = File.open(File.join(Rails.root, 'public/system/default/avatar04.png'))
# img5 = File.open(File.join(Rails.root, 'public/system/default/rails.png'))
images = []
images << {image: img1, default: true}
# images << {image: img2, default: false}
# images << {image: img3, default: false}
# images << {image: img4, default: false}
# images << {image: img5, default: false}

categories = []
categories << { name: "electronics" }
categories << { name: "men" }
categories << { name: "women" }
categories << { name: "baby & kids" }
categories << { name: "appliances" }
categories << { name: "home & furniture" }
categories << { name: "sports" }
Category.create(categories)
puts "created all categories"

Category.all.each do |category|
	
	20.times do
		pr = category.products.create(
			name: "#{Faker::Device.manufacturer} #{Faker::Device.model_name}",
			description: Faker::Lorem.sentence(20),
			price: Faker::Number.decimal(rand(3..4), 2)
			)
		puts "create product id: #{pr.id} for category: #{pr.category.name}"
	end
end

users = []
users << { name: "Tanveer Ahmad Khan",
					 email: "tnvr000@gmail.com",
					 contact_no: "8594976909",
					 password: "password"
					}
users << { name: "Tahir Ahmad Khan",
					 email: "tahirrockheart@gmail.com",
					 contact_no: "9453887151",
					 password: "password"
					}
users << { name: "Tarannum Ara",
					 email: "rikkisneha@gmail.com",
					 contact_no: "9889579786",
					 password: "password"
					}
users << { name: "Imteyaz Ahmad Khan",
					 email: "imteyaz588@gmail.com",
					 contact_no: "8825248586",
					 password: "password"
					}
User.create(users)
puts "created all users(#{User.all.count})"

User.all.each do |user|
	a = user.addresses.create(
		plot: "plot no. #{Faker::Address.building_number}",
		lane: Faker::Address.street_name,
		landmark: Faker::Address.community,
		city: Faker::Address.city,
		state: Faker::Address.state,
		pincode: Faker::Number.number(6),
		default: true
		)
	puts "created address id #{a.id}"

	5.times do
		order = user.orders.create(
			address_id: user.default_address.id
		)
		puts "created order id #{order.id}"
		3.times do
			pr = Product.find(rand(1..140))
			bi = order.billing_items.create(
				product_id: pr.id,
				quantity: rand(1..3),
				product_price: pr.price
			)
			puts "created billing item id: #{bi.id}"
		end
	end

	cart = user.create_cart
	puts "create cart id: #{cart.id}"
	5.times do 
		pr = Product.find(rand(1..140))
		ci = cart.cart_items.create(
			product_id: pr.id,
			quantity: rand(1..3)
		)
		puts "created cart item id: #{ci.id}"
	end
end

Product.all.each do |product|
	# images[rand(0..4)][:default] = true
	images.each do |image|
		img = product.images.create(image)
		puts "Created image #{img.id} for product id #{product.id}"
	end
	# images[d][:default] = false
end