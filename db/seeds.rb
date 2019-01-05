require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

Review.destroy_all
OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all


admin = create(:admin, name: "Mary", email: "admin@gmail.com", password: "123")
user = create(:user, name: "Mia Wallace", email: "m@gmail.com", password: "123")
merchant_1 = create(:merchant, name: "Steve O", email: "merchant@gmail.com", password: "123")

merchant_2, merchant_3, merchant_4 = create_list(:merchant, 3)

inactive_merchant_1 = create(:inactive_merchant)
inactive_user_1 = create(:inactive_user)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
item_3 = create(:item, user: merchant_3)
item_4 = create(:item, user: merchant_4)
create_list(:item, 10, user: merchant_1)

inactive_item_1 = create(:inactive_item, user: merchant_1)
inactive_item_2 = create(:inactive_item, user: inactive_merchant_1)

Random.new_seed
rng = Random.new

order = create(:completed_order, user: user)
order_item_1 = create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: rng.rand(3).days.ago, updated_at: rng.rand(59).minutes.ago)
order_item_2 = create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)
order_item_3 = create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: rng.rand(5).days.ago, updated_at: rng.rand(59).minutes.ago)
order_item_4 = create(:fulfilled_order_item, order: order, item: item_4, price: 4, quantity: 1, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:order, user: user)
order_item_5 = create(:order_item, order: order, item: item_1, price: 1, quantity: 1)
order_item_6 = create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: rng.rand(23).days.ago, updated_at: rng.rand(23).hours.ago)

order = create(:cancelled_order, user: user)
order_item_7 = create(:order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)
order_item_8 = create(:order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user)
order_item_9 = create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: rng.rand(4).days.ago, updated_at: rng.rand(59).minutes.ago)
order_item_10 = create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: rng.rand(23).hour.ago, updated_at: rng.rand(59).minutes.ago)

Review.create(title: "yay", description: "great", rating: 4, order_item: order_item_1, user: user,  status: true)
Review.create(title: "no", description: "this was terrible", rating: 1, order_item: order_item_3, user: user,  status: false)
Review.create(title: "fabulous", description: "the best ever", rating: 5, order_item: order_item_10, user: user,  status: true)
