require 'rails_helper'

describe 'when a user is on the item index page' do
  before(:each) do
    @user = create(:user, name: "Mary")
    @merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant)
    @yesterday = 1.day.ago
    @order = create(:completed_order, user: @user)
    @oi_1 = create(:fulfilled_order_item, order: @order, item: @item_1, price: 1, quantity: 1, created_at: @yesterday, updated_at: @yesterday)
    @review = Review.create(title: "yay", description: "great", rating: 4, order_item: @oi_1, user: @user, status: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'can see a reviews link for each item' do
    visit items_path

    within "#item-#{@item_1.id}" do
      expect(page).to have_link('Reviews')
    end
  end
  it 'can click on the Reviews and be taken to the item show page' do
    visit items_path

    within "#item-#{@item_1.id}" do
      click_link('Reviews')
    end

    expect(current_path).to eq(item_path(@item_1))

    within "#review-0" do
      expect(page).to have_content(@review.title)
      expect(page).to have_content(@review.description)
      expect(page).to have_content("Rating: #{@review.rating}")
      expect(page).to have_content(@review.user.name)
      expect(page).to have_link("Return to Orders")
    end
  end
end
