require 'rails_helper'

describe 'when a user visits the item show page' do
  before(:each) do
    @user = create(:user, name: "Mary")
    @user_2 = create(:user, name: "Leigh")
    @merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant)
    @yesterday = 1.day.ago
    @order = create(:completed_order, user: @user)
    @oi_1 = create(:fulfilled_order_item, order: @order, item: @item_1, price: 1, quantity: 1, created_at: @yesterday, updated_at: @yesterday)
    @review = Review.create(title: "yay", description: "great", rating: 4, order_item: @oi_1, user: @user, status: true)
    @order_2 = create(:completed_order, user: @user_2)
    @oi_2 = create(:fulfilled_order_item, order: @order_2, item: @item_1, price: 1, quantity: 1, created_at: @yesterday, updated_at: @yesterday)
    @review_2 = Review.create(title: "wonderful", description: "the best", rating: 5, order_item: @oi_2, user: @user_2, status: true)
    @review_2 = Review.create(title: "ok", description: "N.O.", rating: 1, order_item: @oi_2, user: @user_1, status: false)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'sees the average review rating for that item for only enabled reviews' do

    visit item_path(@item_1)

    expect(page).to have_content("Average Rating: 4.5")
  end
end
