require 'rails_helper'

describe 'when a user sees their order show page with items reviewed by them' do
  before(:each) do
    @user = create(:user, name: "Mary")
    @merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant)
    @item_2 = create(:item, user: @merchant)
    @yesterday = 1.day.ago
    @order = create(:completed_order, user: @user)
    @oi_1 = create(:fulfilled_order_item, order: @order, item: @item_1, price: 1, quantity: 1, created_at: @yesterday, updated_at: @yesterday)
    @oi_2 = create(:fulfilled_order_item, order: @order, item: @item_2, price: 2, quantity: 1, created_at: @yesterday, updated_at: 2.hours.ago)
    @review = Review.create(title: "yay", description: "great", rating: 4, item: @item_1, user: @user)
    @review = Review.create(title: "yay", description: "great", rating: 4, item: @item_2, user: @user)
  end
  it 'sees a button to disable that review' do

    visit profile_order_path(@order)

    within "#oitem-#{@oi_1.id}" do
      expect(page).to_not have_button('Leave Review')
    end
    within "#oitem-#{@oi_1.id}" do
      expect(page).to have_button('Disable Review')
    end
  end
  
end
