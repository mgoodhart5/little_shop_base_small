require 'rails_helper'

describe 'as a user on an order show page when i have disabled a review' do
  before(:each) do
    @user = create(:user, name: "Mary")
    @merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant)
    @item_2 = create(:item, user: @merchant)
    @yesterday = 1.day.ago
    @order = create(:completed_order, user: @user)
    @oi_1 = create(:fulfilled_order_item, order: @order, item: @item_1, price: 1, quantity: 1, created_at: @yesterday, updated_at: @yesterday)
    @oi_2 = create(:fulfilled_order_item, order: @order, item: @item_2, price: 2, quantity: 1, created_at: @yesterday, updated_at: 2.hours.ago)
    @review = Review.create(title: "yay", description: "great", rating: 4, order_item: @oi_1, user: @user, status: false)
    @review_1 = Review.create(title: "hooray", description: "great", rating: 4, order_item: @oi_2, user: @user, status: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'sees a button to enable that review' do

    visit profile_order_path(@order)

    within "#oitem-#{@oi_2.id}-review" do
      expect(page).to_not have_button('Enable Review')
    end

    within "#oitem-#{@oi_1.id}-review" do
      expect(page).to have_button('Enable Review')
    end
  end
  it 'clicks on the button and the review is shown again on the item show page' do
    visit profile_order_path(@order)

    within "#oitem-#{@oi_1.id}-review" do
      click_button 'Enable Review'
    end

    expect(current_path).to eq(profile_order_path(@order))

    expect(page).to have_content("You enabled your review for #{@oi_1.item.name}!")

    visit item_path(@item_1)

    within "#review-0" do
      expect(page).to_not have_content('No reviews currently')
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@review.description)
      expect(page).to have_content("Rating: #{@review.rating}")
      expect(page).to have_content(@review.title)
      expect(page).to have_link("Return to Orders")
    end
  end
end
