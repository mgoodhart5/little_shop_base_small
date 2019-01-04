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
    @review = Review.create(title: "yay", description: "great", rating: 4, item: @item_1, user: @user, status: true)
    @review_1 = Review.create(title: "hooray", description: "great", rating: 4, item: @item_2, user: @user, status: true)
  end
  it 'sees a button to disable that review' do

    visit profile_order_path(@order)

    within "#oitem-#{@review.id}-review" do
      expect(page).to_not have_button('Leave Review')
    end

    within "#oitem-#{@review.id}-review" do
      expect(page).to have_button('Disable Review')
    end
  end
  it 'clicks on the button and the review is not shown on the item show page' do
    visit profile_order_path(@order)

    within "#oitem-#{@review.id}-review" do
      click_button 'Disable Review'
    end

    expect(current_path).to eq(profile_path(@user))

    expect(page).to have_content("You disabled your review for #{@item_1.name}!")

    visit item_path(@item_1)

    within "#review-0" do
      expect(page).to have_content('No reviews currently')
    end
  end
end
