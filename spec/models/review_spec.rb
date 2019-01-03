require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :rating }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :item }
  end

  describe 'Instance Methods' do
    it '.user_name' do
      user = create(:user, name: "Mary")
      item = create(:item)
      review = Review.create(title: "yay", description: "great", rating: 4, item: item, user: user)
      user.reviews << review

      name = "Mary"

      expect(review.user_name).to eq(name)
    end
  end
end
