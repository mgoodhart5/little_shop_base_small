require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  end

  describe 'relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
    it { should have_many :reviews }
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
    it '.subtotal' do
      oi = create(:order_item, quantity: 5, price: 3)

      expect(oi.subtotal).to eq(15)
    end
    it '.review_description' do
      user = create(:user, name: "Mary")
      item = create(:item)
      order = create(:completed_order)
      oi_1 = create(:fulfilled_order_item, order: order, item: item, created_at: 4.days.ago, updated_at: 1.days.ago)
      review = Review.create(title: "yay", description: "great", rating: 4, order_item: oi_1, user: user)
      final = oi_1.review_description

      expect(final).to eq(review.description)
    end
  end
end
