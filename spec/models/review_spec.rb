require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :rating }
  end

  describe 'relationships' do
    it { should belong_to :user }
    # it { should belong_to :item }
    it { should belong_to :order_item }
  end

  describe 'Instance Methods' do
    it '.user_name' do
      user = create(:user, name: "Mary")
      item = create(:item)
      o_item = create(:order_item, item: item, quantity: 5, price: 3)
      review = Review.create(title: "yay", description: "great", rating: 4, order_item: o_item, user: user)

      name = "Mary"

      expect(review.user_name).to eq(name)
    end
  end
  describe 'Class Methods' do
    it '#enabled_reviews' do
      user = create(:user, name: "Mary")
      item = create(:item)
      item_2 = create(:item)
      order = create(:completed_order)
      oi_1 = create(:fulfilled_order_item, order: order, item: item, created_at: 4.days.ago, updated_at: 1.days.ago)
      oi_2 = create(:fulfilled_order_item, order: order, item: item_2, created_at: 4.days.ago, updated_at: 1.days.ago)
      oi_3 = create(:fulfilled_order_item, order: order, item: item, created_at: 4.days.ago, updated_at: 1.days.ago)
      oi_4 = create(:fulfilled_order_item, order: order, item: item_2, created_at: 4.days.ago, updated_at: 1.days.ago)
      review_2 = Review.create(title: "better", description: "fun", rating: 4, order_item: oi_1, user: user, status: false)
      review_3 = Review.create(title: "better", description: "fun", rating: 4, order_item: oi_3, user: user)
      review_4 = Review.create(title: "better", description: "fun", rating: 4, order_item: oi_2, user: user, status: false)
      review_5 = Review.create(title: "better", description: "fun", rating: 4, order_item: oi_4, user: user)
      final = Review.enabled_reviews(item)
      final_2 = Review.enabled_reviews(item_2)

      expect(final).to eq([review_3])
      expect(final_2).to eq([review_5])
    end
  end
end
